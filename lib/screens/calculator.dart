import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:calculator/widgets/equation.dart';

enum ActionType { value, add, substract, multiply, divide, modulo }

class Action {
  const Action(this.type, {this.value});

  final ActionType type;
  final double? value;
}

class Calculator extends StatefulWidget {
  Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<Action> actions = [];

  String mainEquation = '1470';
  String secondEquation = '78 x 5 + 540 x 2';

  void append(Button button) {
    setState(() {
      mainEquation += button.text;
    });
  }

  void clear(Button button) {
    setState(() {
      mainEquation = '';
      secondEquation = '';
      actions = [];
    });
  }

  void changeSymbol(Button button) {
    setState(() {
      if (mainEquation[0] == '-') {
        mainEquation = mainEquation.substring(1);
      } else {
        mainEquation = '-$mainEquation';
      }
    });
  }

  void addAction(ActionType type, {double? value}) {
    setState(() {
      actions.add(Action(type, value: value));
      mainEquation = '';
    });
  }

  void calc(Button button) {
    addAction(ActionType.value, value: double.tryParse(mainEquation) ?? 0);
    setState(() {
      double result = actions.take(1).first.value ?? 0;

      // for (var action in actions.sublist(1)) {
      for (int i = 1; i < actions.length; i++) {
        var action = actions[i];
        debugPrint('${action.type} ${action.value}');
        switch (action.type) {
          case ActionType.value:
            continue;
          case ActionType.add:
            result += actions[i+1].value ?? 0;
            break;
          case ActionType.substract:
            result -= actions[i+1].value ?? 0;
            break;
          case ActionType.multiply:
            result *= actions[i+1].value ?? 0;
            break;
          case ActionType.divide:
            result /= actions[i+1].value ?? 0;
            break;
          case ActionType.modulo:
            result %= actions[i+1].value ?? 0;
            break;
        }
      }

      mainEquation = '$result';
    });
  }

  void add(Button button) {
    addAction(ActionType.value, value: double.tryParse(mainEquation) ?? 0);
    addAction(ActionType.add);
  }

  void substract(Button button) {
    addAction(ActionType.value, value: double.tryParse(mainEquation) ?? 0);
    addAction(ActionType.substract);
  }

  void multiply(Button button) {
    addAction(ActionType.value, value: double.tryParse(mainEquation) ?? 0);
    addAction(ActionType.multiply);
  }

  void divide(Button button) {
    addAction(ActionType.value, value: double.tryParse(mainEquation) ?? 0);
    addAction(ActionType.divide);
  }

  void modulo(Button button) {
    addAction(ActionType.value, value: double.tryParse(mainEquation) ?? 0);
    addAction(ActionType.modulo);
  }

  List<Widget> _buildButtons() {
    List<Button> buttons = <Button>[
      Button('AC', onPressed: clear),
      Button('+/-', onPressed: changeSymbol),
      Button('%', onPressed: modulo),
      Button('/', onPressed: divide),
      Button('7'),
      Button('8'),
      Button('9'),
      Button('x', onPressed: multiply),
      Button('4'),
      Button('5'),
      Button('6'),
      Button('-', onPressed: substract),
      Button('1'),
      Button('2'),
      Button('3'),
      Button('+', onPressed: add),
      Button('0',
          flex: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80))),
      Button('.'),
      Button('=', onPressed: calc),
    ];

    return buttons.map((button) => button.withOnPressedIfNull(append)).toList();
  }

  @override
  Widget build(BuildContext context) {
    var buttons = _buildButtons();

    List<Widget> sublistButtons(int start, int end) =>
        buttons.sublist(start, end).toList();

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Equation(text: secondEquation),
          Equation(text: mainEquation, fontSize: 72),
          Column(
            children: <Widget>[
              Row(children: sublistButtons(0, 4)),
              const SizedBox(height: 10),
              Row(children: sublistButtons(4, 8)),
              const SizedBox(height: 10),
              Row(children: sublistButtons(8, 12)),
              const SizedBox(height: 10),
              Row(children: sublistButtons(12, 16)),
              const SizedBox(height: 10),
              Row(children: <Widget>[
                const SizedBox(width: 7),
                // It doesn't look right, but whatever
                ...sublistButtons(16, 19)
              ]),
            ],
          ),
        ],
      ),
    ));
  }
}
