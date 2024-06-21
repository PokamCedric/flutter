import 'package:flutter/material.dart';
import 'package:job_listings/models/filter_model.dart';
import 'filter.dart';

class FilterWidget extends StatelessWidget {
  final int length;
  final List<FilterModel> filters;
  final ValueChanged<Map<String, String>> onFilterChanged;

  const FilterWidget({
    super.key,
    required this.length,
    required this.filters,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Filter(
      length: length,
      filters: filters,
      onFilterChanged: onFilterChanged,
    );
  }
}
