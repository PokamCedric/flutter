import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

  Future<List<Map<String, String>>> loadJobs() async {
    final String response = await rootBundle.loadString('assets/jobs.json');
    final List<dynamic> data = json.decode(response);
    return data.map((job) => Map<String, String>.from(job)).toList();
  }