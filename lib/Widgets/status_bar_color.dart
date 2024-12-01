import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
void mSetStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,// change bg clr here
        statusBarIconBrightness: Brightness.dark,// Set the desired status bar icon color for android
        statusBarBrightness: Brightness.light,
        // (Only for iOS) add the third parameter as statusBarBrightness and set it to Brightness.dark (for white text and icons) or Brightness.light (for black text and icons).
      )
  );
}