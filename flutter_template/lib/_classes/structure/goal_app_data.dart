// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:template_app/_classes/structure/abstract_app_data.dart';
import 'package:template_app/_classes/storage/app_data.dart';
import 'package:template_app/_ext/date_time_ext.dart';
import 'package:template_app/_ext/int_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency_picker/flutter_currency_picker.dart';

class GoalAppData extends AbstractAppData {
  DateTime _closedAt;
  double initial;

  GoalAppData({
    required super.title,
    required this.initial,
    super.uuid,
    super.details = 0.0,
    super.progress = 0.0,
    super.description,
    super.color,
    super.icon,
    super.currency,
    super.updatedAt,
    super.createdAt,
    super.createdAtFormatted,
    DateTime? closedAt,
    String? closedAtFormatted,
    super.hidden,
  }) : _closedAt = closedAt ?? (closedAtFormatted != null ? DateTime.parse(closedAtFormatted) : DateTime.now());

  @override
  String getClassName() => 'GoalAppData';

  @override
  AppDataType getType() => AppDataType.goals;

  @override
  GoalAppData clone() {
    return GoalAppData(
      title: super.title,
      initial: initial,
      uuid: super.uuid,
      details: super.details,
      progress: super.progress,
      description: super.description,
      color: super.color,
      icon: super.icon,
      currency: super.currency,
      createdAt: super.createdAt,
      closedAt: closedAt,
      hidden: super.hidden,
    );
  }

  factory GoalAppData.fromJson(Map<String, dynamic> json) {
    return GoalAppData(
      title: json['title'],
      initial: json['initial'] ?? 0.0,
      uuid: json['uuid'],
      details: 0.0 + json['details'],
      progress: 0.0 + json['progress'],
      description: json['description'],
      color: json['color'] != null ? MaterialColor(json['color'], const <int, Color>{}) : null,
      icon: (json['icon'] as int?)?.toIcon(),
      currency: CurrencyProvider.find(json['currency']),
      updatedAt: DateTime.parse(json['updatedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      closedAt: DateTime.parse(json['closedAt']),
      hidden: json['hidden'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'initial': initial,
        'closedAt': closedAt.toIso8601String(),
      };

  // ignore: unnecessary_getters_setters
  DateTime get closedAt => _closedAt;
  set closedAt(DateTime value) => _closedAt = value;
  String get closedAtFormatted => _closedAt.yMEd();
  set closedAtFormatted(String value) => _closedAt = DateTime.parse(value);

  double get state {
    DateTime currentDate = DateTime.now();
    if (closedAt.isBefore(currentDate) || closedAt.isAtSameMomentAs(currentDate)) {
      return 1.0;
    } else if (currentDate.isBefore(super.createdAt) || super.createdAt.isAtSameMomentAs(currentDate)) {
      return 0.0;
    } else {
      double totalDays = closedAt.difference(super.createdAt).inDays.toDouble();
      double currentDays = currentDate.difference(super.createdAt).inDays.toDouble();
      return currentDays / totalDays;
    }
  }

  String get detailsFormatted => (super.details as double).toCurrency(currency: currency, withPattern: false);
}
