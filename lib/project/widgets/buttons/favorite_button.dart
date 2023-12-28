import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/project/common/colors.dart';
import 'package:shopping_app/project/common/functions.dart';
import 'package:shopping_app/project/models/product_model.dart';
import 'package:shopping_app/project/providers/favorite_provider.dart';

class FavoriteButton extends ConsumerWidget {
  final Product product;

  const FavoriteButton({required this.product, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoritesProvider).contains(product);
    return IconButton(
      onPressed: () {
        var favorites = ref.read(favoritesProvider.notifier);
        if (isFavorite) {
          favorites.removeFavorite(product);
          displaySnackBar(context, "Item has been remove from favorite list");
        } else {
          favorites.addFavorite(product);
          displaySnackBar(context, "Item has been added to favorite list");
        }
      },
      icon: Transform.scale(
        scale: 1.2,
        child: Icon(
          color: isFavorite ? AppColors.selectedFavoriteColor : AppColors.unselectedFavoriteColor,
          isFavorite ? Icons.favorite : Icons.favorite_border,
        ),
      ),
    );
  }
}
