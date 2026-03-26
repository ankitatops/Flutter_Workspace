import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProblemPage extends StatefulWidget {
  @override
  _AddProblemPageState createState() => _AddProblemPageState();
}

class _AddProblemPageState extends State<AddProblemPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  Future<void> addProblem() async {
    await http.post(
      Uri.parse("https://prakrutitech.xyz/ankita/add_problem.php"),
      body: {"title": titleController.text, "description": descController.text},
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Complaint"),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: "Description"),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addProblem,
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
