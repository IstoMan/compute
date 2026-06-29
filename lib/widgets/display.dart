import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:compute/models/text_type.dart';

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
