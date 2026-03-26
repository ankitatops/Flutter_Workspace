import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MaintenanceScreen extends StatefulWidget {
  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  List data = [];

  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    final res = await http.get(Uri.parse(
        "https://prakrutitech.xyz/ankita/get_maintenance.php"));
    final json = jsonDecode(res.body);
    setState(() => data = json['data'] ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Maintenance")),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, i) =>
            ListTile(title: Text("Amount: ${data[i]['amount']}")),
      ),
    );
  }
}