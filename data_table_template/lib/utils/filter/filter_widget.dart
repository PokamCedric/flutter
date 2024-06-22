// filter_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_listings/bloc/filter/filter_bloc.dart';
import 'package:job_listings/models/dropdown_filter_model.dart';
import 'filter.dart';

class FilterWidget extends StatelessWidget {
  final int totalItems;
  final double filterWidth;
  final int filtersPerLine;
  final List<DropdownFilterModel> filters;
  final Function(Map<String, dynamic>) onFilterChanged;

  const FilterWidget({
    super.key,
    required this.totalItems,
    required this.filters,
    required this.onFilterChanged,
    this.filterWidth = 300.0,
    this.filtersPerLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterBloc(),
      child: Filter(
        totalItems: totalItems,
        filterWidth: filterWidth,
        filtersPerLine: filtersPerLine,
        filters: filters,
        onFilterChanged: onFilterChanged,
      ),
    );
  }
}
