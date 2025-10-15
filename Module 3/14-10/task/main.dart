import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
void main()
{
  runApp(MaterialApp(home:NameListScreen(),debugShowCheckedModeBanner: false,));
}

class NameListScreen extends StatefulWidget {
  @override
  _NameListScreenState createState() => _NameListScreenState();
}

class _NameListScreenState extends State<NameListScreen> {
  List<String> names = [
    'Carrot',
    'Broccoli',
    'Potato',
    'Tomato',
    'Cucumber',
    'Spinach',
    'Onion',
    'Garlic',
    'Lettuce',
    'Pepper',
    'Pumpkin',
    'Beetroot',
    'Cauliflower',
    'Radish',
  ];

  List<String> filteredNames = [];
  double appBarRating = 0;

  @override
  void initState() {
    super.initState();
    filteredNames = names;
  }

  void filterSearch(String query) {
    setState(() {
      filteredNames = names
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name List'),
            SizedBox(height: 5),
            RatingBar.builder(
              initialRating: appBarRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  appBarRating = rating;
                });
              },
            ),
          ],
        ),
        toolbarHeight: 80,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              onChanged: filterSearch,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredNames[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
