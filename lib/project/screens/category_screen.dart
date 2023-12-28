import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/project/models/product_model.dart';
import 'package:shopping_app/project/providers/product_provider.dart';
import 'package:shopping_app/project/widgets/app_bar.dart';
import 'package:shopping_app/project/widgets/product_card.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(productsProvider.notifier);
    final category = ref.read(categoryMenuProvider)!;
    final productList = provider.getCategory(category);
    return Scaffold(
      appBar: CustomAppBar(
        title: category.title,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: SingleChildScrollView(
          child: _buildGridView(productList),
        ),
      ),
    );
  }

  GridView _buildGridView(List<Product> productList) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 250,
        mainAxisSpacing: 10,
      ),
      shrinkWrap: true,
      itemBuilder: (_, index) => SizedBox(
        child: ProductCard(
          product: productList[index],
          isFirst: true,
        ),
      ),
      itemCount: productList.length,
    );
  }
}
