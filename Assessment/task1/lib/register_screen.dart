import 'package:flutter/material.dart';
import '../models/student.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _acceptTerms = false;
  late String _selectedCourse;
  String _gender = "Male";

  final List<String> _courses = ["BCA", "BBA", "B.Sc", "BA", "MBA"];

  void _register() {
    if (_formKey.currentState!.validate()) {
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please accept the terms first.")),
        );
        return;
      }

      final student = Student(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      Student.registeredStudents.add(student);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registered successfully!")),
      );
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Registration")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (val) => val!.isEmpty ? "Enter your name" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Enter your email";
                  if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(val)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (val) =>
                val!.length < 6 ? "Password must be at least 6 characters" : null,
              ),

              const SizedBox(height: 20),
              const Text("Gender", style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Radio<String>(
                    value: "Male",
                    groupValue: _gender,
                    onChanged: (val) => setState(() => _gender = val!),
                  ),
                  const Text("Male"),
                  Radio<String>(
                    value: "Female",
                    groupValue: _gender,
                    onChanged: (val) => setState(() => _gender = val!),
                  ),
                  const Text("Female"),
                ],
              ),

              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Select Course"),
                value: _selectedCourse,
                items: _courses
                    .map((course) => DropdownMenuItem(
                  value: course,
                  child: Text(course),
                ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCourse = val!),
                validator: (val) =>
                val == null ? "Please select a course" : null,
              ),

              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text("I accept the terms and conditions"),
                value: _acceptTerms,
                onChanged: (val) {
                  setState(() {
                    _acceptTerms = val!;
                  });
                },
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _register,
                  child: const Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
