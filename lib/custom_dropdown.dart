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
    const double horizontalPadding = 10.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: filterBoxDecoration,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none, // Remove the default border
            contentPadding:
                const EdgeInsets.symmetric(horizontal: horizontalPadding),
          ),
          items: items.map((item) => DropdownMenuItem<String>(
                value: item,
                child: Container(
                  width: filterWidth - (60.0 + horizontalPadding),
                  child: Text(
                    item,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              )).toList(),
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
