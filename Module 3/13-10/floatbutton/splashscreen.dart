

import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget
{
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
            children: [
              Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4Z_6ze3WQeIErmppDKSILtai6OZl7wZw8xA&s.jpg",
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text("Go Back"),
              ),
            ],
          ),
        ),
    );
  }
}






