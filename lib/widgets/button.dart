import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(this.text,
      {super.key,
      this.flex = 1,
      this.shape = const CircleBorder(),
      this.onPressed,
      this.foregroundColor,
      this.backgroundColor = Colors.black12,
      this.fontSize = 32});

  final String text;
  final int flex;
  final OutlinedBorder shape;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double? fontSize;
  void Function(Button)? onPressed;

  Button withOnPressedIfNull(void Function(Button)? onPressed) {
    this.onPressed = this.onPressed ?? onPressed;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: TextButton(
        onPressed: () {
          onPressed?.call(this);
        },
        style: TextButton.styleFrom(
            shape: shape,
            minimumSize: const Size.fromHeight(84),
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}
