import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/Widgets/appbar.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../YourProfile/your_profile.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: appBar(title: ''),
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
                  'We have sent you an Email with the code to example@gmail.com',
                  textAlign: TextAlign.center,
                  style: txtStyle14AndOther,
                ),
                sizeHeight60,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: PinCodeTextField(
                    appContext: context,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
            
                    length: 4,
                    // obscureText: true,
                    // obscuringCharacter: '*',
                    // obscuringWidget: const FlutterLogo(
                    //   size: 24,
                    // ),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 3) {
                        return "I'm from validator";
                      } else {
                        return null;
                      }
                    },
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
                      setState(() {
                        // currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ),
                TextButton(
                    onPressed: (){},
                    child: Text("Resend Code",style: txtStyle14AndMainBold,)),
                sizeHeight30,
                Padding(
                  padding: kPaddingHorizontal20,
                  child: MyButton(
                      text: "Continue",
                      onPressed: (){SignupProfileScreen().launch(context);}),
                )
              ],
            ),
          )),
    );
  }
}
