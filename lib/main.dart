import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:compute/calc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late String _text;

  @override
  void initState() {
    super.initState();
    _text = '';
  }

  String calculateResult() {
    return evaluate(_text).toString();
  }

  void onTap(String symbol) {
    setState(() {
      switch (symbol) {
        case 'AC':
          _text = '';
          break;
        case '⌫':
          if (_text.isNotEmpty) _text = _text.substring(0, _text.length - 1);
          break;
        case '=':
          _text = calculateResult();
          break;
        default:
          _text += symbol;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: .end,
          crossAxisAlignment: .end,
          children: [
            Display(text: _text),
            MainBoard(onTap: onTap),
          ],
        ),
      ),
      theme: ThemeData.dark(),
    );
  }
}

class Display extends StatelessWidget {
  const Display({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerRight,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 95,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
          textAlign: TextAlign.right,
          maxLines: 1,
        ),
      ),
    );
  }
}

class MainBoard extends StatelessWidget {
  const MainBoard({super.key, required this.onTap});
  final Function(String) onTap;

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

enum DigitType { number, operator, equal, clear, back, decimal }

enum Operator { add, subtract, multiply, divide }

class DigitButton extends StatelessWidget {
  const DigitButton({
    super.key,
    required this.symbol,
    required this.type,
    required this.onTap,
  });
  final String symbol;
  final DigitType type;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(symbol),
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: switch (type) {
            DigitType.number => Colors.grey,
            DigitType.operator => Colors.orange,
            DigitType.equal => Colors.blue,
            DigitType.back => Colors.yellow.shade700,
            DigitType.clear => Colors.red,
            DigitType.decimal => Colors.grey,
          },
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white38),
        ),
        child: Center(
          child: Text(
            symbol,
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
