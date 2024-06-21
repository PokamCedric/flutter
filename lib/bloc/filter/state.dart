import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final Map<String, String> filters;

  const FilterState({
    required this.filters,
  });

  FilterState copyWith({
    Map<String, String>? filters,
  }) {
    return FilterState(
      filters: filters ?? this.filters,
    );
  }

  @override
  List<Object> get props => [filters];
}
