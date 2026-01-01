import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(home: NewsScreen(), debugShowCheckedModeBanner: false));
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List articles = [];
  bool isLoading = false;
  TextEditingController _searchController = TextEditingController(
    text: "india",
  );

  @override
  void initState() {
    super.initState();
    fetchNews("india");
  }

  Future<void> fetchNews(String query) async {
    setState(() {
      isLoading = true;
    });

    const String apiKey = '3671ac5c81dd4838bbd9c71b2fa58de5';
    final String url =
        'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          articles = data['articles'];
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error fetching news: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open the news')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Feed")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Enter country code or topic",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    fetchNews(_searchController.text.trim());
                  },
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: article['urlToImage'] != null
                              ? Image.network(
                            article['urlToImage'],
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                              : Container(
                            height: 250,
                            color: Colors.grey,
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 80,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article['title'] ?? 'No title',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                article['description'] ??
                                    'No description',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (article['url'] != null) {
                                      _launchURL(article['url']);
                                    }
                                  },
                                  icon: const Icon(Icons.open_in_new),
                                  label: const Text("Read More"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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