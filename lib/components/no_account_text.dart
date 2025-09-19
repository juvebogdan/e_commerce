import 'package:flutter/material.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';
import 'package:shop_app/translations.dart';

import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppTranslations.dontHaveAccount,
          style:
              TextStyle(fontSize: SizeConfig.getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            AppTranslations.signUp,
            style: TextStyle(
              fontSize: SizeConfig.getProportionateScreenWidth(16),
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
