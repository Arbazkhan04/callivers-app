import 'package:calliverse/Constants/textStyle.dart';
import 'package:flutter/material.dart';

class MeetingDetails extends StatelessWidget {
  const MeetingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '17 Feb 2025 at 08:00pm',
            style: txtStyle16AndMainBold,
          ),
          SizedBox(height: 6),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eget leo in elit faucibus pretium vel eget tortor. Integer feugiat sagittis quam non vehicula. Sed facilisis enim a consectetur convallis. Integer feugiat quam porta eros tempor, non sollicitudin diam fringilla. Fusce eleifend magna sed facilisis commodo.',
            style: txtStyle14AndOther,
          ),
        ],
      ),
    );
  }
}