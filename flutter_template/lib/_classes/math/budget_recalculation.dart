// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:template_app/_classes/math/abstract_recalculation.dart';
import 'package:template_app/_classes/structure/budget_app_data.dart';

class BudgetRecalculation extends AbstractRecalculation {
  BudgetAppData change;
  BudgetAppData? initial;

  BudgetRecalculation({
    required this.change,
    this.initial,
  });

  @override
  double getDelta() {
    if (initial?.amountLimit == 0 && change.amountLimit > 0) {
      return (initial?.amount ?? 0.0) / change.amountLimit;
    } else if (!change.hidden && initial?.hidden == false && change.amountLimit > 0) {
      return initial!.amountLimit * initial!.progress / change.amountLimit;
    } else {
      return 0.0;
    }
  }

  BudgetRecalculation updateBudget() {
    change.progress = getDelta();
    change.amount = initial?.amount ?? 0.0;
    return this;
  }
}
