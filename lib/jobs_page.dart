import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_listings/bloc/job/job_bloc.dart';
import 'package:job_listings/models/filter_model.dart';
import 'package:job_listings/utils/data_table/data_table.dart';
import 'package:job_listings/utils/data_table/data_table_widget.dart';
import 'package:job_listings/utils/filter/filter_widget.dart';


class JobListingsPage extends StatelessWidget {
  const JobListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobListingsBloc()..add(LoadJobsEvent()),
      child: const JobListingsView(),
    );
  }
}

class JobListingsView extends StatelessWidget {
  const JobListingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width > 1100 ? 800.0 : 600.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Job Listings'),
      ),
      body: BlocBuilder<JobListingsBloc, JobListingsState>(
        builder: (context, state) {
          if (state.allJobs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final totalPages = (state.totalHits / state.rowsPerPage).ceil();

          return SingleChildScrollView(
            padding: const EdgeInsets.only(top: 50.0),
            child: desktopView(context, totalPages, containerWidth, state),
          );
        },
      ),
    );
  }

  Widget desktopView(BuildContext context, int totalPages, double containerWidth, JobListingsState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: DataTableWidget(
            data: state.filteredJobs,
            containerWidth: containerWidth,
            rowsPerPage: state.rowsPerPage,
            currentPage: state.currentPage,
            totalPages: totalPages,
            totalHits: state.totalHits,
            availableRowsPerPage: const [5, 10, 25, 50],
            onPageChanged: (newPage) => context.read<JobListingsBloc>().add(ChangePageEvent(newPage)),
            onRowsPerPageChanged: (newRowsPerPage) => context.read<JobListingsBloc>().add(ChangeRowsPerPageEvent(newRowsPerPage!)),
            columns: getTableColumns(),
          ),
        ),
        const SizedBox(width: 50), // space between table and filter
        Flexible(
          flex: 1,
          child: FilterWidget(
            length: state.filteredJobs.length,
            filters: getFilterModels(),
            onFilterChanged: (filters) => context.read<JobListingsBloc>().add(FilterJobsEvent(filters)),
          ),
        ),
      ],
    );
  }

  List<ColumnConfig> getTableColumns() {
    return [
      ColumnConfig(label: 'Job Title', propertyName: 'title', isVisible: true),
      ColumnConfig(label: 'Type of Function', propertyName: 'type', isVisible: true),
      ColumnConfig(label: 'Country', propertyName: 'country', isVisible: true),
      ColumnConfig(label: 'Field', propertyName: 'field', isVisible: true),
    ];
  }

}
