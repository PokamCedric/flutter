// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:template_app/domain/value_objects/design_type.dart';

typedef LanguageDef = ({
  String id,
  String name,
});

const languageList = <LanguageDef>[
  (id: 'en', name: 'English (EN-US)'),
  (id: 'fr', name: 'Français (FR)'),
  (id: 'de', name: 'Deutsch (DE)'),
];

String languageDesign(String? value) => switch (value) {
      'ar' => AppDesignType.rtlGeneral.name,
      'de' => AppDesignType.germany.name,
      'zh' => AppDesignType.asiaGeneral.name,
      'fa' => AppDesignType.rtlGeneral.name,
      _ => AppDesignType.global.name,
    };
