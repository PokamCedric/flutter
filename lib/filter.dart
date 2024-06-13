import 'package:flutter/material.dart';
import 'package:job_listings/models/filter_model.dart';


class Filter extends StatelessWidget {
  final List<FilterModel> filters;

  const Filter({
    super.key,
    required this.filters,
  });

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
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Dynamically create CustomDropdown widgets based on filters
          ...filters.map((filter) => CustomDropdown(
                label: filter.label,
                items: filter.items,
                filterWidth: filterWidth,
                filterBoxDecoration: filterBoxDecoration,
                onChanged: (value) {},
              )),
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

    return Container(
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
    );
  }
}