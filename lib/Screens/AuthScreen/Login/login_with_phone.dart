import 'package:calliverse/Components/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../Constants/sizedbox.dart';
import '../../../Constants/textStyle.dart';
import '../../../Provider/authen_provider.dart';
import '../../../Widgets/appbar.dart';
import '../../../Widgets/button.dart';
import '../../../Widgets/textfield.dart';
import '../../../Widgets/validations.dart';
import '../VerificationScreen/verification_screen.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {

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
                        'Sign up with phone number',
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
                            PhoneNumberField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (e){
                                print("es");
                                authProvider.phoneFullNumberController.text = e;
                              },

                              validator: AllValidation().validatePhoneNumber,
                              onChangeCountry: (e){
                                print("objectCountryCode -> ${e.dialCode}");
                                authProvider.phoneCountryCodeController.text = e.code!;

                              },
                            ),
                            sizeHeight10,
                          ],
                        ),
                      ),
                      sizeHeight30,
                      MyButton(text: "Continue", onPressed: (){

                        // VerificationScreen().launch(context);
                        if (authProvider.formKey.currentState!.validate()) {
                          // Validation passed
                          print("Form is valid");
                          VerificationScreen().launch(context);
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
