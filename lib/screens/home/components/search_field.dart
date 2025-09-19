import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:shop_app/translations.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.7,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: SizeConfig.getProportionateScreenWidth(20),
            vertical: SizeConfig.getProportionateScreenWidth(9),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: AppTranslations.searchProduct,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
