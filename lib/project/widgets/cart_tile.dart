import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/project/common/colors.dart';
import 'package:shopping_app/project/common/functions.dart';
import 'package:shopping_app/project/models/product_model.dart';
import 'package:shopping_app/project/providers/cart_provider.dart';
import 'package:shopping_app/project/widgets/buttons/custom_rounded_button.dart';
import 'package:shopping_app/project/widgets/dismissible.dart';

class CartTile extends ConsumerWidget {
  final Product product;
  final int pieces;

  const CartTile({
    required this.product,
    required this.pieces,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(cartProvider.notifier);
    return CustomDismissible(
      onDismissed: (direction) {
        provider.removeItem(context, product);
      },
      id: product.title,
      height: 140,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          navigateToProduct(context, product);
        },
        child: Row(
          children: [
            _buildLeadingSection(),
            kW(20),
            _buildMiddleSection(provider),
            const Spacer(),
            _buildTrailingSection(context, provider),
          ],
        ),
      ),
    );
  }

  SizedBox _buildLeadingSection() {
    return SizedBox(
      height: 70,
      width: 70,
      child: Image.asset(product.image, fit: BoxFit.scaleDown),
    );
  }

  Widget _buildMiddleSection(Cart provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '${product.weight}${product.weightUnit.prefix}',
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        kH(15),
        _buildButtons(provider),
      ],
    );
  }

  Widget _buildTrailingSection(BuildContext ctx, Cart provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            provider.removeItem(ctx, product);
          },
          child: const Icon(
            Icons.close,
            color: AppColors.grey,
          ),
        ),
        Text(
          '\$${(product.price * pieces).toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(Cart provider) {
    return Row(
      children: [
        CustomRoundedButton(
          onPressed: () {
            provider.decrement(product);
          },
          icon: Icons.remove,
          backgroundColor: Colors.white,
          iconColor: AppColors.grey,
          border: const BorderSide(
            color: AppColors.borderColor,
          ),
        ),
        kW(10),
        Text(
          pieces.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        kW(10),
        CustomRoundedButton(
          onPressed: () {
            provider.increment(product);
          },
          icon: Icons.add,
          backgroundColor: Colors.white,
          iconColor: AppColors.secondary,
          border: const BorderSide(
            color: AppColors.borderColor,
          ),
        )
      ],
    );
  }
}
