import 'package:flutter/material.dart';
import 'package:job_listings/utils/filter/custom_dropdown.dart';
import 'package:job_listings/models/dropdown_filter_model.dart';

class Filter extends StatefulWidget {
  final List<DropdownFilterModel> filters;
  final int length;
  final ValueChanged<Map<String, dynamic>> onFilterChanged;

  const Filter({
    super.key,
    required this.filters,
    required this.onFilterChanged,
    required this.length});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<Filter> {
  bool _isExpanded = true;
  final Map<String, String> _selectedFilters = {};

  @override
  void initState() {
    super.initState();
    // Initialize _selectedFilters with the first item of each filter's items list
    for (var filter in widget.filters) {
      if (filter.items.isNotEmpty) {
        _selectedFilters[filter.propertyName] = filter.items.first;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration filterBoxDecoration({Color color = Colors.grey}) => BoxDecoration(
      border: Border.all(color: color),
      borderRadius: BorderRadius.zero,
    );

    final double filterWidth = MediaQuery.of(context).size.width > 1100 ? 250.0 : 200.0;

    return Container(
      width: filterWidth,
      decoration: filterBoxDecoration(color: Theme.of(context).primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SEARCH AGAIN',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
          divider(Theme.of(context).primaryColor),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState:
                  _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: filterBoxDecoration(),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedFilters['query'] = value;
                        });
                        widget.onFilterChanged(_selectedFilters);
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Dynamically create CustomDropdown widgets based on filters
                  ...widget.filters.map((filter) => CustomDropdown(
                        label: filter.propertyName,
                        items: filter.items,
                        value: _selectedFilters[filter.propertyName]!, // Ensure this line reflects the selected filter value
                        filterWidth: filterWidth,
                        filterBoxDecoration: filterBoxDecoration(),
                        onChanged: (value) {
                          setState(() {
                            _selectedFilters[filter.propertyName] = value!;
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
                      child: Text('${widget.length} found'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedFilters.clear();
                        // Reinitialize with the first item of each filter's items list
                        for (var filter in widget.filters) {
                          if (filter.items.isNotEmpty) {
                            _selectedFilters[filter.propertyName] = filter.items.first;
                          }
                        }
                      });
                      widget.onFilterChanged(_selectedFilters);
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              secondChild: Container(), // Empty container when collapsed
            ),
          ),
        ],
      ),
    );
  }

  Row divider(Color color) {
    return Row(children: <Widget>[
            Expanded(
              child: Divider(
                color: color,
                height: 10,
              ),
            ),
          ]);
  }
}
