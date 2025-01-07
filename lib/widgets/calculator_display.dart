import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final String value;

  const CalculatorDisplay({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerRight,
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}
