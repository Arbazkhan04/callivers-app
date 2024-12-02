import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {

  /// Light and dark theme

  bool isThemeChange = false;

  themeChangeFun({value}){
    isThemeChange = value;
    notifyListeners();
  }


  /// Notification

  bool isNotificationOn = false;

  notificationOnFun({value}){
    isNotificationOn = value;
    notifyListeners();
  }


}