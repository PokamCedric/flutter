// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import your existing classes - NO REWRITES
import 'package:template_app/_classes/herald/app_design.dart';
import 'package:template_app/_classes/herald/app_locale.dart';
import 'package:template_app/_classes/herald/app_sync.dart';
import 'package:template_app/_classes/herald/app_zoom.dart';
import 'package:template_app/_classes/herald/app_theme.dart';
import 'package:template_app/_classes/herald/app_palette.dart';
import 'package:template_app/_classes/storage/app_preferences.dart';
import 'package:template_app/_configs/custom_color_scheme.dart';
import 'package:template_app/_configs/custom_text_theme.dart';
import 'package:template_app/pages/counter/counter_page.dart';
import 'package:template_app/l10n/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

    AppPreferences.pref = await SharedPreferences.getInstance();
    // CurrencyDefaults.cache = AppPreferences.pref;
    final appSync = AppSync();
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AppSync>(
            create: (_) => appSync,
          ),
        ChangeNotifierProvider<AppTheme>(
          create: (_) => AppTheme(ThemeMode.system), // Use your existing AppTheme
        ),
        ChangeNotifierProvider<AppLocale>(
          create: (_) => AppLocale(), // Use your existing AppLocale
        ),
        ChangeNotifierProvider<AppDesign>(
          create: (_) => AppDesign(), // Use your existing AppDesign
        ),
        ChangeNotifierProvider<AppZoom>(
          create: (_) => AppZoom(), // Use your existing AppZoom
        ),
        ChangeNotifierProvider<AppPalette>(
          create: (_) => AppPalette(), // Use your existing AppPalette
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  WidgetBuilder? getPage(String route, Object? arguments) {
    final args = arguments as Map<String, dynamic>?;

    Widget router(String route) => switch (route) {
      '/counter' => const CounterPage(),
      '/' => const HomePage(),
      _ => const HomePage(),
    };

    return (_) => Directionality(
      textDirection: TextDirection.ltr,
      child: router(route),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use your existing palette and theme helpers
    final palette = context.watch<AppPalette>().value;
    final text = Theme.of(context).textTheme.withCustom(palette, Brightness.light);
    final textDark = Theme.of(context).textTheme.withCustom(palette, Brightness.dark);
    final sheet = Theme.of(context).bottomSheetTheme.copyWith(
      constraints: const BoxConstraints(maxWidth: double.infinity),
    );

    return MaterialApp(
      title: 'Finance Counter App',
      debugShowCheckedModeBanner: false,

      // Use your existing localization setup
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: context.watch<AppLocale>().value,

      // Use your existing theme setup
      theme: ThemeData(
        colorScheme: const ColorScheme.light().withCustom(palette),
        floatingActionButtonTheme: const FloatingActionButtonThemeData().withCustom(palette, Brightness.light),
        brightness: Brightness.light,
        textTheme: text,
        datePickerTheme: DatePickerTheme.of(context).withCustom(palette, text, Brightness.light),
        timePickerTheme: TimePickerTheme.of(context).withCustom(palette, text, Brightness.light),
        bottomSheetTheme: sheet,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark().withCustom(palette),
        floatingActionButtonTheme: const FloatingActionButtonThemeData().withCustom(palette, Brightness.dark),
        brightness: Brightness.dark,
        textTheme: textDark,
        datePickerTheme: DatePickerTheme.of(context).withCustom(palette, textDark, Brightness.dark),
        timePickerTheme: TimePickerTheme.of(context).withCustom(palette, textDark, Brightness.dark),
        bottomSheetTheme: sheet,
        useMaterial3: true,
      ),
      themeMode: context.watch<AppTheme>().value,

      // Home route
      home: const Directionality(
        textDirection: TextDirection.ltr,
        child: HomePage(),
      ),

      // Use onGenerateRoute to maintain provider context
      onGenerateRoute: (settings) {
        final builder = getPage(settings.name ?? '/', settings.arguments);
        return MaterialPageRoute(
          builder: builder!,
          settings: settings,
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance App Home'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome to Finance App',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/counter');
              },
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Open Counter Demo'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}