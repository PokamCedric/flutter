import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String value;
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
    required this.value, // Add this line to accept the current value
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        width: filterWidth,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: filterBoxDecoration,
        child: DropdownButton<String>(
          value: value, // Use the private value
          isExpanded: true,
          underline: const SizedBox(),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
