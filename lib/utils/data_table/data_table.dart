import 'package:flutter/material.dart';
import 'package:job_listings/utils/data_table/text_cell.dart';

class Datatable extends StatelessWidget {
  final List<Map<String, String>> data;
  final double containerWidth;
  final int rowsPerPage;
  final int currentPage;
  final List<ColumnConfig> columns; // List of column configurations

  const Datatable({
    super.key,
    required this.data,
    required this.containerWidth,
    required this.rowsPerPage,
    required this.currentPage,
    required this.columns, // Added list of columns
  });

  @override
  Widget build(BuildContext context) {
    final double tableWidth = containerWidth - 200.0;
    final Color titleColor = Theme.of(context).primaryColor;

    final displayedJobs =
        data.skip((currentPage - 1) * rowsPerPage).take(rowsPerPage).toList();

    // Filter visible columns based on isVisible flag
    List<DataColumn> visibleColumns = columns
        .where((column) => column.isVisible)
        .map((column) => DataColumn(label: columnTitle(titleColor, column.label)))
        .toList();

    return SizedBox(
      width: containerWidth,
      child: DataTable(
        columns: visibleColumns,
        rows: displayedJobs
            .map(
              (job) => DataRow(
                cells: columns
                    .where((column) => column.isVisible)
                    .map((column) => DataCell(PaddedTextCell(
                          text: job[column.propertyName] ?? "",
                          width: tableWidth * (1 / visibleColumns.length),
                        )))
                    .toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}

// Model class to represent a column configuration
class ColumnConfig {
  final String label;
  final String propertyName; // Property name in the job map
  final bool isVisible; // Visibility flag

  ColumnConfig({
    required this.label,
    required this.propertyName,
    this.isVisible = true, // Default visibility to true
  });
}

// Helper function to create column titles with specified color
Widget columnTitle(Color color, String title) {
  return Text(
    title,
    style: TextStyle(color: color, fontWeight: FontWeight.bold),
  );
}
