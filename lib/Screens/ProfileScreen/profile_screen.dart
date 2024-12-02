import 'package:calliverse/Constants/textStyle.dart';
import 'package:flutter/material.dart';

import '../../Components/Profile/profile_screen_info.dart';
import '../../Components/Profile/profile_screen_settings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
            'Profile',
            style: txtStyle18AndBold,
                        ),
          ),
            ProfileInfo(),
            Expanded(child: SingleChildScrollView(child: ProfileSettingsList())),
          ],
        ),
      ),
    );
  }
}