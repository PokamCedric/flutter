// jobs.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:job_listings/models/job_model.dart';

Future<List<JobModel>> loadJobs() async {
  final String response = await rootBundle.loadString('assets/jobs.json');
  final List<dynamic> data = json.decode(response);
  return data.map((job) => JobModel.fromJson(job)).toList();
}
