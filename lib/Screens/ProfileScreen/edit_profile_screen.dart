import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Components/common.dart';
import '../../Constants/color.dart';
import '../../Constants/sizedbox.dart';
import '../../Widgets/appbar.dart';
import '../../Widgets/button.dart';
import '../../Widgets/textfield.dart';
import '../../utils/app_common.dart';
import '../AuthScreen/Phone/phone_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Edit Profile"),
      backgroundColor: whiteColor,
      body: SafeArea(
          child: Padding(
            padding: kDefaultPaddingHorizontal,
            child: Column(
              children: [
                sizeHeight20,
                Stack(
                  children: [
                    cachedImage("",radius: 120,width: 120),
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
                    text: "Save",
                    onPressed: (){pop();})
              ],
            ),
          )),
    );
  }
}
