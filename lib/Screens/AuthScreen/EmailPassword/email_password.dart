import 'package:calliverse/Components/widget_extensions.dart';
import 'package:flutter/material.dart';

import '../../../Constants/color.dart';
import '../../../Constants/sizedbox.dart';
import '../../../Constants/textStyle.dart';
import '../../../Widgets/appbar.dart';
import '../../../Widgets/button.dart';
import '../../../Widgets/textfield.dart';
import '../VerificationScreen/verification_screen.dart';

class EmailPasswordScreen extends StatefulWidget {
  const EmailPasswordScreen({super.key});

  @override
  State<EmailPasswordScreen> createState() => _EmailPasswordScreenState();
}

class _EmailPasswordScreenState extends State<EmailPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            // constraints: const BoxConstraints(maxWidth: 480),
            padding: kDefaultPaddingHorizontal,
            child: Column(
              children: [
                sizeHeight10,
                Text(
                  'Sign up with email',
                  style: txtStyle22AndBold,
                ),
                const SizedBox(height: 8),
                Text(
                    'Please confirm your country code and enter your phone number',
                  textAlign: TextAlign.center,
                  style: txtStyle14AndBlack,
                ),
                const SizedBox(height: 39),
                Form(
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: 'Email',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      sizeHeight10,
                      CustomTextField(
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      sizeHeight10,
                      CustomTextField(
                        hintText: 'Confirm Password',
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                sizeHeight30,
                MyButton(text: "Continue", onPressed: (){VerificationScreen().launch(context);}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
