import 'package:flutter/material.dart';

class CollectionTheme {
  ///Get collection theme
  /// primaryLight/primaryDark...
  static ThemeData getCollectionTheme({
    String theme = "greenLight",
    String font = "Raleway",
  }) {
    ColorScheme colorScheme;
    switch (theme) {
      case "primaryLight":
        colorScheme = const ColorScheme.light(
          primary: Color(0xffe5634d),
          secondary: Color(0xff4a91a4),
          surface: Color(0xfff2f2f2),
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
        );
        break;
      case "primaryDark":
        colorScheme = const ColorScheme.dark(
          primary: Color(0xffe5634d),
          secondary: Color(0xff4a91a4),
          surface: Color(0xff121212),
          background: Color(0xff010101),
          error: Colors.red,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.black,
        );
        break;
      case "greenLight":
        colorScheme = const ColorScheme.light(
          primary: Color.fromARGB(255, 112, 177, 27),
          secondary: Color(0xff82B541),
          surface: Color(0xfff2f2f2),
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
        );
        break;
      case "greenDark":
        colorScheme = const ColorScheme.dark(
          primary: Color.fromARGB(255, 112, 177, 27),
          secondary: Color(0xff82B541),
          surface: Color(0xff121212),
          background: Color(0xff010101),
          error: Colors.red,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.black,
        );
        break;
      case "orangeLight":
        colorScheme = const ColorScheme.light(
          primary: Color(0xfff4a261),
          secondary: Color(0xff2A9D8F),
          surface: Color(0xfff2f2f2),
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
        );
        break;
      case "orangeDark":
        colorScheme = const ColorScheme.dark(
          primary: Color(0xfff4a261),
          secondary: Color(0xff2A9D8F),
          surface: Color(0xff121212),
          background: Color(0xff010101),
          error: Colors.red,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.black,
        );
        break;
      default:
        colorScheme = const ColorScheme.light(
          primary: Color(0xffe5634d),
          secondary: Color(0xff4a91a4),
          surface: Color(0xfff2f2f2),
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
        );
        break;
    }

    final dark = colorScheme.brightness == Brightness.dark;
    final primaryColor = dark ? colorScheme.surface : colorScheme.primary;
    final indicatorColor = dark ? colorScheme.onSurface : colorScheme.onPrimary;

    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: colorScheme.brightness,
      primaryColor: colorScheme.primary,
      appBarTheme: AppBarTheme(color: primaryColor),
      canvasColor: colorScheme.background,
      indicatorColor: indicatorColor,
      colorScheme: colorScheme,

      ///Custom
      fontFamily: font,
      dialogTheme: DialogTheme(backgroundColor: colorScheme.surface),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 8,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 12.0), // Set default font size
        bodyMedium: TextStyle(fontSize: 12.0), // Set default font size
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        showUnselectedLabels: true,
      ),
    );
  }

  ///Singleton factory
  static final CollectionTheme _instance = CollectionTheme._internal();

  factory CollectionTheme() {
    return _instance;
  }

  CollectionTheme._internal();
}

