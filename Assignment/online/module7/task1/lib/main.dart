import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController cityCtrl = TextEditingController();
  bool loading = false;
  String city = "";
  String country = "";
  double? temp;
  double? windSpeed;
  double? windDir;
  String time = "";

  Future<void> loadWeather() async {
    final cityName = cityCtrl.text.trim();
    if (cityName.isEmpty) return;

    setState(() => loading = true);

    try {
      final geo = await _getLatLon(cityName);
      if (geo == null) {
        _reset(error: true);
        return;
      }

      final weather = await _getWeather(geo['lat'], geo['lon']);

      setState(() {
        city = geo['name'];
        country = geo['country'];
        temp = weather['temperature'];
        windSpeed = weather['windspeed'] * 3.6; // m/s → km/h
        windDir = weather['winddirection'];
        time = weather['time'];
        loading = false;
      });
    } catch (e) {
      _reset(error: true);
    }
  }

  Future<Map<String, dynamic>?> _getLatLon(String city) async {
    final cityEncoded = Uri.encodeComponent(city);
    final url =
        "https://geocoding-api.open-meteo.com/v1/search?name=$cityEncoded&count=1";

    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) return null;

    final data = jsonDecode(res.body);

    if (data['results'] == null || (data['results'] as List).isEmpty) return null;

    final firstResult = data['results'][0];
    return {
      "lat": firstResult['latitude'],
      "lon": firstResult['longitude'],
      "name": firstResult['name'],
      "country": firstResult['country'],
    };
  }

  Future<Map<String, dynamic>> _getWeather(double lat, double lon) async {
    final url =
        "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&timezone=auto";

    final res = await http.get(Uri.parse(url));
    final data = jsonDecode(res.body);
    return data['current_weather'];
  }

  void _reset({bool error = false}) {
    setState(() {
      loading = false;
      city = error ? "City not found" : "";
      country = "";
      temp = null;
      windSpeed = null;
      windDir = null;
      time = "";
    });
  }

  @override
  void dispose() {
    cityCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cityCtrl,
                    decoration: const InputDecoration(
                      hintText: "Enter city name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.search, size: 30),
                  onPressed: loadWeather,
                )
              ],
            ),
            const SizedBox(height: 20),
            loading
                ? const CircularProgressIndicator()
                : city == "City not found"
                ? const Text(
              "City not found",
              style: TextStyle(color: Colors.red),
            )
                : temp == null
                ? const Text("Search city to see weather")
                : Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "$city, $country",
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                        "🌡 Temperature: ${temp!.toStringAsFixed(1)} °C"),
                    Text(
                        "💨 Wind Speed: ${windSpeed!.toStringAsFixed(1)} km/h"),
                    Text("🧭 Wind Direction: $windDir°"),
                    const SizedBox(height: 10),
                    Text("⏰ $time"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
