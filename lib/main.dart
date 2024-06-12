import 'package:flutter/material.dart';
import 'package:job_listings/jobs.dart';
import 'package:job_listings/theme_collection.dart';
import 'jobs_table.dart';
import 'filter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CollectionTheme.getCollectionTheme(), // Apply the custom theme
      home: JobListingsPage(),
    );
  }
}

class JobListingsPage extends StatefulWidget {
  @override
  _JobListingsPageState createState() => _JobListingsPageState();
}

class _JobListingsPageState extends State<JobListingsPage> {
  late Future<List<Map<String, String>>> _futureJobs;

  @override
  void initState() {
    super.initState();
    _futureJobs = loadJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Listings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 180.0), // Add horizontal margin
        child: FutureBuilder<List<Map<String, String>>>(
          future: _futureJobs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading jobs'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No jobs available'));
            }

            final jobs = snapshot.data!;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Datatable(jobs: jobs),
                ),
                SizedBox(width: 40), // Add space between Datatable and Filter
                Expanded(
                  flex: 1,
                  child: Filter(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
