import 'package:flutter/material.dart';
import 'jobs_table.dart';
import 'filter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JobListingsPage(),
    );
  }
}

class JobListingsPage extends StatefulWidget {
  @override
  _JobListingsPageState createState() => _JobListingsPageState();
}

class _JobListingsPageState extends State<JobListingsPage> {
  final List<Map<String, String>> jobs = [
    {'title': 'Senior Expert in Inclusive Scaling', 'country': 'Kenya', 'field': 'Food security, agriculture'},
    {'title': 'Senior Researcher Food Environment and Consumer Behavior', 'country': 'Kenya', 'field': 'Food security, agriculture'},
    {'title': 'Specialist - Vegetable Variety Scaling', 'country': 'Benin', 'field': 'Food security, agriculture'},
    {'title': 'Innovation Scaling Focal Point (m/f/d)', 'country': 'Sri Lanka', 'field': 'Food security, agriculture'},
    {'title': 'Spécialiste intégrée de la recherche et de la rédaction', 'country': 'Madagascar', 'field': 'Peace-building and crisis prevention'},
    {'title': 'Environmental Economist', 'country': 'Kenya', 'field': 'Environmental protection and sustainable use of natural resources'},
    {'title': 'Senior Fellow - Energy transition and EU-India partnership', 'country': 'India', 'field': 'Infrastructure, ICT'},
    {'title': 'Specialist in foresight for a territorialization of agroecology', 'country': 'Senegal', 'field': 'Food security, agriculture'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Listings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 180.0), // Add horizontal margin
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Datatable(jobs: jobs),
            ),
            SizedBox(width: 40), // Add space between Datatable and Filter
            Expanded(
              flex: 1,
              child: Filter(),
            ),
          ],
        ),
      ),
    );
  }
}
