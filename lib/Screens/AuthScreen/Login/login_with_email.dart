import 'package:calliverse/Components/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constants/sizedbox.dart';
import '../../../Constants/textStyle.dart';
import '../../../Provider/authen_provider.dart';
import '../../../Widgets/appbar.dart';
import '../../../Widgets/button.dart';
import '../../../Widgets/textfield.dart';
import '../../../Widgets/validations.dart';
import 'login_with_phone.dart';

class LoginWithEmailPassword extends StatefulWidget {
  const LoginWithEmailPassword({super.key});

  @override
  State<LoginWithEmailPassword> createState() => _LoginWithEmailPasswordState();
}

class _LoginWithEmailPasswordState extends State<LoginWithEmailPassword> {

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
                        'Sign in with email',
                        style: txtStyle22AndBold,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please confirm your email address and enter your password.',
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
                          ],
                        ),
                      ),
                      sizeHeight30,
                      MyButton(text: "Continue", onPressed: (){
                        if (authProvider.formKey.currentState!.validate()) {
                          // Validation passed
                          print("Form is valid");
                          authProvider.loginAccountFun();
                        } else {
                          // Validation failed
                          print("Form is invalid");
                        }
                      }),
                      sizeHeight30,
                      TextButton(onPressed: (){LoginWithPhone().launch(context);}, child: Text("Signin with phone",style: txtStyle16AndMainBold,)),
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
