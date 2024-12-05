import 'package:calliverse/Components/common.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Widgets/appbar.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:flutter/material.dart';

import '../../Constants/sizedbox.dart';
import '../../Widgets/textfield.dart';
import '../AuthScreen/Phone/phone_screen.dart';


class CreateNewContactScreen extends StatefulWidget {
  const CreateNewContactScreen({super.key});

  @override
  State<CreateNewContactScreen> createState() => _CreateNewContactScreenState();
}

class _CreateNewContactScreenState extends State<CreateNewContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "New Contact"),
      backgroundColor: whiteColor,
      body: SafeArea(
          child: Padding(
            padding: kDefaultPaddingHorizontal,
            child: Column(
              children: [
                sizeHeight30,
                CustomTextField(
                  hintText: 'First Name (Required)',
                ),
                sizeHeight20,
                CustomTextField(
                  hintText: 'Last Name (Optional)',
                ),
                sizeHeight20,
                PhoneNumberField(),
                sizeHeight60,
                MyButton(
                    text: "Continue",
                    onPressed: (){pop();})
              ],
            ),
          )),
    );
  }
}
