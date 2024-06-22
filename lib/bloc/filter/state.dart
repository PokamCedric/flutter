import 'package:equatable/equatable.dart';
import 'package:job_listings/models/filter_model.dart';

class FilterState extends Equatable {
  final FilterModel filter;

  const FilterState({
    required this.filter,
  });

  FilterState copyWith({
    FilterModel? filter,
  }) {
    return FilterState(
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [filter];
}
