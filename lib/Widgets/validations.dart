import 'package:flutter/material.dart';

import '../Constants/color.dart';
import '../Constants/paths.dart';
import '../Constants/sizedbox.dart';

class AllValidation{
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Check for valid email format
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null; // No validation error
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null; // No validation error
  }

  static bool isEmailValid(String email) {
    // Regular expression pattern for email validation
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    // Check if the provided email matches the pattern
    return emailRegExp.hasMatch(email);
  }

  String? confirmPasswordValidator(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null; // No validation error
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

// Website Link Validator (Optional)
  String? websiteLinkValidator(String? value) {
    final RegExp urlRegExp = RegExp(
      r'^(https?:\/\/)?(www\.)?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}(\/\S*)?$',
      caseSensitive: false,
    );

    if (value != null && value.trim().isNotEmpty) {
      if (!urlRegExp.hasMatch(value.trim())) {
        return "Invalid website link. Example: https://example.com";
      }
    }
    return null; // Website link is optional
  }
  String? firstNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "First name is required.";
    } else if (!RegExp(r'^[a-zA-Z]{2,}$').hasMatch(value.trim())) {
      return "First name must contain only letters and be at least 2 characters.";
    }
    return null;
  }

  String? lastNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Last name is required.";
    } else if (!RegExp(r'^[a-zA-Z]{2,}$').hasMatch(value.trim())) {
      return "Last name must contain only letters and be at least 2 characters.";
    }
    return null;
  }

  String? bioValidator(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      if (value.trim().length > 150) {
        return "Bio must be under 150 characters.";
      }
    }
    return null; // Bio is optional and valid if empty
  }
  String? validatePhoneNumber(String? value) {
    // Check if the field is empty
    if (value == null || value.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }

    // Check if the input contains only numbers using RegExp
    final RegExp numberRegex = RegExp(r'^[0-9]+$');
    if (!numberRegex.hasMatch(value)) {
      return 'Please enter only numbers';
    }

    return null; // Return null if validation passes
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