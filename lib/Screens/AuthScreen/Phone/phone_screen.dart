import 'package:calliverse/Components/common.dart';
import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/Provider/authen_provider.dart';
import 'package:calliverse/Widgets/appbar.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../Components/PhoneAuth/country_selector.dart';
import '../../../Widgets/textfield.dart';
import '../../../Widgets/validations.dart';
import '../VerificationScreen/verification_screen.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {

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
                          CustomTextField(
                            hintText: 'Password',
                            obscureText: true,
                            controller: authProvider.passwordController,
                            onChanged: (e){
                              authProvider.passwordController.text = e;
                            },
                            validator: AllValidation().passwordValidator,

                          ),
                          sizeHeight10,
                          CustomTextField(
                            hintText: 'Confirm Password',
                            obscureText: true,
                            onChanged: (e){
                              authProvider.confirmPasswordController.text = e;
                            },
                            controller: authProvider.confirmPasswordController,
                            validator:(value) => AllValidation().confirmPasswordValidator(value,authProvider.passwordController.text),

                          ),
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


