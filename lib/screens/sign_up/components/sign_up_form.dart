import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_suffix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/translations.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _fireStore = FirebaseFirestore.instance;
  final List<String> errors = [];

  late String email;
  late String password;
  late String confirmPassword;
  bool remember = false;

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(40)),
          DefaultButton(
            text: AppTranslations.signUp,
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  if (newUser.user != null) {
                    await _fireStore
                        .collection("user information")
                        .doc(newUser.user!.uid)
                        .set({
                      "first name": null,
                      "last name": null,
                      "address": null,
                      "phone number": null,
                    });
                    Navigator.pushNamed(
                        context, CompleteProfileScreen.routeName);
                  }
                } catch (e) {
                  print(e);
                  // Consider showing an error message to the user
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmPassword = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppTranslations.passNullError);
        } else if (value.isNotEmpty && password == confirmPassword) {
          removeError(error: AppTranslations.matchPassError);
        }
        confirmPassword = value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: AppTranslations.passNullError);
          return "";
        } else if (password != value) {
          addError(error: AppTranslations.matchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: AppTranslations.confirmPassword,
        hintText: AppTranslations.reEnterYourPassword,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppTranslations.passNullError);
        } else if (value.length >= 8) {
          removeError(error: AppTranslations.shortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: AppTranslations.passNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: AppTranslations.shortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: AppTranslations.password,
        hintText: AppTranslations.enterYourPassword,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppTranslations.emailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: AppTranslations.invalidEmailError);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(error: AppTranslations.emailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: AppTranslations.invalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: AppTranslations.email,
        hintText: AppTranslations.enterYourEmail,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
