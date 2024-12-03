import 'package:calliverse/Components/common.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:calliverse/Widgets/copyToClipboard.dart';
import 'package:calliverse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InviteSection extends StatelessWidget {
  const InviteSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInviteField(
            label: 'Invite Link',
            value: 'example.com/abcd123',
          ),
          const SizedBox(height: 10),
          _buildInviteField(
            label: 'Invite Code',
            value: 'example.com/abcd123',
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child:
            MyButton(
              onPressed: (){pop();},
              text: 'Invite Friend',
            ),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: const Color(0xFF095DEC),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     padding: const EdgeInsets.symmetric(vertical: 12),
            //   ),
            //   child: const Text(
            //     'Invite Friend',
            //     style: TextStyle(
            //       fontFamily: 'Mulish',
            //       fontSize: 16,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildInviteField({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: txtStyle14AndBold,
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
             vertical: 4,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7FC),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFFADB5BD),
                    fontSize: 14,
                    fontFamily: 'Mulish',
                  ),
                ),
              ),
              CustomIconButton(icon: Icon(Icons.copy,color: mainColor,size: 20,), onPressed: (){
                copyToClipboard(text: value, context: navigatorKey.currentState!.context);
              })
            ],
          ),
        ),
      ],
    );
  }
}