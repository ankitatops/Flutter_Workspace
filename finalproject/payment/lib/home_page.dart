import 'package:flutter/material.dart';
import 'stripe_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stripe Payment"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await StripeService.makePayment(context);
          },
          child: const Text(
            "Pay ₹100",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}