// counter_display.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.watch<CounterProvider>().counter;

    return Text(
      "Counter: $count",
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}
