import 'package:calliverse/Constants/color.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String? text;
  final Widget? childWidget;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onPressed;

  const MyButton({
    Key? key,
    this.text,
    this.backgroundColor,
    this.childWidget,
    this.textColor = Colors.white,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor ?? mainColor,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: childWidget ?? Text(
          text ?? "",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  CustomFloatingActionButton({Key? key, required this.onTap, required this.icon, this.bgColor}) : super(key: key);
  final VoidCallback onTap;
  final Widget icon;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(300)
      ),
      backgroundColor: bgColor?? mainColor,
      onPressed: onTap,
      child: icon,
    );
  }
}


class CustomIconButton extends StatelessWidget {
  final Widget icon;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onPressed;
  const CustomIconButton({super.key, required this.icon, this.backgroundColor, this.textColor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: icon);
  }
}

