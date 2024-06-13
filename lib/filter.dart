import 'package:flutter/material.dart';
import 'package:job_listings/custom_dropdown.dart';
import 'package:job_listings/models/filter_model.dart';

class FilterWidget extends StatefulWidget {
  final List<FilterModel> filters;

  const FilterWidget({super.key, required this.filters});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final BoxDecoration filterBoxDecoration = BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.zero,
    );

    final double filterWidth = MediaQuery.of(context).size.width > 1100 ? 250.0 : 200.0;

    return Container(
      width: filterWidth,
      padding: const EdgeInsets.all(10.0),
      decoration: filterBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _isExpanded ? 'Hide Filter' : 'Show Filter',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
              ],
            ),
          ),
          const SizedBox(height: 10),
          AnimatedCrossFade(
            duration: Duration(milliseconds: 300),
            crossFadeState:
                _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: Column(
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
                ...widget.filters.map((filter) => CustomDropdown(
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
            secondChild: Container(), // Empty container when collapsed
          ),
        ],
      ),
    );
  }
}
