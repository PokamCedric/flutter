import 'package:equatable/equatable.dart';

class JobListingsState extends Equatable {
  final List<Map<String, String>> allJobs;
  final List<Map<String, String>> filteredJobs;
  final int totalHits;

  const JobListingsState({
    this.allJobs = const [],
    this.filteredJobs = const [],
    this.totalHits = 0,
  });

  JobListingsState copyWith({
    List<Map<String, String>>? allJobs,
    List<Map<String, String>>? filteredJobs,
    int? rowsPerPage,
    int? currentPage,
    int? totalHits,
  }) {
    return JobListingsState(
      allJobs: allJobs ?? this.allJobs,
      filteredJobs: filteredJobs ?? this.filteredJobs,
      totalHits: totalHits ?? this.totalHits,
    );
  }

  @override
  List<Object> get props => [allJobs, filteredJobs, totalHits];
}
