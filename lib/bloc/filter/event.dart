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

class ChangePageEvent extends FilterEvent {
  final int newPage;

  const ChangePageEvent(this.newPage);

  @override
  List<Object> get props => [newPage];
}

class ChangeRowsPerPageEvent extends FilterEvent {
  final int newRowsPerPage;

  const ChangeRowsPerPageEvent(this.newRowsPerPage);

  @override
  List<Object> get props => [newRowsPerPage];
}