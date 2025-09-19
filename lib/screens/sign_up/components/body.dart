import 'package:flutter/material.dart';
import 'package:shop_app/components/socal_card.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/translations.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text(AppTranslations.registerAccount,
                    style: headingStyle(context)),
                const Text(
                  AppTranslations.completeYourDetails,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
                Text(
                  AppTranslations.termsAndConditions,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: SizeConfig.getProportionateScreenHeight(10)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
