import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateNoticeScreen extends StatefulWidget {
  final String id;
  final String title;
  final String message;

  const UpdateNoticeScreen({
    super.key,
    required this.id,
    required this.title,
    required this.message,
  });

  @override
  State<UpdateNoticeScreen> createState() => _UpdateNoticeScreenState();
}

class _UpdateNoticeScreenState extends State<UpdateNoticeScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController message = TextEditingController();

  @override
  void initState() {
    super.initState();
    title.text = widget.title;
    message.text = widget.message;
  }

  Future updateNotice() async {
    var response = await http.post(
      Uri.parse("https://prakrutitech.xyz/ankita/update_notice.php"),
      body: {
        "id": widget.id,
        "title": title.text,
        "message": message.text,
      },
    );

    var data = jsonDecode(response.body);

    if (data["status"] == "success") {
      Navigator.pop(context);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Notice")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(labelText: "Title"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: message,
              decoration: InputDecoration(labelText: "Message"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateNotice,
              child: Text("Update Notice"),
            )
          ],
        ),
      ),
    );
  }
}