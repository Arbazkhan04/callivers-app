import 'package:flutter/material.dart';

import '../Constants/color.dart';
import '../Constants/paths.dart';
import '../Constants/sizedbox.dart';

class AllValidation{
  static bool isEmailValid(String email) {
    // Regular expression pattern for email validation
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    // Check if the provided email matches the pattern
    return emailRegExp.hasMatch(email);
  }
  static bool isLoginEmailValid(String email) {
    // Regular expression pattern for email validation
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    // Check if the provided email matches the pattern
    return !emailRegExp.hasMatch(email);
  }

  static bool isPasswordValid(String? password) {
    if (password == null || password.isEmpty) {
      return false; // Password is empty
    }else if(password.length < 6){
      return false;
    }else{
      return true;
    }
  }
  static bool isLoginPasswordValid(String? password) {
    if (password == null || password.isEmpty) {
      return true; // Password is empty
    }else if(password.length < 6){
      return true;
    }else{
      return false;
    }
  }
}

String capitalizeWords(String input) {
  // Split the input by underscores to handle cases like "apple_one"
  List<String> words = input.split('_');

  // Capitalize the first character of each word
  List<String> capitalizedWords = words.map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).toList();

  // Join the words back together with underscores
  return capitalizedWords.join('_');
}