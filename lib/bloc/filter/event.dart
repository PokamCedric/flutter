import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class ChangeFilterEvent extends FilterEvent {
  final Map<String, String> filters;

  const ChangeFilterEvent(this.filters);

  @override
  List<Object> get props => [filters];
}
