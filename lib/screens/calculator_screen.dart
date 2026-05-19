import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final List<String> buttons = [
    'C',
    '<-',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    '()',
    '=',
  ];

  String display = '0';

  double firstNumber = 0;
  double secondNumber = 0;

  String operation = '';

  String formatResult(double value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  void onButtonClick(String value) {
    setState(() {
      if (value == 'C') {
        display = '0';
        firstNumber = 0;
        secondNumber = 0;
        operation = '';
      } else if (value == '<-') {
        if (display.length > 1) {
          display = display.substring(0, display.length - 1);
        } else {
          display = '0';
        }
      } else if (value == '()') {
        display += '()';
      } else if (value == '+' ||
          value == '-' ||
          value == '*' ||
          value == '/' ||
          value == '%') {
        firstNumber = double.parse(display);
        operation = value;
        display = '0';
      } else if (value == '=') {
        secondNumber = double.parse(display);

        double result = 0;

        if (operation == '+') {
          result = firstNumber + secondNumber;
        } else if (operation == '-') {
          result = firstNumber - secondNumber;
        } else if (operation == '*') {
          result = firstNumber * secondNumber;
        } else if (operation == '/') {
          result = firstNumber / secondNumber;
        } else if (operation == '%') {
          result = firstNumber % secondNumber;
        }

        display = formatResult(result);
      } else {
        if (display == '0') {
          display = value;
        } else {
          display += value;
        }
      }
    });
  }

  Color buttonColor(String text) {
    if (text == 'C') {
      return Colors.red;
    } else if (text == '=') {
      return Colors.green;
    } else if (text == '+' ||
        text == '-' ||
        text == '*' ||
        text == '/' ||
        text == '%') {
      return Colors.orange;
    } else {
      return const Color(0xFFEDEDED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Calculator App"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 104, 130, 142),
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(20),
                child: Text(
                  display,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 49,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      onButtonClick(buttons[index]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor(buttons[index]),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      buttons[index],
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}