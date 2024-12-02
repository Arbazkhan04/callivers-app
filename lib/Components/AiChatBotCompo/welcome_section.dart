import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 53),
        cachedImage(
          aiMainIcon,
          width: 191,
          height: 187,
        ),
        const SizedBox(height: 9),
        Text(
          'Welcome to Juliabot',
          style: txtStyle22AndBold,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: kPaddingHorizontal20,
          child: Text(
            "Ask me anything what's are on your mind. Am here to assist you!",
            textAlign: TextAlign.center,
            style: txtStyle14AndOther,
          ),
        ),
      ],
    );
  }
}