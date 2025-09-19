import 'package:flutter/material.dart';
import 'package:shop_app/translations.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: AppTranslations.myAccount,
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: AppTranslations.notifications,
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: AppTranslations.settings,
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: AppTranslations.helpCenter,
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: AppTranslations.logOut,
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
