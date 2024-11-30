import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color? textColor;
  final VoidCallback onPressed;

  const WelcomeButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    this.textColor = Colors.white,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}