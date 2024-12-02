import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/textfield.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 30,
      // width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: const Color(0xFFEDEDED),
            width: 1,
          ),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      // height: 30,

      child: Row(
        children: [
          Expanded(
            child: Container(
              // height: 25,
              // height: 30,

              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFC4C4C4).withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
              ),

              child: Row(
                children: [
                  sizeWidth10,
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: mainColor,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: cachedImage(

                        emojiIcon,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  sizeWidth10,
                  Expanded(child:
                  textFieldWithoutBorder(
                    hintText:
                    'Type your message...',
                    contentPadding: EdgeInsets.symmetric(vertical: 15)
                  )),
                  sizeWidth10,

                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          CircleAvatar(
            radius: 20,
            backgroundColor: mainColor,
            child: CustomIconButton(
              onPressed: (){},
              // padding: const EdgeInsets.all(8.0),
              icon: cachedImage(

                sendIcon,
                width: 30,
                height: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}