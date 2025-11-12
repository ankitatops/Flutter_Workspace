import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../database/db_helper.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DbHelper.instance;

  String? imageBase64;
  final companyController = TextEditingController();
  final modelController = TextEditingController();
  final priceController = TextEditingController();
  final discountController = TextEditingController();

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      File img = File(picked.path);
      imageBase64 = base64Encode(await img.readAsBytes());
      setState(() {});
    }
  }


  Future<void> saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    double price = double.parse(priceController.text);
    double discount = double.parse(discountController.text);
    double finalPrice = price - (price * discount / 100);

    await dbHelper.insert({
      'image': imageBase64,
      'company': companyController.text.trim(),
      'model': modelController.text.trim(),
      'price': price,
      'discount': discount,
      'finalPrice': finalPrice,
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text(" Product Added!")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: pickImage,
                  borderRadius: BorderRadius.circular(8),
                  splashColor: Colors.deepPurple.withOpacity(0.3),
                  child: imageBase64 == null
                      ? Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.deepPurple.shade200,
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.add_a_photo,
                          size: 50, color: Colors.deepPurple),
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      base64Decode(imageBase64!),
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: companyController,
                decoration: const InputDecoration(labelText: "Company Name"),
                validator: (val) =>
                val!.isEmpty ? "Enter company name" : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: modelController,
                decoration: const InputDecoration(labelText: "Model Name"),
                validator: (val) => val!.isEmpty ? "Enter model name" : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price"),
                validator: (val) => val!.isEmpty ? "Enter price" : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: discountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Discount (%)"),
                validator: (val) => val!.isEmpty ? "Enter discount" : null,
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: saveProduct,
                child: const Text("Save Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
