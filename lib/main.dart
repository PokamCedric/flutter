import 'package:flutter/material.dart';

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
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
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
            ),
          ),
          VerticalDivider(),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Keywords'),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Field'),
                    items: ['Food security, agriculture', 'Peace-building and crisis prevention', 'Infrastructure, ICT']
                        .map((field) => DropdownMenuItem<String>(
                              value: field,
                              child: Text(field),
                            ))
                        .toList(),
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Type of function'),
                    items: ['All types of function', 'Integrated Expert'].map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        )).toList(),
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Country'),
                    items: ['All countries', 'Kenya', 'Sri Lanka', 'Benin', 'Madagascar'].map((country) => DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        )).toList(),
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle search/filter action
                    },
                    child: Text('Search Jobs'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
