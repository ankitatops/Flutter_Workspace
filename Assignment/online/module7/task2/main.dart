import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SimpleNewsApp(),
  ));
}

class SimpleNewsApp extends StatefulWidget {
  const SimpleNewsApp({super.key});

  @override
  State<SimpleNewsApp> createState() => _SimpleNewsAppState();
}

class _SimpleNewsAppState extends State<SimpleNewsApp> {
  List news = [];
  bool loading = false;
  TextEditingController searchCtrl = TextEditingController(text: "india");

  @override
  void initState() {
    super.initState();
    getNews("india");
  }

  Future<void> getNews(String keyword) async {
    setState(() => loading = true);

    const apiKey = "3671ac5c81dd4838bbd9c71b2fa58de5";
    final url =
        "https://newsapi.org/v2/everything?q=$keyword&apiKey=$apiKey";

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    setState(() {
      news = data['articles'];
      loading = false;
    });
  }

  void openNews(String link) async {
    final uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple News")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchCtrl,
                    decoration: const InputDecoration(
                      hintText: "Search topic",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    getNews(searchCtrl.text.trim());
                  },
                  child: const Icon(Icons.search),
                )
              ],
            ),
          ),

          Expanded(
            child: loading
                ? const Center(child: Text("Loading news..."))
                : ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                final item = news[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ExpansionTile(
                    leading: item['urlToImage'] != null
                        ? Image.network(
                      item['urlToImage'],
                      width: 60,
                      fit: BoxFit.cover,
                    )
                        : const Icon(Icons.image),
                    title: Text(
                      item['title'] ?? "No title",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          item['description'] ??
                              "No description available",
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (item['url'] != null) {
                            openNews(item['url']);
                          }
                        },
                        child: const Text("Read Full News"),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
