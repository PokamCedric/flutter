import 'package:flutter/material.dart';
import 'package:job_listings/text_cell.dart';

class Datatable extends StatelessWidget {
  final List<Map<String, String>> jobs;
  final double containerWidth;
  final int rowsPerPage;
  final int currentPage;

  const Datatable({
    super.key,
    required this.jobs,
    required this.containerWidth,
    required this.rowsPerPage,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final double tableWidth = containerWidth - 200.0;
    final Color titleColor = Theme.of(context).primaryColor;

    final displayedJobs = jobs.skip((currentPage - 1) * rowsPerPage).take(rowsPerPage).toList();

    return Expanded(
      child: SizedBox(
        width: containerWidth,
        child: DataTable(
          columns:  [
            DataColumn(label: columnTitle(titleColor, 'Job Title')),
            DataColumn(label: columnTitle(titleColor, 'Type of function')),
            DataColumn(label: columnTitle(titleColor, 'Country')),
            DataColumn(label: columnTitle(titleColor, 'Field')),
          ],
          rows: displayedJobs
              .map(
                (job) => DataRow(
                  cells: [
                  DataCell(PaddedTextCell(
                    color: Theme.of(context).colorScheme.secondary,
                    text: job['title'] ?? "",
                    width: tableWidth * (2/6),
                  )),
                  DataCell(PaddedTextCell(
                    text: job['type'] ?? "",
                    width: tableWidth * (1/6),
                  )),
                  DataCell(PaddedTextCell(
                    text: job['country'] ?? "",
                    width: tableWidth * (1/6),
                  )),
                  DataCell(PaddedTextCell(
                    text: job['field'] ?? "",
                    width: tableWidth * (2/6),
                  )),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }
}
