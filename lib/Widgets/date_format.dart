import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(int millisecondsSinceEpoch) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  String formattedDate = '${date.day.toString().padLeft(2, '0')}-${_getMonthName(date.month)}-${date.year}';
  return formattedDate;
}

String _getMonthName(int month) {
  const List<String> monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  return monthNames[month - 1];
}
// String convertUTCToLocal({required String utcTimeString}) {
//   // Parse the UTC time string
//   DateTime utcTime = DateTime.parse(utcTimeString);
//
//   // Get the local timezone
//   String localTimeZone = DateTime.now().toUtc().timeZoneName;
//
//   // Convert the UTC time to local time
//   DateTime localTime = utcTime.toUtc();
//
//   // Format the local time
//   String formattedLocalTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(localTime);
//   print("NowDateTime ${DateFormat().add_jms().format(DateTime.now().toUtc())}");
//   print("UTC to Local Time ${formattedLocalTime + ' $localTimeZone'}");
//   checkTimeDifferenceAndCalculateBeforeSpecificTime(specificTime: DateTime.parse(formattedLocalTime));
//   return formattedLocalTime + ' $localTimeZone';
// }
checkTimeDifferenceAndCalculateBeforeSpecificTime({required DateTime specificTime}) {
  // Get current time
  DateTime currentTime = DateTime.now().toUtc();

  // Calculate the difference between current time and specific time
  Duration difference = currentTime.difference(specificTime);

  // Calculate 30 seconds before the specific time
  DateTime thirtySecondsBeforeSpecificTime = specificTime.subtract(Duration(seconds: 30));

  // Output the difference
  print("Difference between current time and specified time (${DateFormat("HH:mm:ss").format(specificTime)}): ${difference.inSeconds} seconds");

  // Output the calculated time
  print("30 seconds before specified time (${DateFormat("HH:mm:ss").format(specificTime)}): ${DateFormat("yyyy-MM-dd HH:mm:ss").format(thirtySecondsBeforeSpecificTime)}");
  return difference.inSeconds;
}
// int calculateTimeDifference({required String utcTimeString}) {
//   // Parse the UTC time string
//   DateTime providedTime = DateTime.parse(utcTimeString).toUtc();
//
//   // Subtract 30 seconds from the provided time
//   DateTime modifiedTime = providedTime.subtract(Duration(seconds: 30));
//
//   // Get the current UTC time
//   DateTime currentTime = DateTime.now().toUtc();
//
//   // Calculate the difference in seconds
//   int differenceInSeconds = currentTime.difference(modifiedTime).inSeconds;
//
//   // Output the modified time
//   print("Modified Time (30 seconds removed): $modifiedTime");
//   print("differenceInSeconds Time (30 seconds removed): $differenceInSeconds");
//
//   return differenceInSeconds;
// }
int calculateTimeDifferenceInSeconds(
    {required String dateTimeString}) {
  DateTime now = DateTime.now().toUtc();
  String formattedDateTime = now.toIso8601String();

  // Parse the provided date-time string into a DateTime object
  DateTime dateTime2 = DateTime.parse(dateTimeString);

  // Calculate the difference in seconds
  int differenceInSeconds = now.difference(dateTime2).inSeconds.abs();
  int confirmTime = differenceInSeconds - 30;
  print("Current date and time in ISO 8601 format: $formattedDateTime");
  print("Provided date and time in ISO 8601 format: ${dateTime2.toIso8601String()}");
  print("Difference in seconds: $differenceInSeconds");
  print("Difference in seconds Minus 30: $confirmTime");
  return confirmTime;
}
// int calculateTimeDifference({required String utcTimeString}) {
//   // Parse the UTC time string
//   DateTime providedTime = DateTime.parse("2024-03-13T06:23:01.863589544Z");
//
//   // Subtract 30 seconds from the provided time
//   DateTime modifiedTime = providedTime.subtract(Duration(seconds: 30));
//
//   // Get the current UTC time
//   DateTime currentTime = DateTime.now().toUtc();
//
//   // Calculate the difference in seconds
//   int differenceInSeconds = currentTime.difference(modifiedTime).inSeconds;
//
//   // Output the modified time
//   print("Modified Time (30 seconds removed): $modifiedTime");
//
//   return differenceInSeconds;
// }

String convertToUserLocalTime(String dateTimeString) {
  // Parsing the DateTime string to a DateTime object
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Getting the user's current timezone offset
  Duration userTimezoneOffset = DateTime.now().timeZoneOffset;

  // Converting the DateTime to the user's local time
  DateTime localDateTime = dateTime.toUtc().add(userTimezoneOffset);

  // Formatting the DateTime for display
  String formattedDateTime = DateFormat('yyyy-MM-dd :').add_jm().format(localDateTime);

  // return formattedDateTime;
  return formattedDateTime;
}
String convertToUserLocalJustDate(String dateTimeString) {
  // Parsing the DateTime string to a DateTime object
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Getting the user's current timezone offset
  Duration userTimezoneOffset = DateTime.now().timeZoneOffset;

  // Converting the DateTime to the user's local time
  DateTime localDateTime = dateTime.toUtc().add(userTimezoneOffset);

  // Formatting the DateTime for display
  String formattedDateTime = DateFormat('yyyy-MM-dd').format(localDateTime);

  // return formattedDateTime;
  return formattedDateTime;
}

/////////////////////////////////////DateTime Difference for rate the app fun//////////////////////////
bool isDifferenceLessThanThreeDays({required int dateInMillis}) {
  print("dateInMillis -> $dateInMillis");
  // Get the current date and time
  DateTime currentDate = DateTime.now();

  // Convert the milliseconds since the epoch to DateTime
  DateTime inputDate = DateTime.fromMillisecondsSinceEpoch(dateInMillis);

  // Calculate the difference in days
  Duration difference = currentDate.difference(inputDate);
  print("daysDifference ${difference.inDays}");
  ///This value always be set in days
  // Check if the difference is less than 3 days
  return difference.inDays >= 3;
}
/////////////////////////////////////DateTime Difference for rate the app fun//////////////////////////
bool isDifferenceLessThanSevenDays({required int dateInMillis}) {
  print("dateInMillis -> $dateInMillis");
  // Get the current date and time
  DateTime currentDate = DateTime.now();

  // Convert the milliseconds since the epoch to DateTime
  DateTime inputDate = DateTime.fromMillisecondsSinceEpoch(dateInMillis);

  // Calculate the difference in days
  Duration difference = currentDate.difference(inputDate);
  print("laterDaysDifference ${difference.inDays}");
  ///This value always be set in days
  // Check if the difference is less than 3 days
  return difference.inDays >= 7;
}