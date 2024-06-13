import 'package:flutter/material.dart';

class Datatable extends StatelessWidget {
  final List<Map<String, String>> jobs;

  Datatable({required this.jobs});

  @override
  Widget build(BuildContext context) {
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
                  width: 250,
                )),
                DataCell(PaddedTextCell(
                  text: job['type']?? "",
                  width: 100,
                )),
                DataCell(PaddedTextCell(
                  text: job['country']?? "",
                  width: 100,
                )),
                DataCell(PaddedTextCell(
                  text: job['field']?? "",
                  width: 200,
                )),
              ]),
            )
            .toList(),
      ),
    );
  }

  Text columnTitle(BuildContext context, String text) => Text(text, style: TextStyle(color: Theme.of(context).primaryColor));
}
class PaddedTextCell extends StatelessWidget {
  final String text;
  final double width;
  final Color? color;

   const PaddedTextCell({super.key,
    required this.text,
    required this.width,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Fixed width for the cell
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Custom vertical padding
      child: Text(
        text,
        softWrap: true, // Enable text wrapping
        overflow: TextOverflow.clip, // Clip overflowing text
        style: TextStyle(color: color),
      ),
    );
  }
}