import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  List feedbackList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFeedback();
  }

  Future<void> loadFeedback() async {
    try {

      var response = await http.get(
        Uri.parse("https://prakrutitech.xyz/ankita/get_feedback.php"),
      );

      var data = jsonDecode(response.body);

      if (data["status"] == "success") {
        setState(() {
          feedbackList = data["data"];
          isLoading = false;
        });
      } else {
        setState(() {
          feedbackList = [];
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
        title: const Text("User Feedback"),
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

                  : feedbackList.isEmpty
                  ? const Expanded(
                child: Center(
                  child: Text(
                    "No Feedback Found",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )

                  : Expanded(
                child: ListView.builder(

                  itemCount: feedbackList.length,

                  itemBuilder: (context, index) {

                    var feedback = feedbackList[index];

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
                                  feedback["user_id"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              Text(
                                "User ID: ${feedback["user_id"]}",
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
                            feedback["message"] ?? "",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              feedback["date"] ?? "",
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ),

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
    );
  }
}