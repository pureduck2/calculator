import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(this.text,
      {super.key,
      this.flex = 1,
      this.shape = const CircleBorder(),
      this.onPressed});

  final String text;
  final int flex;
  final OutlinedBorder shape;
  void Function(Button)? onPressed;

  Button withOnPressedIfNull(void Function(Button)? onPressed) {
    this.onPressed = this.onPressed ?? onPressed;
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: ElevatedButton(
        onPressed: () {
          onPressed?.call(this);
        },
        style: ElevatedButton.styleFrom(
          shape: shape,
          backgroundColor: Colors.red,
          minimumSize: const Size.fromHeight(84),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
