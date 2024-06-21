import 'package:flutter/material.dart';
import 'package:job_listings/utils/pagination/table_control.dart';
import 'data_table.dart';

class DataTableWidget extends StatelessWidget {
  final List<Map<String, String>> data;
  final double containerWidth;
  final int rowsPerPage;
  final int currentPage;
  final int totalPages;
  final int totalHits;
  final List<int> availableRowsPerPage;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int?> onRowsPerPageChanged;
  final List<ColumnConfig> columns;

  const DataTableWidget({
    super.key,
    required this.data,
    required this.containerWidth,
    required this.rowsPerPage,
    required this.currentPage,
    required this.totalPages,
    required this.totalHits,
    required this.availableRowsPerPage,
    required this.onPageChanged,
    required this.onRowsPerPageChanged,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        paginationControl(),
        Datatable(
          data: data,
          containerWidth: containerWidth,
          rowsPerPage: rowsPerPage,
          currentPage: currentPage,
          columns: columns,
        ),
        paginationControl(),
      ],
    );
  }

  Widget paginationControl() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: PaginationControl(
        totalPages: totalPages,
        containerWidth: containerWidth,
        totalHits: totalHits,
        rowsPerPage: rowsPerPage,
        availableRowsPerPage: availableRowsPerPage,
        onRowsPerPageChanged: onRowsPerPageChanged,
        currentPage: currentPage,
        onPageChanged: onPageChanged,
      ),
    );
  }
}


