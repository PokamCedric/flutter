import 'package:flutter/material.dart';
import 'package:job_listings/jobs_page.dart';
import 'package:job_listings/theme_collection.dart';

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

