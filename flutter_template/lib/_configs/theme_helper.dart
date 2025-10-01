// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'dart:math';

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:template_app/_classes/herald/app_zoom.dart';
import 'package:template_app/_configs/screen_helper.dart';
import 'package:flutter/material.dart';

class _Sizes {
  static const half = 4.0;
  static const normal = 8.0;
  static const double = 16.0;
  static const triple = 24.0;
  static const quatre = 32.0;
  static const sixfold = 48.0;
}

class ThemeHelper {
  static const barHeight = 48.0;
  static const menuWidth = 200.0;
  static late bool isWearable;
  static const emptyBox = SizedBox();
  static const formEndBox = SizedBox(height: 110);
  static const hIndent = SizedBox(height: _Sizes.normal);
  static const hIndent2x = SizedBox(height: _Sizes.double);
  static const hIndent3x = SizedBox(height: _Sizes.triple);
  static const hIndent4x = SizedBox(height: _Sizes.quatre);
  static const hIndent6x = SizedBox(height: _Sizes.sixfold);
  static const hIndent05 = SizedBox(height: _Sizes.half);
  static const wIndent = SizedBox(width: _Sizes.normal);
  static const wIndent2x = SizedBox(width: _Sizes.double);

  static double getIndent([double multiply = 1]) => _Sizes.normal / AppZoom.state * multiply;

  static double _env(BuildContext context, BoxConstraints? constraints) =>
      (constraints != null &&
              (isNavRight(context, constraints) || ScreenHelper.state().isRight) &&
              !(isWearable || ScreenHelper.state().isWearable)
          ? barHeight
          : 0) +
      (constraints != null && isWideScreen(constraints) || ScreenHelper.state().isWide ? menuWidth : 0);

  static double getMaxWidth(BuildContext context, BoxConstraints constraints) =>
      constraints.maxWidth - _env(context, constraints);

  static double getWidth(BuildContext context,
          [double multiply = 4, BoxConstraints? constraints, bool withZoom = true]) =>
      MediaQuery.sizeOf(context).width / (withZoom ? AppZoom.state : 1) -
      getIndent(multiply) -
      _env(context, constraints);

  static double getHeight(BuildContext context, [double multiply = 2]) =>
      MediaQuery.sizeOf(context).height / AppZoom.state - getIndent(multiply);

  static double getMinHeight(BuildContext context, [BoxConstraints? constraints]) =>
      [ThemeHelper.getHeight(context), constraints?.maxHeight ?? double.infinity].reduce(min);

  static bool isKeyboardVisible(BuildContext context, [BoxConstraints? constraints]) =>
      MediaQuery.of(context).viewInsets.bottom > 0 ||
      constraints != null && ScreenHelper.state().height - 100 > constraints.maxHeight;

  static double getMaxHeight(List<dynamic> scope) {
    double height = 0;
    for (int i = 0; i < scope.length; i++) {
      double tmpHeight = 0;
      if (scope[i] is Text) {
        tmpHeight = ThemeHelper.getTextHeight(scope[i]);
      } else if (scope[i] is RenderBox) {
        tmpHeight = (scope[i] as RenderBox).getMaxIntrinsicHeight(double.infinity);
      }
      if (tmpHeight > height) {
        height = tmpHeight;
      }
    }
    return height;
  }

  static double getTextHeight(Text txt) {
    return _getPainter(txt).height;
  }

  static double getTextWidth(Text txt) {
    return _getPainter(txt).width;
  }

  static TextPainter _getPainter(Text txt) {
    final painter = TextPainter(
      text: TextSpan(text: txt.data, style: txt.style),
      textDirection: TextDirection.ltr,
      maxLines: txt.maxLines,
    );
    painter.layout();
    return painter;
  }

  static bool isTextExceedWidth(String txt, TextStyle? style, double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: txt,
        style: style,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }

  static bool isVertical(BoxConstraints constraints) => constraints.maxWidth < constraints.maxHeight;

  static bool isLower(AdaptiveWindowType size, AdaptiveWindowType windowType) => windowType <= size;

  static bool isNavBottom(BoxConstraints constraints) => getWidthCount(constraints) <= 2;

  static bool isNavRight(BuildContext context, BoxConstraints constraints) =>
      isNavBottom(constraints) && getHeightCount(context, constraints) <= 2;

  static int getWidthCount(BoxConstraints? constraints, [BuildContext? context]) {
    double width = context != null ? getWidth(context, 0, constraints) : constraints?.maxWidth ?? 0;
    final matrix = {
      AdaptiveWindowType.xlarge: width >= 1440, // AdaptiveWindowType.xlarge.widthRangeValues.start,
      AdaptiveWindowType.large: width >= 1024, // AdaptiveWindowType.large.widthRangeValues.start,
      AdaptiveWindowType.medium: width >= 640, // AdaptiveWindowType.medium.widthRangeValues.start,
      AdaptiveWindowType.small: width >= 320, // AdaptiveWindowType.small.widthRangeValues.start,
      AdaptiveWindowType.xsmall: true,
    };
    matrix.removeWhere((_, value) => value == false);
    return switch (matrix.keys.first) {
      AdaptiveWindowType.xlarge => 4,
      AdaptiveWindowType.large => 3,
      AdaptiveWindowType.medium => 2,
      _ => 1,
    };
  }

  static int getHeightCount(BuildContext context, [BoxConstraints? constraints]) {
    final height = getMinHeight(context, constraints);
    final matrix = {
      AdaptiveWindowType.xlarge: height >= 1440,
      AdaptiveWindowType.large: height >= 800,
      AdaptiveWindowType.medium: height >= 480,
      AdaptiveWindowType.small: height >= 240,
      AdaptiveWindowType.xsmall: true,
    };
    matrix.removeWhere((_, value) => value == false);
    return switch (matrix.keys.first) {
      AdaptiveWindowType.xlarge => 7,
      AdaptiveWindowType.large => 5,
      AdaptiveWindowType.medium => 4,
      AdaptiveWindowType.small => 2,
      _ => 1,
    };
  }

  static bool isWideScreen(BoxConstraints constraints) => ThemeHelper.getWidthCount(constraints) >= 4;

  static bool isWearableMode(BuildContext context, BoxConstraints constraints) =>
      isWearable = getWidthCount(constraints) * getHeightCount(context, constraints) == 1;
}
