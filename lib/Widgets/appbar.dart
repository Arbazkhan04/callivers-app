import 'package:calliverse/main.dart';
import 'package:flutter/material.dart';

import '../Constants/textStyle.dart';

appBar({String? title,Widget? leadIcon}){
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: leadIcon ?? IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () => Navigator.pop(navigatorKey.currentState!.context),
    ),
    title: Text(
      title ??
      '',
      style: txtStyle18AndBold,
    ),
  );
}