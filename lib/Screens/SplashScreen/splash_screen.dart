import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Screens/AuthScreen/welcome_screen.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
  super.initState();
  // Perform initialization tasks here
  mInit();
}

mInit(){
  Future.delayed(Duration(seconds: 3),() => WelcomeScreen().launch(context),);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff020520),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          cachedImage(splashScreenIcon,),

        ],
      ),
    );
  }
}
