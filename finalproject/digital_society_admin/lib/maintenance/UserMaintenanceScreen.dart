import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'add_maintenance_screen.dart';

class UserMaintenanceScreen extends StatefulWidget {
  final String userId;

  const UserMaintenanceScreen({super.key, required this.userId});

  @override
  State<UserMaintenanceScreen> createState() => _UserMaintenanceScreenState();
}

class _UserMaintenanceScreenState extends State<UserMaintenanceScreen> {
  List maintenance = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMaintenance();
  }

  Future<void> loadMaintenance() async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await http.post(
        Uri.parse("https://prakrutitech.xyz/ankita/get_maintenance.php"),
        body: {"user_id": widget.userId},
      );

      var data = jsonDecode(response.body);

      if (data["status"] == "success") {
        maintenance = data["data"];
      } else {
        maintenance = [];
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteAllMaintenance(String id) async {
    var response = await http.post(
      Uri.parse("https://prakrutitech.xyz/ankita/delete_maintenance.php"),
      body: {"user_id": id},
    );

    var data = jsonDecode(response.body);

    if (data["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Deleted")),
      );
      loadMaintenance();
    }
  }

  Future<void> updateMaintenanceStatus(
      String id, String status, String amount) async {
    try {
      var response = await http.post(
        Uri.parse("https://prakrutitech.xyz/ankita/update_maintenance.php"),
        body: {"id": id, "status": status, "amount": amount},
      );

      var data = jsonDecode(response.body);

      if (data["status"] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Status Updated")),
        );
        loadMaintenance();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Update Failed")),
        );
      }
    } catch (e) {
      print(e);
    }

    loadMaintenance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Maintenance"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Delete All"),
                    content: const Text(
                        "Are you sure you want to delete all maintenance?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          deleteAllMaintenance(widget.userId);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddMaintenanceScreen(userId: widget.userId),
            ),
          ).then((value) {
            if (value == true) {
              loadMaintenance();
            }
          });
        },
        child: const Icon(Icons.add),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : maintenance.isEmpty
          ? const Center(
        child: Text(
          "No Maintenance Found",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: maintenance.length,
        itemBuilder: (context, index) {
          var item = maintenance[index];

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blue,
                    child: const Icon(
                      Icons.home_repair_service,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Amount: ${item["amount"]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Row(
                          children: [
                            const Icon(
                              Icons.date_range,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text("Due Date: ${item["due_date"]}"),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Row(
                          children: [
                            const Icon(
                              Icons.info,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              item["status"],
                              style: TextStyle(
                                color: item["status"] == "paid"
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 30,
                    ),
                    onPressed: () {
                      updateMaintenanceStatus(
                        item["id"].toString(),
                        "paid",
                        item["amount"].toString(),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}