import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StaffScreen extends StatefulWidget {
  @override
  _StaffScreenState createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  List data = [];

  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    final res = await http.get(Uri.parse(
        "https://prakrutitech.xyz/ankita/get_staff_tasks.php"));
    final json = jsonDecode(res.body);
    setState(() => data = json['data'] ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Staff Tasks")),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, i) =>
            ListTile(title: Text(data[i]['task'] ?? "")),
      ),
    );
  }
}