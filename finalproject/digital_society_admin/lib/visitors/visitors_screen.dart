import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'add_visitors.dart';

class VisitorsScreen extends StatefulWidget {
  const VisitorsScreen({super.key});

  @override
  State<VisitorsScreen> createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> {
  List visitors = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFeedback();
  }

  Future<void> loadFeedback() async {
    try {
      var response = await http.get(
        Uri.parse("https://prakrutitech.xyz/ankita/get_all_visitors.php"),
      );

      var data = jsonDecode(response.body);

      if (data["status"] == "success") {
        setState(() {
          visitors = data["data"];
          isLoading = false;
        });
      } else {
        setState(() {
          visitors = [];
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        title: const Text("Visitors"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: loadFeedback,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              isLoading
                  ? const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  : visitors.isEmpty
                  ? const Expanded(
                child: Center(
                  child: Text(
                    "No Visitors Found",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
                  : Expanded(
                child: ListView.builder(
                  itemCount: visitors.length,
                  itemBuilder: (context, index) {
                    var visitor = visitors[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  visitor["id"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              Text(
                                "ID: ${visitor["id"]}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Text(
                            visitor["name"] ?? "",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Flat No : ${visitor["flat_no"]}",
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            "Visit Date : ${visitor["visit_date"]}",
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            "Status : ${visitor["status"]}",
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            "Created : ${visitor["created_at"]}",
                            style: const TextStyle(
                              color: Colors.black45,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                approveVisitor(
                                  visitor["id"].toString(),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => add_visitors()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void approveVisitor(String id) async {
    try {
      var response = await http.post(
        Uri.parse("https://prakrutitech.xyz/ankita/approve_visitor.php"),
        body: {"id": id},
      );

      var data = jsonDecode(response.body);

      if (data["status"] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Visitor Approved")),
        );

        loadFeedback();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Approval Failed")),
        );
      }
    } catch (e) {
      print("Error:$e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Server Error")),
      );
    }
  }
}