// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:template_app/_classes/math/abstract_recalculation.dart';
import 'package:template_app/_classes/structure/account_app_data.dart';

class AccountRecalculation extends AbstractRecalculation {
  AccountAppData change;
  AccountAppData? initial;

  AccountRecalculation({
    required this.change,
    this.initial,
  });

  @override
  double getDelta() {
    return change.hidden
        ? -(initial?.details ?? 0.0)
        : (initial?.hidden ?? true ? change.details : change.details - initial?.details);
  }
}
