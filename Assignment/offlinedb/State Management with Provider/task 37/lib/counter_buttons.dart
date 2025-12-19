import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class CounterButtons extends StatelessWidget {
  const CounterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CounterProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: provider.decrement,
          child: const Text("-"),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: provider.increment,
          child: const Text("+"),
        ),
      ],
    );
  }
}
