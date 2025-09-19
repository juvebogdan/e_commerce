import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_suffix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/components/no_account_text.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/translations.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                AppTranslations.forgotPassword,
                style: TextStyle(
                  fontSize: SizeConfig.getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppTranslations.forgotPasswordInfo,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty &&
                  errors.contains(AppTranslations.emailNullError)) {
                setState(() {
                  errors.remove(AppTranslations.emailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(AppTranslations.invalidEmailError)) {
                setState(() {
                  errors.remove(AppTranslations.invalidEmailError);
                });
              }
              return;
            },
            validator: (value) {
              if (value?.isEmpty ??
                  true && !errors.contains(AppTranslations.emailNullError)) {
                setState(() {
                  errors.add(AppTranslations.emailNullError);
                });
              } else if (!(emailValidatorRegExp.hasMatch(value ?? '')) &&
                  !errors.contains(AppTranslations.invalidEmailError)) {
                setState(() {
                  errors.add(AppTranslations.invalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: AppTranslations.email,
              hintText: AppTranslations.enterYourEmail,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: AppTranslations.continueText,
            press: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Do what you want to do
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
}
