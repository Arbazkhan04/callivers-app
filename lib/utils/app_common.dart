import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calliverse/Components/string_extensions.dart';
import 'package:calliverse/Components/widget_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../Constants/constants.dart';
import '../Constants/paths.dart';
import 'app_constants.dart';
import '../Constants/int_extensions.dart';
void setTheme() {
  // int themeModeIndex = getIntAsync(THEME_MODE_INDEX, defaultValue: ThemeModeSystem);
  //
  // if (themeModeIndex == ThemeModeLight) {
  //   appStore.setDarkMode(false);
  // } else if (themeModeIndex == ThemeModeDark) {
  //   appStore.setDarkMode(true);
  // }
}


Widget cachedImage(String? url, {double? height, Color? color, double? width, BoxFit? fit, AlignmentGeometry? alignment, bool usePlaceholderIfUrlEmpty = true, double? radius}) {
  if (url.validate().isEmpty) {

    return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
  } else if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url!,
      height: height,
      width: width,
      fit: fit,
      color: color,
      alignment: alignment as Alignment? ?? Alignment.center,
      progressIndicatorBuilder: (context, url, progress) {
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
      errorWidget: (_, s, d) {
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
    );
  } else {
    return Image.asset(url!, height: height, width: width, color: color, fit: BoxFit.contain, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
  }
}

Widget placeHolderWidget({double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius}) {
  return Image.asset(ic_placeholder, height: height, width: width, fit: BoxFit.cover, alignment: alignment ?? Alignment.center).cornerRadiusWithClipRRect(radius ?? defaultRadius);
}
//
// setLogInValue() {
//   print(getBoolAsync(IS_LOGIN));
//   userStore.setLogin(getBoolAsync(IS_LOGIN));
//   if (userStore.isLoggedIn) {
//     userStore.setToken(getStringAsync(TOKEN));
//     userStore.setUserID(getIntAsync(USER_ID));
//     userStore.setUserEmail(getStringAsync(EMAIL));
//     userStore.setFirstName(getStringAsync(FIRSTNAME));
//     userStore.setLastName(getStringAsync(LASTNAME));
//     userStore.setUserPassword(getStringAsync(PASSWORD));
//     userStore.setUserImage(getStringAsync(USER_PROFILE_IMG));
//     userStore.setPhoneNo(getStringAsync(PHONE_NUMBER));
//     userStore.setDisplayName(getStringAsync(DISPLAY_NAME));
//     userStore.setGender(getStringAsync(GENDER));
//     userStore.setAge(getStringAsync(AGE));
//     userStore.setHeight(getStringAsync(HEIGHT));
//     userStore.setHeightUnit(getStringAsync(HEIGHT_UNIT));
//     userStore.setWeight(getStringAsync(WEIGHT));
//     userStore.setWeightUnit(getStringAsync(WEIGHT_UNIT));
//
//     if (!getStringAsync(SUBSCRIPTION_DETAIL).isEmptyOrNull) {
//       SubscriptionDetail? subscriptionDetail = SubscriptionDetail.fromJson(jsonDecode(getStringAsync(SUBSCRIPTION_DETAIL)));
//       userStore.setSubscribe(getIntAsync(IS_SUBSCRIBE));
//       userStore.setSubscriptionDetail(subscriptionDetail);
//     }
//     String notificationData = getStringAsync(NOTIFICATION_DETAIL);
//     if (notificationData.isNotEmpty) {
//       Iterable mList = jsonDecode(getStringAsync(NOTIFICATION_DETAIL));
//       notificationStore.mRemindList = mList.map((model) => ReminderModel.fromJson(model)).toList();
//     }
//   }
// }


Duration parseDuration(String durationString) {
  List<String> components = durationString.split(':');

  int hours = int.parse(components[0]);
  int minutes = int.parse(components[1]);
  int seconds = int.parse(components[2]);

  return Duration(hours: hours, minutes: minutes, seconds: seconds);
}

progressDateStringWidget(String date) {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime dateTime = DateTime.parse(date);
  var dateValue = dateFormat.format(dateTime);
  return dateValue;
}
