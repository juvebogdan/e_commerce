import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/UserService.dart';
import 'package:shop_app/services/locator.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:shop_app/translations.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  final UserService _userService = locator<UserService>();
  double _total = 0;

  @override
  void initState() {
    super.initState();
    _updateTotal();
  }

  void _updateTotal() {
    setState(() {
      _total = _userService.getCartTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.getProportionateScreenWidth(15),
        horizontal: SizeConfig.getProportionateScreenWidth(30),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: SizeConfig.getProportionateScreenWidth(40),
                  width: SizeConfig.getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Flexible(
                  child: Text(
                    AppTranslations.addVoucherCode,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: SizeConfig.getProportionateScreenHeight(20)),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Text.rich(
                    TextSpan(
                      text: "${AppTranslations.total}:\n",
                      children: [
                        TextSpan(
                          text: "\u20AC${_total.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 5,
                  child: DefaultButton(
                    text: AppTranslations.checkOut,
                    press: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
