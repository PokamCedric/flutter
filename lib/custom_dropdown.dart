import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final double filterWidth;
  final BoxDecoration filterBoxDecoration;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.filterWidth,
    required this.filterBoxDecoration,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: filterWidth,
      padding: const EdgeInsets.all(10.0),
      decoration: filterBoxDecoration,
      child: DropdownButton<String>(
        value: items.first,
        isExpanded: true,
        underline: const SizedBox(),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
