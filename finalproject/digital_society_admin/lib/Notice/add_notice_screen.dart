import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'notice_screen.dart';

class AddNoticeScreen extends StatefulWidget {
  const AddNoticeScreen({super.key});

  @override
  State<AddNoticeScreen> createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {

  TextEditingController title = TextEditingController();
  TextEditingController message = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future addNotice(String title, String message) async {

    var url = Uri.parse("https://prakrutitech.xyz/ankita/add_notice.php");

    var resp = await http.post(
      url,
      body: {
        "title": title,
        "message": message,
      },
    );

    print(resp.statusCode);
  }

  InputDecoration fieldDecoration(String label, IconData icon) {
    return InputDecoration(

      labelText: label,

      prefixIcon: Icon(icon, color: Colors.indigo),

      filled: true,
      fillColor: Colors.grey.shade100,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.indigo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        title: const Text("Add Notice",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Form(

          key: _formKey,

          child: Column(

            children: [

              /// PAGE TITLE
              const Text(
                "Create New Notice",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 25),

              /// CARD CONTAINER
              Container(

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius: BorderRadius.circular(18),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),

                child: Column(

                  children: [

                    /// TITLE FIELD
                    TextFormField(
                      controller: title,
                      decoration: fieldDecoration("Title", Icons.title),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter title";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    /// MESSAGE FIELD
                    TextFormField(
                      controller: message,
                      maxLines: 4,
                      decoration: fieldDecoration("Message", Icons.message),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter message";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    /// INSERT BUTTON
                    SizedBox(

                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        onPressed: () {

                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          String Title = title.text.trim();
                          String Message = message.text.trim();

                          addNotice(Title, Message);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Notice()),
                          );
                        },

                        child: const Text(
                          "Add Notice",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}