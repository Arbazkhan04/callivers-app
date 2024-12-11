import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Widgets/all_field_controllers.dart';
import 'package:calliverse/Widgets/validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constants/color.dart';
import '../../../Constants/sizedbox.dart';
import '../../../Constants/textStyle.dart';
import '../../../Provider/authen_provider.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e){
      Provider.of<AuthenProvider>(context,listen: false).allAuthControllerNullFun();
    });
  }


  @override
  Widget build(BuildContext context) {

    return Consumer<AuthenProvider>(
      builder: (context,authProvider,_) {
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
                      key: authProvider.formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            hintText: 'Email',
                            obscureText: false,
                            controller: authProvider.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: AllValidation().emailValidator,
                          ),
                          sizeHeight10,
                          CustomTextField(
                            hintText: 'Password',
                            obscureText: authProvider.isPasswordShowBool,
                            controller: authProvider.passwordController,
                            onChanged: (e){
                              authProvider.passwordController.text = e;
                            },
                            validator: AllValidation().passwordValidator,
                            suffixIcon: IconButton(
                              onPressed: (){
                                authProvider.isPassShowFun();
                              },
                              icon: Icon(Icons.remove_red_eye_outlined ),
                            ),
                          ),
                          sizeHeight10,
                          CustomTextField(
                            hintText: 'Confirm Password',
                            obscureText: authProvider.isPasswordShowBool,
                            onChanged: (e){
                              authProvider.confirmPasswordController.text = e;
                            },
                            controller: authProvider.confirmPasswordController,
                            validator:(value) => AllValidation().confirmPasswordValidator(value,authProvider.passwordController.text),
                            suffixIcon: IconButton(
                              onPressed: (){
                                authProvider.isPassShowFun();

                              },
                              icon: Icon(Icons.remove_red_eye_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                    sizeHeight30,
                    MyButton(text: "Continue", onPressed: (){
                      if (authProvider.formKey.currentState!.validate()) {
                        // Validation passed
                        print("Form is valid");
                        authProvider.createAccountFun();
                      } else {
                        // Validation failed
                        print("Form is invalid");
                      }
                      }),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
