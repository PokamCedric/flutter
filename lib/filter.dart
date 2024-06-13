import 'package:flutter/material.dart';
import 'package:job_listings/custom_dropdown.dart';
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

    return IntrinsicHeight(
      child: Container(
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor, // Background color
                  foregroundColor: Theme.of(context).indicatorColor, // Text color
                ),
                onPressed: () {
                  // Handle search/filter action
                },
                child: const Text('Search Jobs'),
              ),
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle search/filter action
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
