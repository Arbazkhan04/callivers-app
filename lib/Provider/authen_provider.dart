import 'dart:convert';

import 'package:calliverse/Components/common.dart';
import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Constants/DB_keys.dart';
import 'package:calliverse/Screens/SplashScreen/splash_screen.dart';
import 'package:calliverse/Widgets/toast.dart';
import 'package:calliverse/main.dart';
import 'package:flutter/material.dart';

import '../Screens/AuthScreen/VerificationScreen/verification_screen.dart';
import '../Widgets/my_print.dart';
import '../network/rest_api.dart';


class AuthenProvider extends ChangeNotifier {

  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController otpCodeController = TextEditingController();
  final TextEditingController phoneCountryCodeController = TextEditingController();
  final TextEditingController phoneFullNumberController = TextEditingController();

  allAuthControllerNullFun(){
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    otpCodeController.clear();
    phoneCountryCodeController.clear();
    phoneFullNumberController.clear();
    notifyListeners();
  }

  bool isPasswordShowBool = false;

  isPassShowFun(){
    isPasswordShowBool = !isPasswordShowBool;
    notifyListeners();
  }
  createAccountFun() async {
    showMyWaitingModal(context: navigatorKey.currentState!.context,isTextShowBool: true,loadingText: "Creating your Shining account...");
    // try {
      await registerApi(req: {
            DBkeys.email : emailController.text,
            DBkeys.password : confirmPasswordController.text,
            DBkeys.userName : "Umer Ferrari",
            DBkeys.phone : "+923111111111",
          }).then((e){
            final jsonData = jsonDecode(e);
            myPrint("objectData -> ${jsonData}");
            if(jsonData["success"] == true){
              VerificationScreen().launch(navigatorKey.currentState!.context,isNewTask: true);
            }else{
              pop();
              AppToast.show(jsonData["message"]);
            }
          });
    // } catch (e) {
    //   pop();
    //   print(e);
    // }
    notifyListeners();
  }

  loginAccountFun() async {
    showMyWaitingModal(context: navigatorKey.currentState!.context,);
    // try {
      await loginApi(req: {
            DBkeys.email : emailController.text,
            DBkeys.password : passwordController.text,
          }).then((e){
            final jsonData = jsonDecode(e);
            myPrint("objectData -> ${jsonData}");
            if(jsonData["message"].toString().contains("Email not verified")){
              VerificationScreen().launch(navigatorKey.currentState!.context,isNewTask: true);
            }else{
              pop();
              AppToast.show(jsonData["message"]);
            }
          });
    // } catch (e) {
    //   pop();
    //   print(e);
    // }
    notifyListeners();
  }

  otpVerifyFun() async {
    showMyWaitingModal(context: navigatorKey.currentState!.context,);
    try {
      await otpVerifiedApi(req: {
            DBkeys.email : emailController.text,
            DBkeys.code : otpCodeController.text,
          }).then((e){
            final jsonData = jsonDecode(e);
            myPrint("objectData -> ${jsonData}");
            if(jsonData["message"].toString().contains("Email verified successfully")){
              VerificationScreen().launch(navigatorKey.currentState!.context,isNewTask: true);
            }if(jsonData["message"].toString().contains("Email not verified")){
              VerificationScreen().launch(navigatorKey.currentState!.context,isNewTask: true);
            }else{
              pop();
              AppToast.show(jsonData["message"]);
            }
          });
    } catch (e) {
      pop();
      print(e);
    }
    notifyListeners();
  }

  resendCodeFun() async {
    showMyWaitingModal(context: navigatorKey.currentState!.context,);
    try {
      await resendOtpApi(req: {
            DBkeys.email : emailController.text,
          }).then((e){
            final jsonData = jsonDecode(e);
            myPrint("objectData -> ${jsonData}");
            if(jsonData["message"].toString().contains("Email verified successfully")){
              VerificationScreen().launch(navigatorKey.currentState!.context,isNewTask: true);
            }if(jsonData["message"].toString().contains("Email not verified")){
              VerificationScreen().launch(navigatorKey.currentState!.context,isNewTask: true);
            }else{
              pop();
              AppToast.show(jsonData["message"]);
            }
          });
    } catch (e) {
      pop();
      print(e);
    }
    notifyListeners();
  }

  logoutFun(){
    SplashScreen().launch(navigatorKey.currentState!.context,isNewTask: true);
  }

}