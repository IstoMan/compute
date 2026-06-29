import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Calcutor'), centerTitle: true),
        body: Column(
          mainAxisAlignment: .end,
          children: [Display(), MainBoard()],
        ),
      ),
      theme: ThemeData.dark(),
    );
  }
}

class Display extends StatelessWidget {
  const Display({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: '0',
          labelStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
        ),
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class MainBoard extends StatelessWidget {
  const MainBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              DigitButton(symbol: 'AC', type: DigitType.clear),
              DigitButton(symbol: '±', type: DigitType.operator),
              DigitButton(symbol: '%', type: DigitType.operator),
              DigitButton(symbol: '÷', type: DigitType.operator),
            ],
          ),
          Row(
            children: [
              DigitButton(symbol: '7', type: DigitType.number),
              DigitButton(symbol: '8', type: DigitType.number),
              DigitButton(symbol: '9', type: DigitType.number),
              DigitButton(symbol: '×', type: DigitType.operator),
            ],
          ),
          Row(
            children: [
              DigitButton(symbol: '4', type: DigitType.number),
              DigitButton(symbol: '5', type: DigitType.number),
              DigitButton(symbol: '6', type: DigitType.number),
              DigitButton(symbol: '+', type: DigitType.operator),
            ],
          ),
          Row(
            children: [
              DigitButton(symbol: '1', type: DigitType.number),
              DigitButton(symbol: '2', type: DigitType.number),
              DigitButton(symbol: '3', type: DigitType.number),
              DigitButton(symbol: '-', type: DigitType.operator),
            ],
          ),
          Row(
            children: [
              DigitButton(symbol: '0', type: DigitType.number),
              DigitButton(symbol: '.', type: DigitType.decimal),
              DigitButton(symbol: '⌫', type: DigitType.back),
              DigitButton(symbol: '=', type: DigitType.equal),
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
  const DigitButton({super.key, required this.symbol, required this.type});
  final String symbol;
  final DigitType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: switch (type) {
          DigitType.number => Colors.black,
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
    );
  }
}
