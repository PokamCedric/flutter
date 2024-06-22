// job_model.dart
class JobModel {
  final String title;
  final String type;
  final String country;
  final String field;

  JobModel({
    required this.title,
    required this.type,
    required this.country,
    required this.field,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      title: json['title'] as String,
      type: json['type'] as String,
      country: json['country'] as String,
      field: json['field'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'country': country,
      'field': field,
    };
  }
}
