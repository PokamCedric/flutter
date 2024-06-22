// job_listings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_listings/bloc/data_table/data_table_bloc.dart';
import 'package:job_listings/bloc/job/job_bloc.dart';
import 'package:job_listings/models/dropdown_filter_model.dart';
import 'package:job_listings/models/filter_model.dart';
import 'package:job_listings/utils/data_table/data_table.dart';
import 'package:job_listings/utils/data_table/data_table_widget.dart';
import 'package:job_listings/utils/filter/filter_widget.dart';
import 'package:job_listings/bloc/filter/filter_bloc.dart';

class JobListingsPage extends StatelessWidget {
  const JobListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => JobListingsBloc()..add(LoadJobsEvent())),
        BlocProvider(create: (context) => FilterBloc()),
        BlocProvider(create: (context) => DataTableBloc()), // Provide DataTableBloc
      ],
      child: const JobListingsView(),
    );
  }
}
class JobListingsView extends StatelessWidget {
  const JobListingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = mediaWidth > 1100.0;
    final double containerWidth = isDesktop ? 800.0 : 600.0;
    final double filterWidth = isDesktop ? 250.0 : mediaWidth - 100.0;

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

          return BlocBuilder<FilterBloc, FilterState>(
            builder: (context, filterState) {
              return BlocBuilder<DataTableBloc, DataTableState>(
                builder: (context, dataTableState) {
                  final totalPages = (state.totalHits / dataTableState.rowsPerPage).ceil();

                  return SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: isDesktop
                        ? desktopView(
                            context,
                            totalPages,
                            containerWidth,
                            filterWidth,
                            state,
                            filterState,
                            dataTableState,
                          )
                        : phoneView(
                            context,
                            totalPages,
                            containerWidth,
                            filterWidth,
                            state,
                            filterState,
                            dataTableState,
                          ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  FilterWidget buildFilterWidget(
    JobListingsState state,
    double filterWidth,
    BuildContext context,
  ) {
    return FilterWidget(
      totalItems: state.filteredJobs.length,
      filterWidth: filterWidth,
      filters: getDropdownFilterModels(),
      onFilterChanged: (filters) =>
          context.read<JobListingsBloc>().add(FilterJobsEvent(FilterModel.fromJson(filters))),
    );
  }

  DataTableWidget buildDataTableWidget(
    JobListingsState state,
    double containerWidth,
    DataTableState dataTableState,
    int totalPages,
    BuildContext context,
  ) {
    return DataTableWidget(
      data: state.filteredJobs.map((job) => job.toJson()).toList(),
      containerWidth: containerWidth,
      rowsPerPage: dataTableState.rowsPerPage,
      currentPage: dataTableState.currentPage,
      totalPages: totalPages,
      totalHits: state.totalHits,
      availableRowsPerPage: const [5, 10, 25, 50],
      onPageChanged: (newPage) => context.read<DataTableBloc>().add(ChangePageEvent(newPage)),
      onRowsPerPageChanged: (newRowsPerPage) =>
          context.read<DataTableBloc>().add(ChangeRowsPerPageEvent(newRowsPerPage!)),
      columns: getTableColumns(),
    );
  }

  List<ColumnConfig> getTableColumns() {
    return [
      ColumnConfig(label: 'Job Title', propertyName: 'title', isVisible: true, width: 300.0),
      ColumnConfig(label: 'Type of Function', propertyName: 'type', isVisible: true, width: 150.0),
      ColumnConfig(label: 'Country', propertyName: 'country', isVisible: true),
      ColumnConfig(label: 'Field', propertyName: 'field', isVisible: true, width: 200.0),
    ];
  }

  Widget desktopView(
    BuildContext context,
    int totalPages,
    double containerWidth,
    double filterWidth,
    JobListingsState state,
    FilterState filterState,
    DataTableState dataTableState,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildDataTableWidget(state, containerWidth, dataTableState, totalPages, context),
        const SizedBox(width: 50), // space between table and filter
        buildFilterWidget(state, filterWidth, context),
      ],
    );
  }

  Widget phoneView(
    BuildContext context,
    int totalPages,
    double containerWidth,
    double filterWidth,
    JobListingsState state,
    FilterState filterState,
    DataTableState dataTableState,
  ) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildFilterWidget(state, filterWidth, context),
          const SizedBox(height: 50), // space between table and filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: buildDataTableWidget(state, containerWidth, dataTableState, totalPages, context),
          ),
        ],
      ),
    );
  }
}
