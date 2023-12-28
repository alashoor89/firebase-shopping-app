import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/project/common/colors.dart';
import 'package:shopping_app/project/common/functions.dart';
import 'package:shopping_app/project/models/product_model.dart';
import 'package:shopping_app/project/providers/cart_provider.dart';
import 'package:shopping_app/project/widgets/buttons/favorite_button.dart';
import 'package:shopping_app/project/widgets/buttons/custom_rounded_button.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFirst;

  const ProductCard({
    required this.product,
    this.isFirst = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        navigateToProduct(context, product);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: isFirst ? 0.0 : 8.0,
          right: 8.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.borderColor),
        ),
        width: 170,
        height: 250,
        child: Stack(
          children: [
            _buildFavoriteButton(),
            _buildCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              product.image,
            ),
          ),
          const Spacer(),
          Text(
            product.title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              
            ),
          ),
          Text(
            '${product.weight}${product.weightUnit.prefix}',
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              
            ),
          ),
          kH(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildAddCartButton()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddCartButton() {
    return Consumer(builder: (ctx, ref, __) {
      ref.watch(cartProvider);
      return CustomRoundedButton(
        onPressed: () {
          ref.read(cartProvider.notifier).addItem(ctx, product);
        },
        icon: ref.read(cartProvider.notifier).hasItem(product)
            ? Icons.plus_one
            : Icons.add,
        backgroundColor: AppColors.secondary,
        iconColor: Colors.white,
      );
    });
  }

  Widget _buildFavoriteButton() {
    return Align(
      alignment: Alignment.topRight,
      child: FavoriteButton(
        product: product,
      ),
    );
  }
}
