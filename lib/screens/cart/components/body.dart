import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/UserService.dart';
import 'package:shop_app/services/locator.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'package:shop_app/models/Cart.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final UserService _userService = locator<UserService>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: _userService.cart.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(_userService.cart[index].id),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                _userService.removeProductFromCart(_userService.cart[index]);
              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(
              cart: Cart(
                product: _userService.cart[index],
                numOfItem: 1, // Assuming 1 for now, as prodMap is removed
              ),
            ),
          ),
        ),
      ),
    );
  }
}
