import 'package:digital_society_admin/visitors/visitors_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class add_visitors extends StatefulWidget {
  const add_visitors({super.key});

  @override
  State<add_visitors> createState() => _add_visitorsState();
}

class _add_visitorsState extends State<add_visitors> {
  TextEditingController name = TextEditingController();
  TextEditingController flat_no = TextEditingController();
  TextEditingController visit_date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        title: const Text("Add Visitor"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "Visitor Name",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: flat_no,
                  decoration: InputDecoration(
                    labelText: "Flat Number",
                    prefixIcon: const Icon(Icons.home),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: visit_date,
                  decoration: InputDecoration(
                    labelText: "Visit Date",
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {

                      String visitorname = name.text.toString();
                      String flatno = flat_no.text.toString();
                      String visitdate = visit_date.text.toString();

                      adddata(visitorname, flatno, visitdate);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VisitorsScreen(),
                        ),
                      );
                    },

                    child: const Text(
                      "Insert Visitor",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void adddata(String visitorname, String flatno, String visitdate) async {

    var url = Uri.parse("https://prakrutitech.xyz/ankita/add_visitor.php");

    var resp = await http.post(
      url,
      body: {
        "name": visitorname,
        "flat_no": flatno,
        "visit_date": visitdate
      },
    );

    print(resp.statusCode);
    print("Visitor Added");
  }
}