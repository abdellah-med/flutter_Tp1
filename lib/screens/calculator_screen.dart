import 'package:flutter/material.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayValue = '0';
  String operator = '';
  double firstNumber = 0;
  bool shouldClearDisplay = false;

  void onNumberPressed(String number) {
    setState(() {
      if (displayValue == '0' || shouldClearDisplay) {
        displayValue = number;
        shouldClearDisplay = false;
      } else {
        displayValue += number;
      }
    });
  }

  void onOperatorPressed(String newOperator) {
    setState(() {
      firstNumber = double.parse(displayValue);
      operator = newOperator;
      shouldClearDisplay = true;
    });
  }

  void onEqualPressed() {
    if (operator.isEmpty) return;

    double secondNumber = double.parse(displayValue);
    double result = 0;

    switch (operator) {
      case '+':
        result = firstNumber + secondNumber;
        break;
      case '-':
        result = firstNumber - secondNumber;
        break;
      case '×':
        result = firstNumber * secondNumber;
        break;
      case '÷':
        if (secondNumber != 0) {
          result = firstNumber / secondNumber;
        } else {
          setState(() {
            displayValue = 'Error';
            return;
          });
        }
        break;
    }

    setState(() {
      displayValue = result.toString();
      operator = '';
      shouldClearDisplay = true;
    });
  }

  void clear() {
    setState(() {
      displayValue = '0';
      operator = '';
      firstNumber = 0;
      shouldClearDisplay = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculatrice'),
      ),
      body: Column(
        children: [
          // Affichage
          Expanded(
            child: CalculatorDisplay(value: displayValue),
          ),
          // Grille de boutons
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  buildButtonRow(['7', '8', '9', '÷']),
                  buildButtonRow(['4', '5', '6', '×']),
                  buildButtonRow(['1', '2', '3', '-']),
                  buildButtonRow(['C', '0', '=', '+']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((button) {
          return Expanded(
            child: CalculatorButton(
              text: button,
              onPressed: () {
                switch (button) {
                  case '+':
                  case '-':
                  case '×':
                  case '÷':
                    onOperatorPressed(button);
                    break;
                  case '=':
                    onEqualPressed();
                    break;
                  case 'C':
                    clear();
                    break;
                  default:
                    onNumberPressed(button);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
