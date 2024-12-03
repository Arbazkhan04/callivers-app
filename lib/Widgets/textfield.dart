import 'package:calliverse/Constants/color.dart';
import 'package:flutter/material.dart';

import '../Constants/textStyle.dart';

textFieldWithoutBorder({hintText,EdgeInsets? contentPadding,TextEditingController? controller}){
  return TextField(
    style: txtStyle14AndBlack,
    controller: controller,
    cursorColor: mainColor,
    decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        contentPadding:contentPadding ?? EdgeInsets.zero,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: hintText,
        hintStyle: txtStyle14AndOther
    ),
  );
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: txtStyle14AndBlack,
      cursorColor: mainColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: txtStyle14AndOther,
        filled: true,
        fillColor: const Color(0xFFF7F7FC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 11,
        ),
      ),
    );
  }
}