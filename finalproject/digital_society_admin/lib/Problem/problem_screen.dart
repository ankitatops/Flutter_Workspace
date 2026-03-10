import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProblemScreen extends StatefulWidget {
  const ProblemScreen({super.key});

  @override
  State<ProblemScreen> createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {

  List problems = [];
  bool loading = true;

  String getUrl = "https://prakrutitech.xyz/ankita/get_problems.php";
  String updateUrl =
      "https://prakrutitech.xyz/ankita/update_problem_status.php";

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

  Future updateStatus(String id, String status) async {

    var response = await http.post(
      Uri.parse(updateUrl),
      body: {"id": id, "status": status},
    );

    var data = jsonDecode(response.body);

    if (data["status"] == "success") {

      getProblems();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Problem Status Updated")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        title: const Text("Problems List"),
        backgroundColor: Colors.blue,
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

                Align(
                  alignment: Alignment.centerRight,

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      problem["status"] == "open"
                          ? Colors.red
                          : Colors.green,
                    ),

                    onPressed: () {

                      String newStatus =
                      problem["status"] == "open"
                          ? "closed"
                          : "open";

                      updateStatus(problem["id"], newStatus);
                    },

                    child: Text(
                      problem["status"] == "open"
                          ? "Close"
                          : "Open",
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}