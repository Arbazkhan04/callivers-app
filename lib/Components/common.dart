import 'dart:math';
import 'package:calliverse/Components/context_extensions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import '../Constants/constants.dart';
import '../Constants/constants.dart';
import '../main.dart';
import '../utils/app_colors.dart';

/// Make any variable nullable
T? makeNullable<T>(T? value) => value;

/// Enum for page route
enum PageRouteAnimation { Fade, Scale, Rotate, Slide, SlideBottomTop }

/// has match return bool for pattern matching
bool hasMatch(String? s, String p) {
  return (s == null) ? false : RegExp(p).hasMatch(s);
}


/// Hide soft keyboard
void hideKeyboard(context) => FocusScope.of(context).requestFocus(FocusNode());

/// Returns a string from Clipboard
Future<String> paste() async {
  ClipboardData? data = await Clipboard.getData('text/plain');
  return data?.text?.toString() ?? "";
}

/// Returns a string from Clipboard
Future<dynamic> pasteObject() async {
  ClipboardData? data = await Clipboard.getData('text/plain');
  return data;
}

const double degrees2Radians = pi / 180.0;

double radians(double degrees) => degrees * degrees2Radians;

void afterBuildCreated(Function()? onCreated) {
  makeNullable(SchedulerBinding.instance)!
      .addPostFrameCallback((_) => onCreated?.call());
}


Route<T> buildPageRoute<T>(
  Widget child,
  PageRouteAnimation? pageRouteAnimation,
  Duration? duration,
) {
  if (pageRouteAnimation != null) {
    if (pageRouteAnimation == PageRouteAnimation.Fade) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return FadeTransition(opacity: anim, child: child);
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.Rotate) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return RotationTransition(
              child: child, turns: ReverseAnimation(anim));
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.Scale) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return ScaleTransition(child: child, scale: anim);
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.Slide) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return SlideTransition(
            child: child,
            position: Tween(
              begin: Offset(1.0, 0.0),
              end: Offset(0.0, 0.0),
            ).animate(anim),
          );
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    } else if (pageRouteAnimation == PageRouteAnimation.SlideBottomTop) {
      return PageRouteBuilder(
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return SlideTransition(
            child: child,
            position: Tween(
              begin: Offset(0.0, 1.0),
              end: Offset(0.0, 0.0),
            ).animate(anim),
          );
        },
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
      );
    }
  }
  return MaterialPageRoute<T>(builder: (_) => child);
}

EdgeInsets dynamicAppButtonPadding(BuildContext context) {
  if (context.isDesktop()) {
    return EdgeInsets.symmetric(vertical: 20, horizontal: 20);
  } else if (context.isTablet()) {
    return EdgeInsets.symmetric(vertical: 16, horizontal: 16);
  } else {
    return EdgeInsets.symmetric(vertical: 16, horizontal: 16);
  }
}

enum BottomSheetDialog { Dialog, BottomSheet }


/// mailto: function to open native email app
Uri mailTo({
  required List<String> to,
  String subject = '',
  String body = '',
  List<String> cc = const [],
  List<String> bcc = const [],
}) {
  String _subject = '';
  if (subject.isNotEmpty) _subject = '&subject=$subject';

  String _body = '';
  if (body.isNotEmpty) _body = '&body=$body';

  String _cc = '';
  if (cc.isNotEmpty) _cc = '&cc=${cc.join(',')}';

  String _bcc = '';
  if (bcc.isNotEmpty) _bcc = '&bcc=${bcc.join(',')}';

  return Uri(
    scheme: 'mailto',
    query: 'to=${to.join(',')}$_subject$_body$_cc$_bcc',
  );
}


/// returns true if network is available
Future<bool> isNetworkAvailable() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}
get getContext => navigatorKey.currentState?.overlay?.context;

Future<T?> push<T>(
    Widget widget, {
      bool isNewTask = false,
      PageRouteAnimation? pageRouteAnimation,
      Duration? duration,
    }) async {
  if (isNewTask) {
    return await Navigator.of(getContext).pushAndRemoveUntil(
      buildPageRoute(widget, pageRouteAnimation, duration),
          (route) => false,
    );
  } else {
    return await Navigator.of(getContext).push(
      buildPageRoute(widget, pageRouteAnimation, duration),
    );
  }
}

/// Dispose current screen or close current dialog
void pop([Object? object]) {
  if (Navigator.canPop(getContext)) Navigator.pop(getContext, object);
}