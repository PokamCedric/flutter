import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_listings/jobs.dart';
import 'jobs_table.dart';
import 'filter.dart';

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
        title: const Text('Job Listings'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _futureJobs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading jobs'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No jobs available'));
          }

          final jobs = snapshot.data!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: Datatable(jobs: jobs),
              ),
              const SizedBox(width: 20), // Espace fixe entre Datatable et Filter
              Flexible(
                flex: 1,
                child: Filter(),
              ),
            ],
          );
        },
      ),
    );
  }
}
