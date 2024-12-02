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