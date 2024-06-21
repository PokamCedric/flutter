import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final Map<String, String> filters;
  final int currentPage;
  final int rowsPerPage;

  const FilterState({
    required this.filters,
    required this.currentPage,
    required this.rowsPerPage,
  });

  FilterState copyWith({
    Map<String, String>? filters,
    int? currentPage,
    int? rowsPerPage,
  }) {
    return FilterState(
      filters: filters ?? this.filters,
      currentPage: currentPage ?? this.currentPage,
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
    );
  }

  @override
  List<Object> get props => [filters, currentPage, rowsPerPage];
}
