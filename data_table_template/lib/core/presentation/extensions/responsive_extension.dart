import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension XResponsiveBuildContext on BuildContext {
  bool get isDisplayLargerThanTablet =>
      ResponsiveBreakpoints.of(this).largerThan(TABLET);
  bool get isDisplayLargerThanSmallDesktop =>
      ResponsiveBreakpoints.of(this).largerThan('SMALL_DESKTOP');
  bool get isDisplaySmallerThanTablet =>
      ResponsiveBreakpoints.of(this).smallerOrEqualTo(TABLET);
}

extension XResponsiveFontSize on BuildContext {
  double get titleScaleFactor => isDisplayLargerThanTablet ? 1 : 0.8;
}

extension XMediaQuery on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
}


extension XResponsiveFilterWidth on BuildContext {
  double get filterWidth => isDisplaySmallerThanTablet ? screenWidth - 20.0 :  isDisplayLargerThanSmallDesktop ? 250.0 : 800.0;
}
