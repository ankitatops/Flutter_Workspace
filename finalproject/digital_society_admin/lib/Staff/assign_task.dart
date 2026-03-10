import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AssignTask extends StatefulWidget {
  final String staffId;

  const AssignTask({super.key, required this.staffId});

  @override
  State<AssignTask> createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask> {
  TextEditingController taskController = TextEditingController();

  List tasks = [];
  bool isLoading = true;

  String assignUrl = "https://prakrutitech.xyz/ankita/assign_task.php";
  String getTaskUrl = "https://prakrutitech.xyz/ankita/get_staff_tasks.php";
  String updateStatusUrl =
      "https://prakrutitech.xyz/ankita/update_staff_task_status.php";

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  // ASSIGN TASK
  Future assignTask() async {
    if (taskController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter Task")));
      return;
    }

    var response = await http.post(
      Uri.parse(assignUrl),
      body: {"staff_id": widget.staffId, "task": taskController.text},
    );

    var data = jsonDecode(response.body);

    if (data["status"] == "success") {
      taskController.clear();

      getTasks();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(data["message"])));
    }
  }

  // GET STAFF TASKS
  Future getTasks() async {
    setState(() {
      isLoading = true;
    });

    var response = await http.post(
      Uri.parse(getTaskUrl),
      body: {"staff_id": widget.staffId},
    );

    var data = jsonDecode(response.body);

    if (data["status"] == "success") {
      setState(() {
        tasks = data["data"];
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  // UPDATE STATUS
  Future updateStatus(taskId, status) async {
    await http.post(
      Uri.parse(updateStatusUrl),
      body: {"id": taskId.toString(), "status": status},
    );

    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Tasks (ID : ${widget.staffId})"),
        backgroundColor: Colors.indigo,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // TASK FIELD
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                labelText: "Enter Task",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            // ASSIGN BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: assignTask,
                child: Text("Assign Task",style:TextStyle(color:Colors.white),),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Assigned Tasks",
                style: TextStyle(fontSize: 18,color: Colors.white ,fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : tasks.isEmpty
                  ? const Center(
                      child: Text(
                        "No Task Yet",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        var task = tasks[index];

                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.only(bottom: 10),

                          child: ListTile(
                            title: Text(task["task"]),

                            subtitle: Text("Status : ${task["status"]}"),

                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    updateStatus(task["id"], "completed");
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
