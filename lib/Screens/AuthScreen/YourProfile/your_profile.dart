import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Widgets/appbar.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:calliverse/Widgets/textfield.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../SubscriptionScreen/subscription_screen.dart';

class SignupProfileScreen extends StatefulWidget {
  const SignupProfileScreen({Key? key}) : super(key: key);

  @override
  State<SignupProfileScreen> createState() => _SignupProfileScreenState();
}

class _SignupProfileScreenState extends State<SignupProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: 'Your Profile'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // ProfileHeader(),
                // SizedBox(height: 46),
                sizeHeight20,
                Stack(
                  children: [
                    cachedImage("",radius: 140,width: 140),
                    Positioned(
                      right: 6,
                      bottom: 15,
                      child: CircleAvatar(
                        radius: 13,
                        backgroundColor: textColor,
                        child: Icon(CupertinoIcons.add,size: 18,color: whiteColor,),
                      ),
                    )
                  ],
                ),
                sizeHeight40,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(hintText: "First Name",keyboardType: TextInputType.name,),
                      sizeHeight10,
                      CustomTextField(hintText: "Last Name",keyboardType: TextInputType.name,),
                      sizeHeight10,
                      CustomTextField(hintText: "Bio (Optional)",keyboardType: TextInputType.name,),
                      sizeHeight10,
                      CustomTextField(hintText: "Website Link (Optional)",keyboardType: TextInputType.name,),

                      const SizedBox(height: 66),
                      SizedBox(
                        width: double.infinity,
                        child: MyButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Handle form submission
                              SubscriptionScreen().launch(context);
                            }
                          },
                          text: 'Save',

                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}