import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController flatController = TextEditingController();

  int userId = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getInt('user_id') ?? 0;
      nameController.text = prefs.getString('name') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      flatController.text = prefs.getString('flat_no') ?? '';
    });
  }
  void updateProfile() async {
    setState(() => isLoading = true);

    var response = await http.post(
      Uri.parse("https://prakrutitech.xyz/ankita/update_profile.php"),
      body: {
        "id": userId.toString(),
        "name": nameController.text,
        "phone": phoneController.text,
        "flat_no": flatController.text,
      },
    );

    var data = json.decode(response.body);

    setState(() => isLoading = false);

    if (data["status"] == "success") {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', nameController.text);
      prefs.setString('phone', phoneController.text);
      prefs.setString('flat_no', flatController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"]),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"]),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: flatController,
              decoration: const InputDecoration(labelText: "Flat No"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : updateProfile,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}