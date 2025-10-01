import 'package:equatable/equatable.dart';
import 'package:job_listings/models/filter_model.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class ChangeFilterEvent extends FilterEvent {
  final FilterModel filters;

  const ChangeFilterEvent(this.filters);

  @override
  List<Object> get props => [filters];
}
