import 'package:flutter/material.dart';


class BottomBarProvider extends ChangeNotifier {
  int selectedIndex = 0;
  onItemTap(int index){
    selectedIndex = index;
    notifyListeners();
  }
}