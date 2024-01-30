import 'package:flutter/material.dart';

class CustomOrderButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;

  const CustomOrderButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: textColor,
        minimumSize: const Size(300, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Text(buttonText),
    );
  }
}
