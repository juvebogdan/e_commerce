import 'package:flutter/material.dart';
import 'package:shop_app/translations.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslations.signUp),
      ),
      body: Body(),
    );
  }
}
