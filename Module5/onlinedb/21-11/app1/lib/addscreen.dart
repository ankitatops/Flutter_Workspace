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
      appBar: AppBar(title: Text("Add Product")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: pid,
                  decoration: InputDecoration(
                    hintText: "Enter Product ID",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Product ID";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: pname,
                  decoration: InputDecoration(
                    hintText: "Enter Product Name",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Product Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: pprice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Product Price",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Product Price";
                    }
                    if (double.tryParse(value) == null) {
                      return "Price must be a number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: pdes,
                  decoration: InputDecoration(
                    hintText: "Enter Product Description",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Description";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      adddata(pid.text, pname.text, pprice.text, pdes.text);
                      Navigator.pop(context, true); // Returning `true` to indicate data change
                    }
                  },
                  child: Text("Insert Product"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void adddata(String product_id, String product_name, String product_price, String product_des) async {
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
