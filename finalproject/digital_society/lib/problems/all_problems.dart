import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'add_problem_screen.dart';

class ProblemScreen extends StatefulWidget {
  const ProblemScreen({super.key});

  @override
  State<ProblemScreen> createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {

  List problems = [];
  bool loading = true;

  String getUrl = "https://prakrutitech.xyz/ankita/get_problems.php";

  @override
  void initState() {
    super.initState();
    getProblems();
  }

  Future getProblems() async {

    var response = await http.get(Uri.parse(getUrl));

    if (response.statusCode == 200) {

      var data = jsonDecode(response.body);

      setState(() {
        problems = data["data"];
        loading = false;
      });
    }
  }
  Future deleteProblem(String id, String userId) async {

    var url = Uri.parse("https://prakrutitech.xyz/ankita/delete_problem.php");

    var response = await http.post(url, body: {
      "id": id,
      "user_id": userId,
    });

    var data = jsonDecode(response.body);

    if (data["status"] == "success") {

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"]))
      );

      getProblems();

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"]))
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Problems List"),
        backgroundColor: Colors.blue.shade100,
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: problems.length,

        itemBuilder: (context, index) {

          var problem = problems[index];

          return Container(

            margin: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 8),

            padding: const EdgeInsets.all(15),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),

              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0,3),
                )
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  problem["problem"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "User ID : ${problem["user_id"]}",
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "Status : ${problem["status"]}",
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Delete Problem"),
                            content: const Text("Are you sure you want to delete?"),
                            actions: [

                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),

                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  deleteProblem(
                                    problem["id"].toString(),
                                    problem["user_id"].toString(),
                                  );
                                },
                                child: const Text("Delete", style: TextStyle(color: Colors.red)),
                              ),

                            ],
                          ),
                        );

                      },
                    )
                  ],
                )
              ]
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade100,
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddProblemPage()),
          );
          getProblems();
        },
      ),
    );
  }
}