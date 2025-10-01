// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:template_app/_classes/structure/abstract_app_data.dart';
import 'package:template_app/_classes/storage/app_data.dart';
import 'package:template_app/_ext/date_time_ext.dart';
import 'package:flutter_currency_picker/flutter_currency_picker.dart';

class CurrencyAppData extends AbstractAppData {
  Currency? currencyFrom;

  CurrencyAppData({
    super.title = '',
    super.uuid = '',
    super.details = 1.0,
    super.description,
    this.currencyFrom,
    super.currency,
    super.hidden,
    super.updatedAt,
    super.createdAt,
  }) {
    super.description = DateTime.now().toString();
  }

  @override
  String getClassName() => 'CurrencyAppData';

  @override
  AppDataType getType() => AppDataType.currencies;

  @override
  CurrencyAppData clone() {
    return CurrencyAppData(
      title: super.title,
      uuid: super.uuid,
      details: super.details,
      currency: super.currency,
      currencyFrom: currencyFrom,
      hidden: super.hidden,
    );
  }

  factory CurrencyAppData.fromJson(Map<String, dynamic> json) {
    return CurrencyAppData(
      title: json['title'],
      uuid: json['uuid'],
      details: 0.0 + json['details'],
      updatedAt: DateTime.parse(json['updatedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      currency: CurrencyProvider.find(json['currency']),
      currencyFrom: CurrencyProvider.find(json['currencyFrom']),
      hidden: json['hidden'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'currencyFrom': currencyFrom?.code,
      };

  String get detailsFormatted => (super.details as double).toCurrency(currency: currency, withPattern: false);

  String get descriptionFormatted => DateTime.parse(super.description ?? '').yMEd();

  @override
  String get title => '${currencyFrom?.code ?? '?'} -> ${currency?.code ?? '?'}';

  @override
  String get uuid => '${currencyFrom?.code ?? '?'}-${currency?.code ?? '?'}';
}
