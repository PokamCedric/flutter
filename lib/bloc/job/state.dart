import 'package:equatable/equatable.dart';

class JobListingsState extends Equatable {
  final List<Map<String, String>> allJobs;
  final List<Map<String, String>> filteredJobs;
  final int rowsPerPage;
  final int currentPage;
  final int totalHits;

  const JobListingsState({
    this.allJobs = const [],
    this.filteredJobs = const [],
    this.rowsPerPage = 10,
    this.currentPage = 1,
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
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      currentPage: currentPage ?? this.currentPage,
      totalHits: totalHits ?? this.totalHits,
    );
  }

  @override
  List<Object> get props => [allJobs, filteredJobs, rowsPerPage, currentPage, totalHits];
}
