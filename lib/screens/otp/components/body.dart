import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/translations.dart';

import 'otp_form.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                AppTranslations.otpVerification,
                style: headingStyle(context),
              ),
              const Text(AppTranslations.otpSentCodeTo),
              buildTimer(),
              const OtpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: const Text(
                  AppTranslations.resendOtpCode,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(AppTranslations.otpCodeExpiresIn),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: const Duration(seconds: 30),
          builder: (_, value, child) => Text(
            "00:${value != null ? (value as num).toInt() : 0}",
            style: const TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
