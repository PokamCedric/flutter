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
          DataColumn(label: Text('Type of function')),
          DataColumn(label: Text('Country')),
          DataColumn(label: Text('Field')),
        ],
        rows: jobs
            .map(
              (job) => DataRow(
                cells: [
                DataCell(PaddedTextCell(
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