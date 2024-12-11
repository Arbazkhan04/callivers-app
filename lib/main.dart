import 'package:calliverse/Provider/bottom_bar_provider.dart';
import 'package:calliverse/socket_io_test.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Constants/color.dart';
import 'Provider/authen_provider.dart';
import 'Provider/image_picker_provider.dart';
import 'Provider/profile_provider.dart';
import 'Screens/AuthScreen/welcome_screen.dart';
import 'Screens/SplashScreen/splash_screen.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomBarProvider>(
          create: (_) => BottomBarProvider(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider<AuthenProvider>(
          create: (_) => AuthenProvider(),
        ),
        ChangeNotifierProvider<ImagePickerProvider>(
          create: (_) => ImagePickerProvider(),
        ),
      ],
      child: const MyApp()));
}
final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calliverse',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.mulish().fontFamily,
        // primarySwatch: mainColor,
        primaryColor: mainColor,
        primaryColorLight: mainColor,
        primaryColorDark: mainColor,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: textColor),
          displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w600, color: textColor),
          displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: textColor),
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: textColor),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: textColor),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: textColor),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: mainColor),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: mainColor),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: mainColor),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: otherColor),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: otherColor),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: otherColor),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: mainColor),
          labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: mainColor),
          labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: mainColor),
        ),
      ),
      home: SplashScreen(),
    );
  }
}


