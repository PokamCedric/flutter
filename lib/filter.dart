import 'package:flutter/material.dart';
import 'package:job_listings/custom_dropdown.dart';
import 'package:job_listings/models/filter_model.dart';

class FilterWidget extends StatefulWidget {
  final List<FilterModel> filters;
  final ValueChanged<Map<String, String>> onFilterChanged;

  const FilterWidget({super.key, required this.filters, required this.onFilterChanged});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  bool _isExpanded = true;
  final Map<String, String> _selectedFilters = {};

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
            duration: const Duration(milliseconds: 300),
            crossFadeState:
                _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: filterBoxDecoration,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedFilters['Search'] = value;
                      });
                      widget.onFilterChanged(_selectedFilters);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // Dynamically create CustomDropdown widgets based on filters
                ...widget.filters.map((filter) => CustomDropdown(
                      label: filter.label,
                      items: filter.items,
                      filterWidth: filterWidth,
                      filterBoxDecoration: filterBoxDecoration,
                      onChanged: (value) {
                        setState(() {
                          _selectedFilters[filter.label] = value!;
                        });
                        widget.onFilterChanged(_selectedFilters);
                      },
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
                      widget.onFilterChanged(_selectedFilters);
                    },
                    child: const Text('Search Jobs'),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedFilters.clear();
                    });
                    widget.onFilterChanged(_selectedFilters);
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
