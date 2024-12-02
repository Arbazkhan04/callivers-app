import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 112,
          height: 112,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.45),
                blurRadius: 24,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(67),
            child: cachedImage(
              demoNewMessagePersonImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 21),
        Text(
          'Danny Hopkins',
          style: txtStyle16AndBold,
        ),
        const SizedBox(height: 7),
        Text(
          '+1234567890',
          style: txtStyle14AndBlack,
        ),
        const SizedBox(height: 14),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Experienced designer, shaping intuitive interfaces and seamless user journeys',
            textAlign: TextAlign.center,
            style: txtStyle14AndOther,
          ),
        ),
      ],
    );
  }
}