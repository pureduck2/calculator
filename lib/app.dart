import 'package:calculator/screens/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/calculator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('pl', '')
      ],
      title: 'Calculator',
      theme: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light()
              .copyWith(primary: Colors.indigo)
              .copyWith(background: Colors.white)
              .copyWith(secondary: Colors.pink)),
      darkTheme: ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark()),
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/': (context) => const Calculator(),
        '/history': (context) => const History(),
      },
    );
  }
}
