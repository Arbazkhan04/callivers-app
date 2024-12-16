import 'dart:convert';

import 'package:calliverse/Components/common.dart';
import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Constants/DB_keys.dart';
import 'package:calliverse/Provider/image_picker_provider.dart';
import 'package:calliverse/Screens/AuthScreen/welcome_screen.dart';
import 'package:calliverse/Screens/BottomBar/bottom_bar.dart';
import 'package:calliverse/Screens/SplashScreen/splash_screen.dart';
import 'package:calliverse/Widgets/toast.dart';
import 'package:calliverse/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/AuthScreen/VerificationScreen/verification_screen.dart';
import '../Screens/AuthScreen/YourProfile/your_profile.dart';
import '../Screens/SubscriptionScreen/subscription_screen.dart';
import '../Widgets/my_print.dart';
import '../modals/login_model.dart';
import '../modals/otp_return_model_data.dart';
import '../network/rest_api.dart';


class AuthenProvider extends ChangeNotifier {

  final formKey = GlobalKey<FormState>();
  UserInfoModel? userInfoData;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController otpCodeController = TextEditingController();
  final TextEditingController phoneCountryCodeController = TextEditingController();
  final TextEditingController phoneFullNumberController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  allAuthControllerNullFun(){
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    otpCodeController.clear();
    phoneCountryCodeController.clear();
    phoneFullNumberController.clear();
    firstNameController.clear();
    lastNameController.clear();
    websiteController.clear();
    bioController.clear();
    // notifyListeners();
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
  profileSetupFun() async {
    final provider = Provider.of<ImagePickerProvider>(navigatorKey.currentState!.context,listen: false);
    showMyWaitingModal(context: navigatorKey.currentState!.context,isTextShowBool: true,loadingText: "Setup your profile...");
    // try {
      await profileSetupApi(req: {
            DBkeys.email : emailController.text,
            DBkeys.firstName : firstNameController.text,
            DBkeys.lastName : lastNameController.text,
            DBkeys.bio : bioController.text,
            DBkeys.websiteLink : websiteController.text,
          },userId: otpReturnModelData?.userId ?? responseData?.data?.userId,
          // image: provider.selectedImage!
          // image: provider.selectedImage!

      ).then((e){
            final jsonData = jsonDecode(e);
            myPrint("objectData -> ${jsonData}");
            if(jsonData["success"] == true){
              SubscriptionScreen().launch(navigatorKey.currentState!.context,isNewTask: true);
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

  LoginResponse? responseData;

  loginAccountFun() async {
    showMyWaitingModal(context: navigatorKey.currentState!.context,);
    // try {
      await loginApi(
          req: {
            DBkeys.email : emailController.text,
            DBkeys.password : passwordController.text,
          }
          ).then((e) async {
            final jsonData = jsonDecode(e);
            responseData = LoginResponse.fromJson(jsonData);
            myPrint("objectData -> ${jsonData}");
            if(jsonData["message"].toString().contains("Email not verified")){
              VerificationScreen().launch(navigatorKey.currentState!.context,isNewTask: true);
            }else if(jsonData["message"].toString().contains("Login successful") && jsonData["success"] == true && jsonData["data"]["isProfileCompleted"] == false){
              await saveUserInfoToLocalStorage(jsonData["data"]);
              SignupProfileScreen().launch(navigatorKey.currentState!.context,isNewTask: true);
            }else if(jsonData["success"] == true && jsonData["data"]["isProfileCompleted"] == true){
              await saveUserInfoToLocalStorage(jsonData["data"]);
              BottomBar().launch(navigatorKey.currentState!.context,isNewTask: true);
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

  OtpReturnModelData? otpReturnModelData;
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
              otpReturnModelData = OtpReturnModelData.fromJson(jsonData);
              SignupProfileScreen().launch(navigatorKey.currentState!.context,isNewTask: true);
            notifyListeners();
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

  logoutFun() async {
    await pref.clear();

    if(navigatorKey.currentState!.mounted){
    SplashScreen().launch(navigatorKey.currentState!.context,isNewTask: true);
    }
  }


  Future<void> saveUserInfoToLocalStorage(Map<String, dynamic> userInfo) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    await pref.setString('userInfo', jsonEncode(userInfo)); // Save user info as JSON string
    await pref.setBool('isLoggedIn', true); // Save login state
  }


  Future<void> clearUserInfo() async {
    await pref.clear(); // Clears all keys
  }

  Future<bool> isLoggedIn() async {
    return pref.getBool('isLoggedIn') ?? false;
  }

  Future<Map<String, dynamic>?> getUserInfoFromLocalStorage() async {
    String? userInfoString = pref.getString('userInfo');
    if (userInfoString != null) {
      return jsonDecode(userInfoString); // Convert JSON string back to Map
    }
    return null;
  }


  void checkLoginStatus() async {
    bool loggedIn = await isLoggedIn();
    if (loggedIn) {
      Map<String, dynamic>? userInfo = await getUserInfoFromLocalStorage();
      if (userInfo != null) {
        print("User Info: ${userInfo.toString()}"); // Access user details here
        userInfoData = UserInfoModel.fromJson(userInfo);
        if(navigatorKey.currentState!.mounted){
        BottomBar().launch(navigatorKey.currentState!.context, isNewTask: true);
        }
      } else {
        pref.clear(); // Clear corrupted data
        if(navigatorKey.currentState!.mounted){
        WelcomeScreen().launch(navigatorKey.currentState!.context, isNewTask: true);
        }
      }
    } else {
      if(navigatorKey.currentState!.mounted){
      WelcomeScreen().launch(navigatorKey.currentState!.context, isNewTask: true);
      }
    }
  }



}