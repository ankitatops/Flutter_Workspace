import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WeatherApp(),
  ));
}

class WeatherApp extends StatefulWidget {
  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _cityController = TextEditingController();
  String _weatherInfo = "";

  Future<void> fetchWeather(String city) async {
    try {
      var geoUrl =
          'https://geocoding-api.open-meteo.com/v1/search?name=$city';
      var geoRes = await http.get(Uri.parse(geoUrl));
      var geoData = jsonDecode(geoRes.body);

      if (geoData['results'] != null && geoData['results'].isNotEmpty) {
        var lat = geoData['results'][0]['latitude'];
        var lon = geoData['results'][0]['longitude'];

        var weatherUrl =
            'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&timezone=auto';
        var weatherRes = await http.get(Uri.parse(weatherUrl));
        var weatherData = jsonDecode(weatherRes.body);

        var current = weatherData['current_weather'];

        setState(() {
          _weatherInfo =
          "City: $city\n\n"
              "Temperature: ${current['temperature']} °C\n"
              "Wind Speed: ${current['windspeed']} km/h\n"
              "Wind Direction: ${current['winddirection']}°\n"
              "Time: ${current['time']}";
        });
      } else {
        setState(() {
          _weatherInfo = "City not found";
        });
      }
    } catch (e) {
      setState(() {
        _weatherInfo = "Error fetching weather";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.lightBlue,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                Text(
                  "Weather Forecast",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 25),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: "Enter city name",
                    prefixIcon: Icon(Icons.location_on, color: Colors.blue),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      fetchWeather(_cityController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Check Weather",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),

                SizedBox(height: 25),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Text(
                          _weatherInfo.isEmpty
                              ? "weather details"
                              : _weatherInfo,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
