import 'package:flutter/material.dart';

class PaddedTextCell extends StatelessWidget {
  final String text;
  final double width;
  final Color? color;

   const PaddedTextCell({super.key,
    required this.text,
    required this.width,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Fixed width for the cell
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Custom vertical padding
      child: Text(
        text,
        softWrap: true, // Enable text wrapping
        overflow: TextOverflow.clip, // Clip overflowing text
        style: TextStyle(color: color),
      ),
    );
  }
}
