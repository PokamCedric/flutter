// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'dart:convert';

extension MapExt on String {
  T _asType<T>(dynamic value) {
    return switch (T) {
      const (int) => int.tryParse(value) as T,
      const (double) => double.tryParse(value) as T,
      const (String) => value.toString() as T,
      _ => null as T,
    };
  }

  Map<T, K> toMap<T, K>() {
    final data = length > 0 ? substring(1, length - 1).split(',') : [];
    final Map<T, K> result = {};
    for (final pair in data) {
      final parts = pair.split(':');
      if (parts.length != 2 || parts[0] == null) {
        continue;
      }
      final key = _asType<T>(parts[0].trim());
      result[key] = _asType<K>(parts[1].trim());
    }
    return result;
  }

  String _wrap() {
    if (contains('{')) {
      RegExp pattern = RegExp(r"(\w+):\s*([\w\.\- ]+)");
      return replaceAllMapped(pattern, (match) {
        String key = match.group(1) ?? '_';
        String value = match.group(2)?.trim() ?? '';
        return '"$key": ${num.tryParse(value) ?? '"$value"'}';
      });
    }
    return this;
  }

  List<T> toList<T>() {
    final data = length > 0 ? json.decode(_wrap()) : [];
    final List<T> result = [];
    for (final value in data) {
      result.add(value);
    }
    return result;
  }

  T toEnum<T>(List<T> values) => values.firstWhere((e) => e.toString() == this);

  int toInt() => int.parse(this);
}
