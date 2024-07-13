import 'package:flutter/material.dart';
import 'package:job_listings/jobs_page.dart';
import 'package:job_listings/theme_collection.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CollectionTheme.getCollectionTheme(), // Apply the custom theme
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: const JobListingsPage(),

        breakpoints: [
            const Breakpoint(start: 0, end: 360, name: 'SMALL_MOBILE'),
            const Breakpoint(start: 361, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1100, name: 'SMALL_DESKTOP'),
            const Breakpoint(start: 1101, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}

