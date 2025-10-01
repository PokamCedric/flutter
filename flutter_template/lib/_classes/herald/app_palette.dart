// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:template_app/_classes/storage/app_preferences.dart';
import 'package:template_app/_configs/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class AppPalette extends ValueNotifier<String> {
  static String get state => AppPreferences.get(AppPreferences.prefColor) ?? AppColors.colorApp;
  static String get light => AppPreferences.get(AppPreferences.prefPalette) ?? AppDefaultColors().toString();
  static String get dark => AppPreferences.get(AppPreferences.prefPaletteDark) ?? AppDarkColors().toString();

  AppPalette() : super(state);

  Future<void> setMode(String newValue) async {
    if (newValue != value) {
      value = newValue;
      await AppPreferences.set(AppPreferences.prefColor, value);
      notifyListeners();
    }
  }

  Future<void> set(AppDefaultColors light, AppDefaultColors dark) async {
    await AppPreferences.set(AppPreferences.prefPalette, light.toString());
    await AppPreferences.set(AppPreferences.prefPaletteDark, dark.toString());
    notifyListeners();
  }
}
