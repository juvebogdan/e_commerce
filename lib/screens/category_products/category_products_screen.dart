import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/services/products_list.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/translations.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const CategoryProductsScreen(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: FutureBuilder<List<Product>>(
        future: ListOfProducts().getProductsByCategory(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('${AppTranslations.error}: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(AppTranslations.noProductsFound));
          } else {
            return GridView.builder(
              padding:
                  EdgeInsets.all(SizeConfig.getProportionateScreenWidth(20)),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: SizeConfig.getProportionateScreenWidth(20),
                crossAxisSpacing: SizeConfig.getProportionateScreenWidth(20),
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) =>
                  ProductCard(product: snapshot.data![index]),
            );
          }
        },
      ),
    );
  }
}
