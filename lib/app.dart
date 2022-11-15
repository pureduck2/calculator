import 'package:calculator/screens/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/calculator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale? locale;

  void setLocale(Locale value) {
    setState(() {
      locale = value;
    });
  }

  void toggleLocale() {
    if (locale?.languageCode == 'pl') {
      setLocale(const Locale('en', ''));
    } else if (locale?.languageCode == 'en') {
      setLocale(const Locale('pl', ''));
    }
  }

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
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        locale = deviceLocale;
      },
      locale: locale,
      title: 'Calculator',
      theme: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light()
              .copyWith(primary: Colors.indigo)
              .copyWith(background: Colors.white)
              .copyWith(secondary: Colors.pink)),
      darkTheme: ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark()),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const Calculator(),
        '/history': (context) => const History(),
      },
    );
  }
}
