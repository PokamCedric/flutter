import 'package:flutter/material.dart';
import 'package:job_listings/jobs.dart';
import 'package:job_listings/models/filter_model.dart';
import 'package:job_listings/table_control.dart';
import 'jobs_table.dart';
import 'filter.dart';

class JobListingsPage extends StatefulWidget {
  const JobListingsPage({super.key});

  @override
  _JobListingsPageState createState() => _JobListingsPageState();
}

class _JobListingsPageState extends State<JobListingsPage> {
  late Future<List<Map<String, String>>> _futureJobs;
  int _rowsPerPage = 25;
  final List<int> _availableRowsPerPage = [10, 25, 50];
  int _currentPage = 1;
  int _totalHits = 13; // Dummy value for total hits

  @override
  void initState() {
    super.initState();
    _futureJobs = loadJobs();
  }

  void _handlePageChange(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width > 1100 ? 800.0 : 600.0;

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
          return Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: PaginationHeader(
                          totalPages: 2,
                          containerWidth: containerWidth,
                          totalHits: _totalHits,
                          rowsPerPage: _rowsPerPage,
                          availableRowsPerPage: _availableRowsPerPage,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              _rowsPerPage = value!;
                            });
                          },
                          currentPage: _currentPage,
                          onPageChanged: _handlePageChange,
                        ),
                      ),
                      Datatable(jobs: jobs, containerWidth: containerWidth),
                    ],
                  ),
                ),
                const SizedBox(width: 50), // space between table and filter
                Flexible(
                  flex: 1,
                  child: FilterWidget (
                    filters: [
                      FilterModel('Field', [
                        'All Fields',
                        'Food security, agriculture',
                        'Peace-building and crisis prevention',
                        'Infrastructure, ICT'
                      ]),
                      FilterModel('Type of function', [
                        'All types of function',
                        'Integrated Expert'
                      ]),
                      FilterModel('Country', [
                        'All countries',
                        'Kenya',
                        'Sri Lanka',
                        'Benin',
                        'Madagascar'
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
