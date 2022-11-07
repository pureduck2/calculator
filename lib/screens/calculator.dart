import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:calculator/widgets/result.dart';
import 'package:calculator/widgets/history.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  final List<String> buttons = const <String>[
    'AC',
    '+/-',
    '%',
    '/',

    '7',
    '8',
    '9',
    'x',

    '4',
    '5',
    '6',
    '-',

    '1',
    '2',
    '3',
    '+',

    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const History(),
            const Result(),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              children: const [
                Button(text: '1'),
                Button(text: '2'),
                Button(text: '3'),
                Button(text: '4')
              ],
            )
          ],
        ),
      )
    );
  }
}