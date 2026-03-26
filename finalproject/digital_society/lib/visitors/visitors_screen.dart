import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VisitorsScreen extends StatefulWidget {
  @override
  _VisitorsScreenState createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> {
  List data = [];

  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    final res = await http.get(
        Uri.parse("https://prakrutitech.xyz/ankita/get_visitors.php"));
    final json = jsonDecode(res.body);
    setState(() => data = json['data'] ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Visitors")),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, i) =>
            ListTile(title: Text(data[i]['name'] ?? "")),
      ),
    );
  }
}