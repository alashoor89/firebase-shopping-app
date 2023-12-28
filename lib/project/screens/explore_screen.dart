import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/project/common/colors.dart';
import 'package:shopping_app/project/common/functions.dart';
import 'package:shopping_app/project/models/product_model.dart';
import 'package:shopping_app/project/providers/product_provider.dart';
import 'package:shopping_app/project/widgets/app_bar.dart';
import 'package:shopping_app/project/widgets/product_card.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(productsProvider.notifier);
    final selectProvider = ref.read(categoryMenuProvider.notifier);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Explore Products',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSearchBar(),
              kH(20),
              _buildBanner(),
              kH(5),
              _buildSection(
                context: context,
                title: 'Exclusive Offer',
                route: '/category/offers',
                products: provider,
                controller: selectProvider,
                category: ProductCategory.exclusive,
              ),
              kH(5),
              _buildSection(
                context: context,
                title: 'Fruits',
                route: '/category/fruits',
                products: provider,
                controller: selectProvider,
                category: ProductCategory.fruits,
              ),
              kH(5),
              _buildSection(
                context: context,
                title: 'Vegetables',
                route: '/category/vegetables',
                products: provider,
                controller: selectProvider,
                category: ProductCategory.vegetables,
              ),
              kH(5),
              _buildSection(
                context: context,
                title: 'Beverages',
                route: '/category/beverages',
                products: provider,
                category: ProductCategory.beverages,
                controller: selectProvider,
                minimum: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: AppColors.bg0, borderRadius: BorderRadius.circular(15)),
      child: LayoutBuilder(builder: (_, constraints) {
        return Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_outlined),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.75,
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search Store',
                  alignLabelWithHint: true,
                ),
                onChanged: (value) {},
                readOnly: true,
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _buildBanner() {
    return SizedBox(
      width: double.infinity,
      height: 115,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/banner.jpg',
          fit: BoxFit.fill,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  _buildSection({
    required BuildContext context,
    required String title,
    required String route,
    required Products products,
    required ProductCategory category,
    required StateController<ProductCategory?> controller,
    int minimum = 4,
  }) {
    List<Product> productList = products.getCategory(category);
    return productList.isEmpty
        ? const SizedBox()
        : SizedBox(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        animationDuration: Duration(milliseconds: 0),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        controller.update((state) => category);
                        Navigator.pushNamed(context, '/category');
                      },
                      child: const Text(
                        'See all',
                      ),
                    ),
                  ],
                ),
                kH(20),
                SizedBox(
                  height: 250,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => ProductCard(
                        product: productList[index],
                        isFirst: index == 0,
                      ),
                      shrinkWrap: true,
                      itemCount: min(minimum, productList.length),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
