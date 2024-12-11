import 'dart:async';

import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/Widgets/appbar.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:calliverse/Widgets/dialogBox.dart';
import 'package:calliverse/Widgets/toast.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../Provider/authen_provider.dart';
import '../YourProfile/your_profile.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  Timer? _timer;
  int _timeLeft = 60; // Initial timer duration
  int _resendAttempt = 0; // Track the number of resend attempts
  bool _showResendButton = false;

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start timer when the screen loads
  }

  void _startTimer() {
    setState(() {
      _showResendButton = false; // Hide resend button when timer starts
      _timeLeft = _getTimerDuration(); // Get the timer duration
    });

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--; // Decrease the timer by 1 second
        });
      } else {
        timer.cancel();
        setState(() {
          _showResendButton = true; // Show the resend button after timer ends
        });
      }
    });
  }

  int _getTimerDuration() {
    if (_resendAttempt == 0) return 60; // First attempt: 60 seconds
    if (_resendAttempt == 1) return 120; // Second attempt: 120 seconds
    if (_resendAttempt == 2) return 180; // Third attempt: 180 seconds
    return 0; // After the third attempt
  }

  void _handleResendCode() {
    final provider = Provider.of<AuthenProvider>(context,listen: false);
    if (_resendAttempt < 3) {
      // Resend the code logic
      print("Code resent successfully!");
      provider.resendCodeFun();
      setState(() {
        _resendAttempt++; // Increment resend attempt
      });
      _startTimer(); // Restart the timer
    } else {
      // After 3 attempts, show a toast message
      AppToast.show(
        "Try again after a few moments",
        );
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when leaving the screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenProvider>(
      builder: (context,authProvider,_) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: whiteColor,
          appBar: appBar(title: '',leadOnTap: (){
            return logoutDialogBox(context: context);
          }),
          body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // sizeHeight15,
                    cachedImage(
                      otherSrcLogoIcon,
                      width: 208,
                    ),
                    sizeHeight10,
                    Text(
                      'Enter Code',
                      style: txtStyle22AndBold),
                    sizeHeight15,
                    Text(
                      'We have sent you an ${authProvider.emailController.text.isNotEmpty? "Email" : authProvider.phoneFullNumberController.text.isNotEmpty? "Phone number" : "" } with the code to ${authProvider.emailController.text.isNotEmpty? authProvider.emailController.text : authProvider.phoneFullNumberController.text.isNotEmpty? "${authProvider.phoneCountryCodeController.text.isNotEmpty?authProvider.phoneCountryCodeController.text : "+1"}${authProvider.phoneFullNumberController.text}" : "" }',
                      textAlign: TextAlign.center,
                      style: txtStyle14AndOther,
                    ),
                    sizeHeight60,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: PinCodeTextField(
                        // key: authProvider.formKey,
                        appContext: context,
                        controller: authProvider.otpCodeController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),

                        length: 6,
                        // obscureText: true,
                        // obscuringCharacter: '*',
                        // obscuringWidget: const FlutterLogo(
                        //   size: 24,
                        // ),

                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        // validator: (v) {
                        //   if (v!.length < 3) {
                        //     return "I'm from validator";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        pinTheme: PinTheme(

                          shape: PinCodeFieldShape.circle,
                          // borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeColor: transparentColor,
                          inactiveColor: transparentColor,
                          inactiveFillColor: Colors.grey.shade200,
                          activeFillColor: Colors.grey.shade200,
                            selectedFillColor: Colors.grey.shade200,
                          // selectedFillColor:
                          // activeFillColor: Colors.white,
                        ),
                        cursorColor: mainColor,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,

                        // errorAnimationController: errorController,
                        // controller: textEditingController,
                        keyboardType: TextInputType.number,

                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          debugPrint(value);
                          authProvider.otpCodeController.text = value;
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                    ),
                    sizeHeight15,
                    _showResendButton?
                    TextButton(
                        onPressed: _handleResendCode,
                        child: Text("Resend Code",style: txtStyle14AndMainBold,))  : Text(
                      "Resend code in $_timeLeft seconds",
                      style: txtStyle16AndYellowBold,
                    ),
                    sizeHeight30,
                    Padding(
                      padding: kPaddingHorizontal20,
                      child: MyButton(
                          text: "Continue",
                          onPressed: (){
                            if (authProvider.otpCodeController.text.characters.length == 6) {
                              // Validation passed
                              print("Form is valid");
                              // SignupProfileScreen().launch(context);
                              authProvider.otpVerifyFun();
                            } else if(authProvider.otpCodeController.text.characters.length < 6){
                              // Validation failed
                              AppToast.show("Please enter the 6 digit verification code.");
                            }else {
                              // Validation failed
                              print("Form is invalid");
                            }
                           }),
                    )
                  ],
                ),
              )),
        );
      }
    );
  }
}
