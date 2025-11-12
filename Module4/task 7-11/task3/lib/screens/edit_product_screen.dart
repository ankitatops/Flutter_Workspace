import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../database/db_helper.dart';

class EditProductScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final dbHelper = DbHelper.instance;

  final TextEditingController companyController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  String? imageBase64;

  @override
  void initState() {
    super.initState();
    companyController.text = widget.product['company'] ?? '';
    modelController.text = widget.product['model'] ?? '';
    priceController.text = widget.product['price'].toString();
    discountController.text = widget.product['discount'].toString();
    imageBase64 = widget.product['image'];
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      File img = File(picked.path);
      imageBase64 = base64Encode(await img.readAsBytes());
      setState(() {});
    }
  }

  void deleteImage() {
    setState(() {
      imageBase64 = null;
    });
  }

  Future<void> _saveChanges() async {
    if (companyController.text.trim().isEmpty ||
        modelController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty ||
        discountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    double price = double.tryParse(priceController.text) ?? 0.0;
    double discount = double.tryParse(discountController.text) ?? 0.0;
    double finalPrice = price - (price * discount / 100);

    final updatedProduct = {
      '_id': widget.product['_id'],
      'company': companyController.text.trim(),
      'model': modelController.text.trim(),
      'price': price,
      'discount': discount,
      'finalPrice': finalPrice,
      'image': imageBase64,
    };

    await dbHelper.update(updatedProduct);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product updated successfully!")),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: pickImage,
                    borderRadius: BorderRadius.circular(8),
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
                  if (imageBase64 != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: InkWell(
                        onTap: deleteImage,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              TextField(
                controller: companyController,
                decoration: const InputDecoration(labelText: "Company"),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: modelController,
                decoration: const InputDecoration(labelText: "Model"),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price"),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: discountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Discount (%)"),
              ),
              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: _saveChanges,
                icon: const Icon(Icons.save),
                label: const Text("Save Changes"),
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
