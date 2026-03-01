import 'package:flutter/material.dart';
import 'package:shop_app/translations.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppTranslations.completeProfileTitle),
        ),
        body: const Body(),
      ),
    );
  }
}
