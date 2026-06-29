import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:compute/calc.dart';

void main() {
  runApp(const MainApp());
}

enum TextType { normal, result, error }

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late String _text;
  late TextType _type;
  late bool _isDone;

  @override
  void initState() {
    super.initState();
    _text = '';
    _type = TextType.normal;
    _isDone = false;
  }

  void reset() {
    setState(() {
      _text = '';
      _isDone = false;
      _type = .normal;
    });
  }

  String calculateResult() {
    try {
      return evaluate(_text).toString();
    } catch (e) {
      throw FormatException('Invalid expression');
    }
  }

  void onTap(String symbol) {
    setState(() {
      switch (symbol) {
        case 'AC':
          setState(() {
            _text = '';
          });
          break;
        case '⌫':
          setState(() {
            if (_text.isNotEmpty) _text = _text.substring(0, _text.length - 1);
          });
          break;
        case '=':
          setState(() {
            try {
              _text = calculateResult();
              _type = TextType.result;
            } catch (e) {
              _type = TextType.error;
            }
            _isDone = true;
          });
          break;
        default:
          if (_isDone) {
            reset();
          }
          setState(() {
            _text += symbol;
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Display(text: _text, type: _type),
            MainBoard(onTap: onTap),
          ],
        ),
      ),
    );
  }
}

class Display extends StatelessWidget {
  const Display({super.key, required this.text, required this.type});
  final String text;
  final TextType type;

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
            color: switch (type) {
              TextType.normal => Colors.white,
              TextType.result => Colors.purple,
              TextType.error => Colors.red,
            },
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
