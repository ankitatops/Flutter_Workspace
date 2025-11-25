import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'addscreen.dart';
import 'mymodel.dart';

void main() {
  runApp(MaterialApp(home: ViewScreen(), debugShowCheckedModeBanner: false));
}

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  late Future<List<dynamic>> productData;

  @override
  void initState() {
    super.initState();
    productData = getdata();
  }

  Future<List<dynamic>> getdata() async {
    var url = Uri.parse("https://prakrutitech.xyz/ankita/view.php");
    var resp = await http.get(url);
    if (resp.statusCode == 200) {
      return List.from(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  void refreshData() {
    setState(() {
      productData = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Data")),
      body: FutureBuilder<List<dynamic>>(
        future: productData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text("No products available"));
          }

          return mymodel(list: snapshot.data!);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? refresh = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScreen()),
          );
          if (refresh ?? false) {
            refreshData();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
