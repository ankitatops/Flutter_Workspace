import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'news_service.dart';
import 'article.dart';


void main() {
  runApp(NewsFeedApp());
}

class NewsFeedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Feed App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NewsFeedScreen(),debugShowCheckedModeBanner: false,
    );
  }
}

class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  late Future<List<Article>> _articles;

  @override
  void initState() {
    super.initState();
    _articles = NewsService().fetchArticles();
  }

  _openArticle(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Feed')),
      body: FutureBuilder<List<Article>>(
        future: _articles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No articles found.'));
          }

          List<Article> articles = snapshot.data!;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: article.urlToImage != ''
                      ? Image.network(
                    article.urlToImage,
                    width: 80,
                    fit: BoxFit.cover,
                  )
                      : SizedBox.shrink(),
                  title: Text(article.title),
                  subtitle: Text(article.description),
                  onTap: () => _openArticle(article.url),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
