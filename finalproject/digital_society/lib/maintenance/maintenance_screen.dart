import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MaintenanceScreen extends StatefulWidget {
  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  List data = [];
  bool isLoading = true;
  String userId = "";

  @override
  void initState() {
    super.initState();
    loadUserId();
  }
  void loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id') ?? "";

    if (userId.isNotEmpty) {
      fetchMaintenance();
    } else {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchMaintenance() async {
    try {
      final response = await http.post(
        Uri.parse("https://prakrutitech.xyz/ankita/get_maintenance.php"),
        body: {
          "user_id": userId,
        },
      );

      final res = jsonDecode(response.body);

      if (res['status'] == "success") {
        setState(() {
          data = res['data'] ?? [];
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Maintenance"),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : data.isEmpty
          ? Center(child: Text("No Maintenance Found"))
          : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          var item = data[index];

          return Container(
            margin:
            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "₹${item['amount']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),
                    if (item['date'] != null)
                      Text(
                        "Date: ${item['date']}",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54),
                      ),
                  ],
                ),
                Icon(
                  Icons.account_balance_wallet,
                  color: Colors.blue,
                  size: 30,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}