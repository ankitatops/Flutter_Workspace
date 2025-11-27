import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController pid = TextEditingController();
  TextEditingController pname = TextEditingController();
  TextEditingController pprice = TextEditingController();
  TextEditingController pdes = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),

      body: Container(
        width: double.infinity,
        color: Colors.blue.withOpacity(0.06),

        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(22),
              width: 330,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ],
              ),

              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Insert New Product",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: pid,
                      decoration: _inputDecoration("Product ID", Icons.qr_code),
                      validator: (value) =>
                      value!.isEmpty ? "Please enter Product ID" : null,
                    ),
                    SizedBox(height: 15),

                    TextFormField(
                      controller: pname,
                      decoration:
                      _inputDecoration("Product Name", Icons.shopping_bag),
                      validator: (value) =>
                      value!.isEmpty ? "Please enter Product Name" : null,
                    ),
                    SizedBox(height: 15),

                    TextFormField(
                      controller: pprice,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration("Product Price", Icons.money),
                      validator: (value) {
                        if (value!.isEmpty) return "Please enter Product Price";
                        if (double.tryParse(value) == null)
                          return "Price must be a number";
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    TextFormField(
                      controller: pdes,
                      maxLines: 2,
                      decoration:
                      _inputDecoration("Description", Icons.description),
                      validator: (value) =>
                      value!.isEmpty ? "Please enter Description" : null,
                    ),
                    SizedBox(height: 25),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          adddata(
                            pid.text,
                            pname.text,
                            pprice.text,
                            pdes.text,
                          );
                          Navigator.pop(context, true);
                        }
                      },
                      child: Text(
                        "Insert Product",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blue),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void adddata(
      String product_id, String product_name, String product_price, String product_des) async {

    var url = Uri.parse("https://prakrutitech.xyz/ankita/insert.php");

    var resp = await http.post(
      url,
      body: {
        "id": product_id,
        "p_name": product_name,
        "p_price": product_price,
        "p_des": product_des,
      },
    );

    print(resp.statusCode);
  }
}
