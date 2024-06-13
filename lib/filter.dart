import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    const filterWidth = 250.0;

    return Container(
      width: filterWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextField(
            decoration: InputDecoration(labelText: 'Keywords'),
          ),
          const SizedBox(height: 10),
          CustomDropdown(
            label: 'Field',
            items: const [
              'Food security, agriculture',
              'Peace-building and crisis prevention',
              'Infrastructure, ICT'
            ],
            filterWidth: filterWidth,
            onChanged: (value) {},
          ),
          const SizedBox(height: 10),
          CustomDropdown(
            label: 'Type of function',
            items: const [
              'All types of function',
              'Integrated Expert'
            ],
            filterWidth: filterWidth,
            onChanged: (value) {},
          ),
          const SizedBox(height: 10),
          CustomDropdown(
            label: 'Country',
            items: const [
              'All countries',
              'Kenya',
              'Sri Lanka',
              'Benin',
              'Madagascar'
            ],
            filterWidth: filterWidth,
            onChanged: (value) {},
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Handle search/filter action
            },
            child: const Text('Search Jobs'),
          ),
        ],
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final double filterWidth;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.filterWidth,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      items: items.map((item) => DropdownMenuItem<String>(
        value: item,
        child: Container(
          width: filterWidth - 60.0,
          child: Text(
            item,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      )).toList(),
      onChanged: onChanged,
    );
  }
}
