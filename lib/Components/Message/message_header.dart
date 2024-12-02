import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:flutter/material.dart';

import '../../Widgets/textfield.dart';

class MessageHeader extends StatelessWidget {
  const MessageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 24, 23),
      decoration: const BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: const [
              Text(
                'Messages',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Mulish',
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 11),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7FC),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Color(0xFFADB5BD)),
                SizedBox(width: 8),
                Expanded(
                  child: textFieldWithoutBorder(
                    hintText: "Search",

                  ),
                ),
                // Text(
                //   'Search',
                //   style: TextStyle(
                //     color: Color(0xFFADB5BD),
                //     fontSize: 14,
                //     fontWeight: FontWeight.w600,
                //     fontFamily: 'Mulish',
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}