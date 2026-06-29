import 'package:flutter/material.dart';
import 'package:compute/calc.dart';
import 'package:compute/models/text_type.dart';
import 'package:compute/widgets/display.dart';
import 'package:compute/widgets/main_board.dart';

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

  void _reset() {
    _text = '';
    _isDone = false;
    _type = TextType.normal;
  }

  String _calculateResult() {
    try {
      return evaluate(_text).toString();
    } catch (e) {
      throw const FormatException('Invalid expression');
    }
  }

  void onTap(String symbol) {
    setState(() {
      switch (symbol) {
        case 'AC':
          _text = '';
          break;
        case '⌫':
          if (_text.isNotEmpty) {
            _text = _text.substring(0, _text.length - 1);
          }
          break;
        case '=':
          try {
            _text = _calculateResult();
            _type = TextType.result;
          } catch (e) {
            _type = TextType.error;
          }
          _isDone = true;
          break;
        default:
          if (_isDone) {
            _reset();
          }
          _text += symbol;
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
