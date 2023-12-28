import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/project/models/product_model.dart';
import 'package:shopping_app/project/providers/favorite_provider.dart';
import 'package:shopping_app/project/widgets/app_bar.dart';
import 'package:shopping_app/project/widgets/favorite_tile.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Favorites',
        border: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child:
            products.isNotEmpty ? _buildListView(products) : _buildEmptyView(),
      ),
    );
  }

  Widget _buildEmptyView() {
    return const Center(
      child: Text('There is no favorite products', style: TextStyle(fontSize: 16),),
    );
  }

  Widget _buildListView(List<Product> products) {
    return ListView.builder(
      itemBuilder: (_, index) => FavoriteTile(
        product: products[index],
      ),
      shrinkWrap: true,
      itemCount: products.length,
    );
  }
}
