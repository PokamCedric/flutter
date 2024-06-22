import 'package:bloc/bloc.dart';
import 'event.dart';
import 'state.dart';
import 'package:job_listings/jobs.dart'; // Adjust the import based on your file structure

class JobListingsBloc extends Bloc<JobListingsEvent, JobListingsState> {
  JobListingsBloc() : super(const JobListingsState()) {
    on<LoadJobsEvent>(_onLoadJobs);
    on<FilterJobsEvent>(_onFilterJobs);
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
      final filter = event.filter;
      bool matchesSearch = filter.query== null ||
          filter.query!.isEmpty ||
          job.title.toLowerCase().contains(filter.query!.toLowerCase()) ||
          job.type.toLowerCase().contains(filter.query!.toLowerCase()) ||
          job.country.toLowerCase().contains(filter.query!.toLowerCase()) ||
          job.field.toLowerCase().contains(filter.query!.toLowerCase());

      bool matchesField = filter.field == 'All Fields' ||
          job.field == filter.field;

      bool matchesFunction = filter.type == 'All types of function' ||
          job.type == filter.type;

      bool matchesCountry = filter.country== 'All countries' ||
          job.country== filter.country;

      return matchesSearch && matchesField && matchesFunction && matchesCountry;
    }).toList();

    emit(state.copyWith(
      filteredJobs: filteredJobs,
      totalHits: filteredJobs.length,
      currentPage: 1,
    ));
  }
}
