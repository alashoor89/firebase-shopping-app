import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/project/common/functions.dart';
import 'package:shopping_app/project/models/product_model.dart';
import 'package:shopping_app/project/providers/favorite_provider.dart';
import 'package:shopping_app/project/widgets/dismissible.dart';

class FavoriteTile extends ConsumerWidget {
  final Product product;

  const FavoriteTile({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomDismissible(
      onDismissed: (direction) {
        var favorites = ref.read(favoritesProvider.notifier);
        favorites.removeFavorite(product);
        displaySnackBar(context, "Item has been remove from favorite list");
      },
      id: product.title,
      child: ListTile(
        splashColor: Colors.blueGrey.shade50,
        onTap: () {
          navigateToProduct(context, product);
        },
        leading: SizedBox(
          height: 70,
          width: 70,
          child: Image.asset(product.image, fit: BoxFit.scaleDown),
        ),
        title: Text(
          product.title,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${product.weight}${product.weightUnit.prefix}',
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        trailing: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Text(
              '\$${product.price}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            kW(2),
            const SizedBox(
              width: 8,
              height: 14,
              child: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
