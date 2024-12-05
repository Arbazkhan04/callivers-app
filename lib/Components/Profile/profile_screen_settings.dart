import 'package:calliverse/Components/Profile/profile_screen_settings_items.dart';
import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/profile_provider.dart';
import '../../Screens/ProfileScreen/edit_profile_screen.dart';

class ProfileSettingsList extends StatelessWidget {
  const ProfileSettingsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (contexts,profileProvider,_) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SettingsItem(
                icon: personIcon,
                title: 'Edit Profile',
                showArrow: true,
              ).onTap((){
                EditProfileScreen().launch(context);
              }),
              SettingsItem(
                icon: languageIcon,
                title: 'Translation Language',
                trailing: Text(
                  'Eng (US)',
                  style: txtStyle12AndOther,
                ),
                showArrow: true,
              ),
              SettingsItem(
                icon: notificationIcon,
                title: 'Notifications',
                trailing: SizedBox(
                  height: 20,
                  child: Switch(
                    value: profileProvider.isNotificationOn,
                    onChanged: (value) {
                      profileProvider.notificationOnFun(value: value);
                    },
                    activeColor: mainColor,
                  ),
                ),
              ),
              SettingsItem(
                icon: downloadIcon,
                title: 'Download Chat',
                showArrow: true,
              ),
              SettingsItem(
                icon: themeDarLightIcon,
                title: 'Dark Mode',
                trailing: SizedBox(
                  height: 20,
                  child: Switch(
                    value: profileProvider.isThemeChange,
                    onChanged: (value) {
                      profileProvider.themeChangeFun(value: value);
                    },
                    activeColor: mainColor,
                  ),
                ),
              ),
              SettingsItem(
                icon: logoutIcon,
                title: 'Logout',
                showArrow: true,
              ),
              SettingsItem(
                icon: deleteIcon,
                title: 'Delete Account',
                titleColor: const Color(0xFFFF0009),
                showArrow: true,
              ),
            ],
          ),
        );
      }
    );
  }
}