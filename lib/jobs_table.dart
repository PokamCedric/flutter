import 'package:flutter/material.dart';
import 'package:job_listings/text_cell.dart';

class Datatable extends StatelessWidget {
  final List<Map<String, String>> jobs;

  const Datatable({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double tableWidth;

    if (screenWidth > 1100) {
      tableWidth = 600.0;
    } else {
      tableWidth = 400.0;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns:  [
          DataColumn(label: columnTitle(context, 'Job Title')),
          DataColumn(label: columnTitle(context, 'Type of function')),
          DataColumn(label: columnTitle(context, 'Country')),
          DataColumn(label: columnTitle(context, 'Field')),
        ],
        rows: jobs
            .map(
              (job) => DataRow(
                cells: [
                DataCell(PaddedTextCell(
                  color: Theme.of(context).colorScheme.secondary,
                  text: job['title']?? "",
                  width: tableWidth * (2/6),
                )),
                DataCell(PaddedTextCell(
                  text: job['type']?? "",
                  width: tableWidth * (1/6),
                )),
                DataCell(PaddedTextCell(
                  text: job['country']?? "",
                  width: tableWidth * (1/6),
                )),
                DataCell(PaddedTextCell(
                  text: job['field']?? "",
                  width: tableWidth * (2/6),
                )),
              ]),
            )
            .toList(),
      ),
    );
  }

  Text columnTitle(BuildContext context, String text) => Text(text, style: TextStyle(color: Theme.of(context).primaryColor));
}
