import 'package:flutter/material.dart';
import 'package:compute/models/types.dart';
import 'package:compute/widgets/digit_button.dart';

class MainBoard extends StatelessWidget {
  const MainBoard({super.key, required this.onTap});

  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              DigitButton(symbol: 'AC', type: DigitType.clear, onTap: onTap),
              DigitButton(symbol: '±', type: DigitType.operator, onTap: onTap),
              DigitButton(symbol: '%', type: DigitType.operator, onTap: onTap),
              DigitButton(symbol: '÷', type: DigitType.operator, onTap: onTap),
            ],
          ),
          Row(
            children: [
              DigitButton(symbol: '7', type: DigitType.number, onTap: onTap),
              DigitButton(symbol: '8', type: DigitType.number, onTap: onTap),
              DigitButton(symbol: '9', type: DigitType.number, onTap: onTap),
              DigitButton(symbol: '×', type: DigitType.operator, onTap: onTap),
            ],
          ),
          Row(
            children: [
              DigitButton(symbol: '4', type: DigitType.number, onTap: onTap),
              DigitButton(symbol: '5', type: DigitType.number, onTap: onTap),
              DigitButton(symbol: '6', type: DigitType.number, onTap: onTap),
              DigitButton(symbol: '+', type: DigitType.operator, onTap: onTap),
            ],
          ),
          Row(
            children: [
              DigitButton(symbol: '1', type: DigitType.number, onTap: onTap),
              DigitButton(symbol: '2', type: DigitType.number, onTap: onTap),
              DigitButton(symbol: '3', type: DigitType.number, onTap: onTap),
              DigitButton(symbol: '-', type: DigitType.operator, onTap: onTap),
            ],
          ),
          Row(
            children: [
              DigitButton(symbol: '0', type: DigitType.number, onTap: onTap),
              DigitButton(symbol: '.', type: DigitType.decimal, onTap: onTap),
              DigitButton(symbol: '⌫', type: DigitType.back, onTap: onTap),
              DigitButton(symbol: '=', type: DigitType.equal, onTap: onTap),
            ],
          ),
        ],
      ),
    );
  }
}
