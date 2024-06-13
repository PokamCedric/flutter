import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    const double filterWidth = 250.0;
    final BoxDecoration filterBoxDecoration = BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.zero,
    );

    return Container(
      height: 300.0,
      width: filterWidth,
      padding: const EdgeInsets.all(10.0),
      decoration: filterBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: filterBoxDecoration,
            child: const TextField(
              decoration: InputDecoration(hintText: 'Search'),
            ),
          ),
          const SizedBox(height: 10),
          CustomDropdown(
            label: 'Field',
            items: const [
              'All Fields',
              'Food security, agriculture',
              'Peace-building and crisis prevention',
              'Infrastructure, ICT'
            ],
            filterWidth: filterWidth,
            filterBoxDecoration: filterBoxDecoration,
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
            filterBoxDecoration: filterBoxDecoration,
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
            filterBoxDecoration: filterBoxDecoration,
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

  BoxDecoration filterBoxDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.zero,
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final double filterWidth;
  final BoxDecoration filterBoxDecoration;

  final ValueChanged<String?> onChanged;


  const CustomDropdown({
    Key? key,
    required this.label,
    required this.items,
    required this.filterWidth,
    required this.filterBoxDecoration,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 10.0;

    return Container(
      decoration: filterBoxDecoration,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none, // Remove the default border
          contentPadding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
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
    );
  }
}
