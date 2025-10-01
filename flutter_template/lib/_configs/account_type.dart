// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:template_app/_classes/herald/app_locale.dart';
import 'package:template_app/design/form/list_selector_item.dart';

enum AppAccountType {
  account,
  cash,
  debitCard,
  creditCard,
  deposit,
  credit,
}

class AccountType {
  static List<ListSelectorItem> getList() {
    return [
      ListSelectorItem(id: AppAccountType.account.toString(), name: AppLocale.labels.bankAccount),
      ListSelectorItem(id: AppAccountType.cash.toString(), name: AppLocale.labels.cash),
      ListSelectorItem(id: AppAccountType.debitCard.toString(), name: AppLocale.labels.debitCard),
      ListSelectorItem(id: AppAccountType.creditCard.toString(), name: AppLocale.labels.creditCard),
      ListSelectorItem(id: AppAccountType.deposit.toString(), name: AppLocale.labels.deposit),
      ListSelectorItem(id: AppAccountType.credit.toString(), name: AppLocale.labels.credit),
    ];
  }

  static String getLabel(String id) => getList().firstWhere((e) => e.id == id).name;

  static bool contains(String id, List<AppAccountType> type) => type.map((e) => e.toString()).contains(id);
}
