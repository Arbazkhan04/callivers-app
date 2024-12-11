import 'package:calliverse/Constants/color.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Constants/textStyle.dart';

textFieldWithoutBorder({hintText,EdgeInsets? contentPadding,TextEditingController? controller}){
  return TextField(
    style: txtStyle14AndBlack,
    controller: controller,
    cursorColor: mainColor,
    decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        contentPadding:contentPadding ?? EdgeInsets.zero,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: hintText,
        hintStyle: txtStyle14AndOther
    ),
  );
}

// class CustomTextField extends StatelessWidget {
//   final String hintText;
//   final bool obscureText;
//   final TextInputType? keyboardType;
//
//   const CustomTextField({
//     Key? key,
//     required this.hintText,
//     this.obscureText = false,
//     this.keyboardType,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       style: txtStyle14AndBlack,
//       cursorColor: mainColor,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: txtStyle14AndOther,
//         filled: true,
//         fillColor: const Color(0xFFF7F7FC),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(4),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 8,
//           vertical: 11,
//         ),
//       ),
//     );
//   }
// }

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator; // Optional validation
  final ValueChanged<String>? onChanged; // Optional onChanged callback

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.suffixIcon,
    this.validator, // Nullable validation
    this.onChanged, // Nullable onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: txtStyle14AndBlack,
      cursorColor: mainColor,
      controller: controller,
      validator: validator, // Use provided validator, or null if not set
      onChanged: onChanged, // Use provided onChanged, or null if not set
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: txtStyle14AndOther,
        filled: true,
        fillColor: const Color(0xFFF7F7FC),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 11,
        ),
      ),
    );
  }
}


class PhoneNumberField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator; // Optional validation

  final Function(String)? onChanged;
  final Function(CountryCode countryCode)? onChangeCountry;
  final List<TextInputFormatter>? inputFormatters;
  PhoneNumberField({this.controller,this.inputFormatters, this.onChanged, this.onChangeCountry, this.validator});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF8F9FD), // Background color
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              // Country Code Picker
              SizedBox(
                width: 120,
                child: CountryCodePicker(
                  padding: EdgeInsets.zero,
                  onChanged: onChangeCountry ?? (countryCode) {
                    print(countryCode.dialCode); // Get the selected country code
                  },
                  initialSelection: 'US',
                  // favorite: ['+1', 'US'],
                  showFlag: true,
                  showDropDownButton: false,

                  textStyle: txtStyle14AndBlack,
                ),
              ),
              // Expanded Phone Number Input Field
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ),
        Row(
          children: [
            // Country Code Picker
            SizedBox(
              width: 120,
              // child: ,
            ),
            // Expanded Phone Number Input Field
            Expanded(
              child: TextFormField(
                inputFormatters: inputFormatters,
                controller: controller, // Allow user to provide controller
                cursorColor: mainColor,
                style: txtStyle14AndBlack,
                validator: validator, // Use provided validator, or null if not set
                keyboardType: TextInputType.phone,
                onChanged: onChanged, // Allow user to add onChanged callback
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Phone Number',
                  hintStyle: txtStyle14AndOther,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
