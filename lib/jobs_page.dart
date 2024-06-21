import 'package:flutter/material.dart';
import 'package:job_listings/jobs.dart';
import 'package:job_listings/utils/data_table/data_table.dart';
import 'package:job_listings/models/filter_model.dart';
import 'utils/data_table/data_table_widget.dart';
import 'utils/filter/filter_widget.dart';

class JobListingsPage extends StatefulWidget {
  const JobListingsPage({super.key});

  @override
  _JobListingsPageState createState() => _JobListingsPageState();
}

class _JobListingsPageState extends State<JobListingsPage> {
  late Future<List<Map<String, String>>> _futureJobs;
  List<Map<String, String>> _allJobs = [];
  List<Map<String, String>> _filteredJobs = [];
  int _rowsPerPage = 10;
  final List<int> _availableRowsPerPage = [5, 10, 25, 50];
  int _currentPage = 1;
  int _totalHits = 13; // Dummy value for total hits

  @override
  void initState() {
    super.initState();
    _futureJobs = loadJobs();
    _futureJobs.then((jobs) {
      setState(() {
        _allJobs = jobs;
        _filteredJobs = jobs;
        _totalHits = jobs.length;
      });
    });
  }

  void _handlePageChange(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  void _handleRowsPerPageChange(int? newRowsPerPage) {
    setState(() {
      _rowsPerPage = newRowsPerPage!;
      _currentPage = 1; // Reset to first page when rows per page changes
    });
  }

  void _handleFilterChange(Map<String, String> filters) {
    setState(() {
      _filteredJobs = _allJobs.where((job) {
        bool matchesSearch = filters['Search'] == null ||
            filters['Search']!.isEmpty ||
            job.values.any((value) => value.toLowerCase().contains(filters['Search']!.toLowerCase()));

        bool matchesField = filters['Field'] == null ||
            filters['Field'] == 'All Fields' ||
            job['field'] == filters['Field'];

        bool matchesFunction = filters['Type of function'] == null ||
            filters['Type of function'] == 'All types of function' ||
            job['type'] == filters['Type of function'];

        bool matchesCountry = filters['Country'] == null ||
            filters['Country'] == 'All countries' ||
            job['country'] == filters['Country'];

        return matchesSearch && matchesField && matchesFunction && matchesCountry;
      }).toList();
      _totalHits = _filteredJobs.length;
      _currentPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width > 1100 ? 800.0 : 600.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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

          final totalPages = (_totalHits / _rowsPerPage).ceil();

          return SingleChildScrollView(
            padding: const EdgeInsets.only(top: 50.0),
            child: desktopView(totalPages, containerWidth),
          );
        },
      ),
    );
  }

  Widget desktopView(int totalPages, double containerWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: DataTableWidget(
            data: _filteredJobs,
            containerWidth: containerWidth,
            rowsPerPage: _rowsPerPage,
            currentPage: _currentPage,
            totalPages: totalPages,
            totalHits: _totalHits,
            availableRowsPerPage: _availableRowsPerPage,
            onPageChanged: _handlePageChange,
            onRowsPerPageChanged: _handleRowsPerPageChange,
            columns: getTableColumns(),
          ),
        ),
        const SizedBox(width: 50), // space between table and filter
        Flexible(
          flex: 1,
          child: FilterWidget(
            length: _filteredJobs.length,
            filters: getFilterModels(),
            onFilterChanged: _handleFilterChange,
          ),
        ),
      ],
    );
  }

  List<ColumnConfig> getTableColumns() {
    return [
      ColumnConfig(label: 'Job Title', propertyName: 'title', isVisible: true),
      ColumnConfig(label: 'Type of Function', propertyName: 'type', isVisible: true),
      ColumnConfig(label: 'Country', propertyName: 'country', isVisible: true),
      ColumnConfig(label: 'Field', propertyName: 'field', isVisible: true),
    ];
  }

  List<FilterModel> getFilterModels() {
    return [
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
    ];
  }
}
