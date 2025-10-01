import 'package:equatable/equatable.dart';
import 'package:job_listings/models/filter_model.dart';

abstract class JobListingsEvent extends Equatable {
  const JobListingsEvent();

  @override
  List<Object> get props => [];
}

class LoadJobsEvent extends JobListingsEvent {}

class FilterJobsEvent extends JobListingsEvent {
  final FilterModel filter;

  const FilterJobsEvent(this.filter);

  @override
  List<Object> get props => [filter];
}
