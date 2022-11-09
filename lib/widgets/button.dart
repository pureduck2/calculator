import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(this.text,
      {super.key,
      this.flex = 1,
      this.shape = const CircleBorder(),
      this.onPressed,
      this.foregroundColor,
      this.backgroundColor,
      this.fontSize = 28});

  final String text;
  final int flex;
  final OutlinedBorder shape;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double? fontSize;
  void Function(BuildContext, Button)? onPressed;

  Button withOnPressedIfNull(void Function(BuildContext, Button)? onPressed) {
    this.onPressed = this.onPressed ?? onPressed;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: OutlinedButton(
          onPressed: () {
            onPressed?.call(context, this);
          },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(84),
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.background,
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
