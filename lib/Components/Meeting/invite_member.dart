import 'package:calliverse/Components/common.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'invite_member_field.dart';

class InviteMembersScreen extends StatelessWidget {
  const InviteMembersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Invite Members',
            style: txtStyle18AndBold,
          ),
          const SizedBox(height: 20),
          const InviteField(
            label: 'Invite Link',
            value: 'example.com/abcd123',
          ),
          const SizedBox(height: 10),
          const InviteField(
            label: 'Invite Code',
            value: 'example.com/abcd123',
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: MyButton(
              onPressed: () {pop();},
                text: 'Invite Friend',
            ),
          ),
        ],
      ),
    );
  }
}


