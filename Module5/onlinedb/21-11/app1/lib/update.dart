import 'package:app1/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateScreen extends StatefulWidget {
  final String id;
  final String name;
  final String price;
  final String description;

  const UpdateScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController pidController = TextEditingController();
  TextEditingController pnameController = TextEditingController();
  TextEditingController ppriceController = TextEditingController();
  TextEditingController pdesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pidController.text = widget.id ;
    pnameController.text = widget.name ;
    ppriceController.text = widget.price ;
    pdesController.text = widget.description ;
  }

  void updateData() async {
    var url = Uri.parse("https://prakrutitech.xyz/ankita/update.php");
    var response = await http.post(
      url,
      body: {
        "id": widget.id,
        "p_name": pnameController.text,
        "p_price": ppriceController.text,
        "p_des": pdesController.text,
      },
    );

    if (response.statusCode == 200) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Product updated successfully')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update product')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Product")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: pidController,
                  decoration: InputDecoration(
                    labelText: "Product id",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 15),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: pnameController,
                  decoration: InputDecoration(
                    labelText: "Product Name",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 15),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: ppriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Product Price",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 15),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: pdesController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Product Description",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  updateData();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ViewScreen()),
                  );
                },
                child: Text(
                  "Update Product",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
