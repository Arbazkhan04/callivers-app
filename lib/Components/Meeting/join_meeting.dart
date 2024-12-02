import 'package:calliverse/Constants/textStyle.dart';
import 'package:flutter/material.dart';

class JoinMeetingWidget extends StatelessWidget {
  const JoinMeetingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: txtStyle14AndBlack,
              decoration: InputDecoration(
                hintText: 'Enter a code or link',
                hintStyle: txtStyle14AndOther,
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 11,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {},
            child: Text(
              'Join',
              style: txtStyle16AndMainBold,
            ),
          ),
        ],
      ),
    );
  }
}