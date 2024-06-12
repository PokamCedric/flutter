import 'package:flutter/material.dart';

class Datatable extends StatelessWidget {
  final List<Map<String, String>> jobs;

  Datatable({required this.jobs});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Job Title')),
          DataColumn(label: Text('Country')),
          DataColumn(label: Text('Field')),
        ],
        rows: jobs
            .map(
              (job) => DataRow(
                cells: [
                DataCell(PaddedTextCell(
                  text: job['title']!,
                  width: 300, // Fixed width for the Job Title column
                )),
                DataCell(PaddedTextCell(
                  text: job['country']!,
                  width: 50, // Adjust width as necessary
                )),
                DataCell(PaddedTextCell(
                  text: job['field']!,
                  width: 200, // Adjust width as necessary
                )),
              ]),
            )
            .toList(),
      ),
    );
  }
}
class PaddedTextCell extends StatelessWidget {
  final String text;
  final double width;

  const PaddedTextCell({
    required this.text,
    required this.width,
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
      ),
    );
  }
}