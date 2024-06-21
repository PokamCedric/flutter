import 'package:equatable/equatable.dart';

abstract class JobListingsEvent extends Equatable {
  const JobListingsEvent();

  @override
  List<Object> get props => [];
}

class LoadJobsEvent extends JobListingsEvent {}

class FilterJobsEvent extends JobListingsEvent {
  final Map<String, String> filters;

  const FilterJobsEvent(this.filters);

  @override
  List<Object> get props => [filters];
}

class ChangePageEvent extends JobListingsEvent {
  final int newPage;

  const ChangePageEvent(this.newPage);

  @override
  List<Object> get props => [newPage];
}

class ChangeRowsPerPageEvent extends JobListingsEvent {
  final int newRowsPerPage;

  const ChangeRowsPerPageEvent(this.newRowsPerPage);

  @override
  List<Object> get props => [newRowsPerPage];
}
