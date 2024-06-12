import 'package:flutter/material.dart';


class Datatable extends StatelessWidget {
  final List<Map<String, String>> jobs;

  const Datatable({required this.jobs});

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
              (job) => DataRow(cells: [
                DataCell(Text(job['title']!)),
                DataCell(Text(job['country']!)),
                DataCell(Text(job['field']!)),
              ]),
            )
            .toList(),
      ),
    );
  }
}

