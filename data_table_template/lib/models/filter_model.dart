// filter_model.dart
import 'package:job_listings/models/job_model.dart';

class FilterModel extends JobModel {
  String? query;

  FilterModel({
    required super.type,
    required super.country,
    required super.field,
    this.query,
  }): super(title: '');

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      type: json['type'] as String,
      country: json['country'] as String,
      field: json['field'] as String,
      query: json['query'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['query'] = query;
    return data;
  }

  // Default instance method
  factory FilterModel.defaultInstance() {
    return FilterModel(
      type: 'All types of function',
      country: 'All countries',
      field: 'All Fields',
      query: '',
    );
  }
}
