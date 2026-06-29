import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:compute/models/types.dart';

class DigitButton extends StatelessWidget {
  const DigitButton({
    super.key,
    required this.symbol,
    required this.type,
    required this.onTap,
  });

  final String symbol;
  final DigitType type;
  final void Function(String) onTap;

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
