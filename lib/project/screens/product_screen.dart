import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/project/common/colors.dart';
import 'package:shopping_app/project/common/functions.dart';
import 'package:shopping_app/project/models/product_model.dart';
import 'package:shopping_app/project/providers/cart_provider.dart';
import 'package:shopping_app/project/providers/product_provider.dart';
import 'package:shopping_app/project/widgets/app_bar.dart';
import 'package:shopping_app/project/widgets/buttons/custom_button.dart';
import 'package:shopping_app/project/widgets/buttons/custom_rounded_button.dart';
import 'package:shopping_app/project/widgets/buttons/favorite_button.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  final TextEditingController controller = TextEditingController(text: '1');

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = ref.watch(selectedProductProvider)!;

    return Scaffold(
      appBar: const CustomAppBar(
        cartIcon: false,
        background: AppColors.bg0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _buildProductInformation(product),
            _addBasketButton(product, context),
          ],
        ),
      ),
    );
  }

  Container _addBasketButton(Product product, BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(15),
      child: CustomButton(
        onPressed: () {
          ref.read(cartProvider.notifier).increment(
                product,
                int.tryParse(
                      controller.text,
                    ) ??
                    1,
              );
          controller.text = '1';
          displaySnackBar(context, "Item has been added to your cart");
        },
        title: 'Add To Basket',
      ),
    );
  }

  Widget _buildProductInformation(Product product) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(product),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(product),
                kH(10),
                _buildPriceSection(product.price),
                kDiv(insets: const EdgeInsets.symmetric(vertical: 10)),
                _buildProductDetail(product.detail),
                kDiv(insets: const EdgeInsets.symmetric(vertical: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(Product product) {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: const BoxDecoration(
        color: AppColors.bg0,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.3,
            child: Image.asset(
              product.image,
            ),
          ),
          kH(30)
        ],
      ),
    );
  }

  Widget _buildHeader(Product product) {
    return ListTile(
      contentPadding: const EdgeInsets.only(right: 0.0),
      title: Text(
        product.title,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${product.weight}${product.weightUnit.prefix}',
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      trailing: FavoriteButton(
        product: product,
      ),
    );
  }

  Widget _buildPriceSection(double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomRoundedButton(
              onPressed: () => add(-1),
              icon: Icons.remove,
              backgroundColor: Colors.white,
              iconColor: AppColors.grey,
            ),
            kW(10),
            _buildTextField(),
            kW(10),
            CustomRoundedButton(
              onPressed: () => add(1),
              icon: Icons.add,
              backgroundColor: Colors.white,
              iconColor: AppColors.secondary,
            ),
          ],
        ),
        Text(
          '\$${(price).toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return SizedBox(
      width: 45,
      height: 45,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
        maxLines: 1,
        onSubmitted: (_) => add(),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }

  Widget _buildProductDetail(String detail) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Detail',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        kH(10),
        Text(
          detail,
          style: const TextStyle(
            color: AppColors.unselectedFavoriteColor,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        kH(50),
      ],
    );
  }

  void add([int a = 0]) {
    var quantity = int.tryParse(controller.text) ?? 1;
    quantity += a;
    controller.text = max(quantity, 1).toString();
  }
}
