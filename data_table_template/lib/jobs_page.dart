// job_listings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_listings/bloc/data_table/data_table_bloc.dart';
import 'package:job_listings/bloc/job/job_bloc.dart';
import 'package:job_listings/core/presentation/extensions/responsive_extension.dart';
import 'package:job_listings/models/dropdown_filter_model.dart';
import 'package:job_listings/models/filter_model.dart';
import 'package:job_listings/utils/data_table/data_table.dart';
import 'package:job_listings/utils/data_table/data_table_widget.dart';
import 'package:job_listings/utils/filter/filter_widget.dart';
import 'package:job_listings/bloc/filter/filter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

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

                  return SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: ResponsiveRowColumn(
                                columnMainAxisAlignment: MainAxisAlignment.center,
                                columnCrossAxisAlignment: CrossAxisAlignment.center,
                                rowMainAxisAlignment: MainAxisAlignment.center,
                                rowCrossAxisAlignment: CrossAxisAlignment.center,
                                columnSpacing: 32,
                                rowSpacing: 32,
                                layout: context.isDisplayLargerThanSmallDesktop
                                    ? ResponsiveRowColumnType.ROW
                                    : ResponsiveRowColumnType.COLUMN,
                                children: [
                                  ResponsiveRowColumnItem(
                                    rowOrder: 1,
                                    columnOrder: 2,
                                    rowFlex: 3,
                                    child: _dataTableLayout(context),
                                  ),
                                  ResponsiveRowColumnItem(
                                    rowFlex: 1,
                                    rowOrder: 2,
                                    columnOrder: 1,
                                    child: _filterLayout(context),
                                  ),
                                ],
                              ),
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

  Widget _filterLayout(
    BuildContext context,
    {int filtersPerLine = 1}
  ) {
    return BlocBuilder<JobListingsBloc, JobListingsState>(
            builder: (context, state) {
              return FilterWidget(
                      totalItems: state.filteredJobs.length,
                      filterWidth: context.filterWidth,
                      filtersPerLine: filtersPerLine,
                      filters: getDropdownFilterModels(),
                      onFilterChanged: (filters) =>
                          context.read<JobListingsBloc>().add(FilterJobsEvent(FilterModel.fromJson(filters))),
                    );
            }
    );
  }

  Widget _dataTableLayout(
    BuildContext context,
  ) {
    const double containerWidth = 800.0;
    return BlocBuilder<JobListingsBloc, JobListingsState>(
            builder: (context, state) {
              return BlocBuilder<DataTableBloc, DataTableState>(
                builder: (context, dataTableState) {
                  final totalPages = (state.totalHits / dataTableState.rowsPerPage).ceil();

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
                            columns: getTableColumns(containerWidth)
                          );
                }
              );
            }
    );
  }

  List<ColumnConfig> getTableColumns(double containerWidth) {
    const double defaultSpace = 50.0;
    return [
      ColumnConfig(label: 'Job Title', propertyName: 'title', isVisible: true, width: 300.0),
      ColumnConfig(label: 'Type of Function', propertyName: 'type', isVisible: containerWidth - defaultSpace > 300.0, width: 150.0),
      ColumnConfig(label: 'Country', propertyName: 'country', isVisible: containerWidth - defaultSpace > 300.0 + 150.0),
      ColumnConfig(label: 'Field', propertyName: 'field', isVisible: containerWidth - defaultSpace > 300.0 + 150.0 + 100.0, width: 200.0),
    ];
  }

}
