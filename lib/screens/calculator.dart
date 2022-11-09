import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:calculator/widgets/equation.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String mainEquation = '';
  String secondEquation = '';

  String removeLast(String string) {
    if (string.isNotEmpty) {
      return string.substring(0, string.length - 1);
    } else {
      return '';
    }
  }

  String getLast(String string) {
    String last;
    if (string.isNotEmpty) {
      last = string.substring(string.length - 1);
    } else {
      last = '';
    }

    return last;
  }

  bool isSymbol(String string) {
    switch (string) {
      case '+':
      case '-':
      case 'x':
      case '/':
      case '%':
        return true;
      default:
        return false;
    }
  }

  void delete(Button button) {
    setState(() {
      secondEquation = removeLast(secondEquation);
      mainEquation = '';
    });
  }

  void appendOrReplace(Button button) {
    setState(() {
      String last = getLast(secondEquation);

      switch (last) {
        case '+':
        case '-':
        case 'x':
        case '/':
        case '%':
          secondEquation =
              '${secondEquation.substring(0, secondEquation.length - 1)}${button.text}';
          break;
        default:
          secondEquation += button.text;
          mainEquation = '';
          break;
      }
    });
  }

  void append(Button button) {
    setState(() {
      var lastCharacter = getLast(secondEquation);
      var lastNumber = secondEquation.split(RegExp(r'[+\-x/]')).last;

      if (button.text == '.' &&
          (isSymbol(lastCharacter) || lastCharacter.isEmpty)) {
        secondEquation += '0.';
      } else if (button.text == '.' && lastNumber.contains('.')) {
        // do nothing
      } else if (button.text == '0' &&
          lastCharacter == '0' &&
          !lastNumber.contains('.') &&
          lastNumber.length == 1) {
        // do nothing
      } else if (lastCharacter == '0' &&
          !lastNumber.contains('.') &&
          lastNumber.length == 1 &&
          button.text != '.') {
        secondEquation = '${removeLast(secondEquation)}${button.text}';
      } else {
        secondEquation += button.text;
      }

      mainEquation = '';
    });
  }

  void clear(Button button) {
    setState(() {
      mainEquation = '';
      secondEquation = '';
    });
  }

  void calc(Button button) {
    setState(() {
      try {
        Parser p = Parser();
        var equation = secondEquation.replaceAll('x', '*');
        if (isSymbol(getLast(equation))) {
          equation = removeLast(equation);
        }
        Expression exp = p.parse(equation);
        ContextModel cm = ContextModel();
        mainEquation = '${exp.evaluate(EvaluationType.REAL, cm)}';
        if (mainEquation.endsWith('.0')) {
          mainEquation = mainEquation.substring(0, mainEquation.length - 2);
        }
      } catch (e) {
        mainEquation = '';
        debugPrint(e.toString());
      }
    });
  }

  List<Widget> _buildButtons() {
    var primaryColor = Theme.of(context).primaryColor;

    List<Button> buttons = <Button>[
      Button('AC',
          onPressed: clear, foregroundColor: Colors.grey, fontSize: 24),
      Button('DEL',
          onPressed: delete, foregroundColor: Colors.grey, fontSize: 24),
      Button('%', onPressed: appendOrReplace, foregroundColor: Colors.grey),
      Button('/', onPressed: appendOrReplace, foregroundColor: Colors.pink),
      Button('7'),
      Button('8'),
      Button('9'),
      Button('x', onPressed: appendOrReplace, foregroundColor: Colors.pink),
      Button('4'),
      Button('5'),
      Button('6'),
      Button('-', onPressed: appendOrReplace, foregroundColor: Colors.pink),
      Button('1'),
      Button('2'),
      Button('3'),
      Button('+', onPressed: appendOrReplace, foregroundColor: Colors.pink),
      Button('0',
          flex: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80))),
      Button('.'),
      Button('=',
          onPressed: calc,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white),
    ];

    return buttons.map((button) => button.withOnPressedIfNull(append)).toList();
  }

  @override
  Widget build(BuildContext context) {
    var buttons = _buildButtons();

    List<Widget> sublistButtons(int start, int end) =>
        buttons.sublist(start, end).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Equation(text: secondEquation, color: Colors.pink),
                Equation(text: mainEquation, fontSize: 72),
              ],
            ),
            Column(
              children: <Widget>[
                Row(children: sublistButtons(0, 4)),
                Row(children: sublistButtons(4, 8)),
                Row(children: sublistButtons(8, 12)),
                Row(children: sublistButtons(12, 16)),
                Row(children: <Widget>[
                  // It doesn't look right, but whatever
                  ...sublistButtons(16, 19)
                ]),
              ],
            )
          ],
        )
      )
    );
  }
}
