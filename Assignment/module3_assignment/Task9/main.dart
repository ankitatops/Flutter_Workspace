import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: CalculatorScreen(), debugShowCheckedModeBanner: false,));
}
class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _result = '';
      } else if (value == '=') {
        try {
          _result = _calculateResult(_input);
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _input += value;
      }
    });
  }

  String _calculateResult(String expression) {
    try {
      final result = _evaluateExpression(expression);
      return result.toString();
    } catch (_) {
      return 'Error';
    }
  }

  double _evaluateExpression(String exp) {
    exp = exp.replaceAll('×', '*').replaceAll('÷', '/');
    List<String> tokens = exp.split(RegExp('([+\\-*/])'));
    List<String> operators = exp
        .split(RegExp('[0-9.]+'))
        .where((s) => s.isNotEmpty)
        .toList();

    double result = double.parse(tokens[0]);
    for (int i = 0; i < operators.length; i++) {
      double nextNum = double.parse(tokens[i + 1]);
      switch (operators[i]) {
        case '+':
          result += nextNum;
          break;
        case '-':
          result -= nextNum;
          break;
        case '*':
          result *= nextNum;
          break;
        case '/':
          result /= nextNum;
          break;
      }
    }
    return result;
  }

  Widget _buildButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: color ?? Colors.teal,
          ),
          onPressed: () => _onButtonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Display
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(24),
            child: Text(_input, style: const TextStyle(fontSize: 32)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(24),
            child: Text(
              _result,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('÷', color: Colors.cyan),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('×', color: Colors.cyan),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('-', color: Colors.cyan),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('C', color: Colors.redAccent),
                    _buildButton('0'),
                    _buildButton('=', color: Colors.cyan),
                    _buildButton('+', color: Colors.cyan),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
