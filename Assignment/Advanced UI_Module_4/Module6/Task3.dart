import 'package:flutter/material.dart';


class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  TextEditingController name = TextEditingController();
  TextEditingController comment = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String? _selectedCategory;

  bool _agree = false;

  List<String> _categories = [
    'Study Review',
    'General Feedback',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  labelText: "Enter Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Please enter name";
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: comment,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Write Comments",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Please enter comments";
                  return null;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: Text("Select Feedback Category"),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) return "Please select a category";
                  return null;
                },
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),

              CheckboxListTile(
                title: Text("I agree to share my feedback"),
                value: _agree,
                onChanged: (bool? value) {
                  setState(() {
                    _agree = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (!_agree) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please agree before submitting'),
                        ),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Feedback Submitted')),
                    );

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Feedback Submitted"),
                          content: Text(
                            "Name: ${name.text}\n"
                                "Category: $_selectedCategory\n"
                                "Comments: ${comment.text}\n"
                                "Agreed: ${_agree ? "Yes" : "No"}",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}