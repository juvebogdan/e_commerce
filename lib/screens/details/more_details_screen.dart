import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/UserService.dart';
import 'package:shop_app/services/locator.dart';
import 'package:shop_app/translations.dart';

class MoreDetailsScreen extends StatelessWidget {
  const MoreDetailsScreen({
    super.key,
    required this.product,
  });

  final Product product;

  String _localizedCategory(String category) {
    switch (category.trim().toLowerCase()) {
      case 'electronics':
        return AppTranslations.electronics;
      case 'wears':
      case 'fashion':
      case 'clothes':
        return AppTranslations.wears;
      case 'game':
      case 'games':
        return AppTranslations.game;
      case 'watch':
      case 'watches':
        return AppTranslations.watches;
      default:
        return category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslations.seeMoreDetail),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFFF5F6F9),
                  padding: const EdgeInsets.all(14),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoChip(
                  icon: Icons.euro,
                  text: product.price,
                ),
                _InfoChip(
                  icon: Icons.star,
                  text: product.rating.toStringAsFixed(1),
                ),
                _InfoChip(
                  icon: Icons.category_outlined,
                  text: _localizedCategory(product.category),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            DefaultButton(
              text: AppTranslations.addToCart,
              press: () async {
                try {
                  await locator<UserService>().addProductToCart(product);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppTranslations.addToCart)),
                  );
                } catch (_) {
                  // Keep UX stable even if cart sync fails.
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(text),
        ],
      ),
    );
  }
}
