import 'package:calculator/screens/history.dart';
import 'package:flutter/material.dart';
import 'screens/calculator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
