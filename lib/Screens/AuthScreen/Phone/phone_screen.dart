import 'package:calliverse/Components/common.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/Widgets/appbar.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Components/PhoneAuth/country_selector.dart';
import '../../../Widgets/textfield.dart';

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({Key? key}) : super(key: key);

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
                  child: Column(
                    children: [
                      PhoneNumberField(),
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
                MyButton(text: "Continue", onPressed: (){pop();}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Widget _buildDropdownItem(Country country) => Container(
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      SizedBox(
        width: 8.0,
      ),
      Text("+${country.phoneCode}(${country.isoCode})"),
    ],
  ),
);
class PhoneNumberField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FD), // Background color
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          // Country Code Picker
          SizedBox(
            child: CountryCodePicker(
              onChanged: (countryCode) {
                print(countryCode.dialCode); // Get the selected country code
              },
              // padding: EdgeInsets.zero,
              // margin: EdgeInsets.zero,

              initialSelection: 'US',
              favorite: ['+1', 'US'],
              showFlag: true,
              showDropDownButton: false,
              textStyle: txtStyle14AndBlack,
            ),
          ),
          // Divider between flag and text field
          // SizedBox(width: 8.0),
          Expanded(
            // Phone Number Input Field
            child: TextField(
              cursorColor: mainColor,
              style: txtStyle14AndBlack,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Phone Number',
                hintStyle: txtStyle14AndOther,
              ),
            ),
          ),
        ],
      ),
    );
  }
}