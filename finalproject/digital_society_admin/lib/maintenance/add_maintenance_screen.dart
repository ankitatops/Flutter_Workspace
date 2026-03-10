import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddMaintenanceScreen extends StatefulWidget {
  final String userId;

  const AddMaintenanceScreen({super.key, required this.userId});

  @override
  State<AddMaintenanceScreen> createState() => _AddMaintenanceScreenState();
}

class _AddMaintenanceScreenState extends State<AddMaintenanceScreen> {
  TextEditingController amount = TextEditingController();
  TextEditingController dueDate = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void addData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var response = await http.post(
      Uri.parse("https://prakrutitech.xyz/ankita/add_maintenance.php"),
      body: {
        "user_id": widget.userId.toString(),
        "amount": amount.text.trim(),
        "due_date": dueDate.text.trim(),
      },
    );

    var data = jsonDecode(response.body);

    if (data["status"] == "success") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Added Successfully")));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Add Failed")));
    }
  }

  InputDecoration fieldDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blue),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.blue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Maintenance"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: amount,
                keyboardType: TextInputType.number,
                decoration: fieldDecoration("Amount", Icons.currency_rupee),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter amount";
                  }
                  if (double.tryParse(value) == null) {
                    return "Enter valid number";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: dueDate,
                decoration: fieldDecoration("Due Date (yyyy-mm-dd)", Icons.date_range),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter due date";
                  }

                  RegExp regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');

                  if (!regex.hasMatch(value)) {
                    return "Invalid format (yyyy-mm-dd)";
                  }

                  try {
                    DateTime.parse(value);
                  } catch (e) {
                    return "Invalid date";
                  }

                  return null;
                },
              ),

              SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: addData,
                  child: Text("Insert", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
