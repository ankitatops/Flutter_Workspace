import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MovieSearchPage(),
  ));
}

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  TextEditingController searchCtrl = TextEditingController();
  Future<Map<String, dynamic>>? movieFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Finder"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                labelText: "Movie name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (searchCtrl.text.isNotEmpty) {
                      setState(() {
                        movieFuture = fetchMovie(searchCtrl.text);
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(child: buildResult()),
        ],
      ),
    );
  }

  Widget buildResult() {
    if (movieFuture == null) {
      return const Center(child: Text("Enter movie name to search"));
    }

    return FutureBuilder<Map<String, dynamic>>(
      future: movieFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Fetching movie data..."));
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Movie not found"));
        }

        final movie = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            elevation: 6,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                movie["Poster"] != "N/A"
                    ? Image.network(movie["Poster"], height: 220)
                    : const Icon(Icons.movie, size: 120),
                const SizedBox(height: 12),
                Text(
                  movie["Title"],
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text("Year : ${movie["Year"]}"),
                Text("Genre : ${movie["Genre"]}"),
                Text("Rating : ${movie["imdbRating"]} ⭐"),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Map<String, dynamic>> fetchMovie(String name) async {
    final url =
    Uri.parse("http://www.omdbapi.com/?apikey=b443b00b&t=$name");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["Response"] == "True") {
        return data;
      } else {
        throw Exception("Movie not found");
      }
    } else {
      throw Exception("Error fetching movie");
    }
  }
}
