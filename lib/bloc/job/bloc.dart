import 'package:bloc/bloc.dart';
import 'event.dart';
import 'state.dart';
import 'package:job_listings/jobs.dart'; // Adjust the import based on your file structure

class JobListingsBloc extends Bloc<JobListingsEvent, JobListingsState> {
  JobListingsBloc() : super(const JobListingsState()) {
    on<LoadJobsEvent>(_onLoadJobs);
    on<FilterJobsEvent>(_onFilterJobs);
    on<ChangePageEvent>(_onChangePage);
    on<ChangeRowsPerPageEvent>(_onChangeRowsPerPage);
  }

  Future<void> _onLoadJobs(LoadJobsEvent event, Emitter<JobListingsState> emit) async {
    final jobs = await loadJobs();
    emit(state.copyWith(
      allJobs: jobs,
      filteredJobs: jobs,
      totalHits: jobs.length,
    ));
  }

  void _onFilterJobs(FilterJobsEvent event, Emitter<JobListingsState> emit) {
    final filteredJobs = state.allJobs.where((job) {
      final filters = event.filters;
      bool matchesSearch = filters['Search'] == null ||
          filters['Search']!.isEmpty ||
          job.values.any((value) => value.toLowerCase().contains(filters['Search']!.toLowerCase()));

      bool matchesField = filters['Field'] == null ||
          filters['Field'] == 'All Fields' ||
          job['field'] == filters['Field'];

      bool matchesFunction = filters['Type of function'] == null ||
          filters['Type of function'] == 'All types of function' ||
          job['type'] == filters['Type of function'];

      bool matchesCountry = filters['Country'] == null ||
          filters['Country'] == 'All countries' ||
          job['country'] == filters['Country'];

      return matchesSearch && matchesField && matchesFunction && matchesCountry;
    }).toList();
    emit(state.copyWith(
      filteredJobs: filteredJobs,
      totalHits: filteredJobs.length,
      currentPage: 1,
    ));
  }

  void _onChangePage(ChangePageEvent event, Emitter<JobListingsState> emit) {
    emit(state.copyWith(currentPage: event.newPage));
  }

  void _onChangeRowsPerPage(ChangeRowsPerPageEvent event, Emitter<JobListingsState> emit) {
    emit(state.copyWith(rowsPerPage: event.newRowsPerPage, currentPage: 1));
  }
}
