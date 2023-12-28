import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/project/common/colors.dart';
import 'package:shopping_app/project/common/functions.dart';
import 'package:shopping_app/project/providers/cart_provider.dart';
import 'package:shopping_app/project/widgets/buttons/custom_button.dart';
import 'package:styled_text/styled_text.dart';

class CheckoutModal extends ConsumerWidget {
  const CheckoutModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double cost = ref
        .read(cartProvider)
        .entries
        .map((e) => e.key.price * e.value)
        .reduce((value, element) => value + element);
    return Container(
      height: 550,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          kDiv(),
          _createSection('Delivery', _createText('Select Method')),
          kDiv(),
          _createSection('Payment', _createText('Cash')),
          kDiv(),
          _createSection('Promo Code', _createText('Pick Discount')),
          kDiv(),
          _createSection(
              'Total Cost', _createText('\$${cost.toStringAsFixed(2)}')),
          kDiv(insets: const EdgeInsets.only(bottom: 10)),
          _buildAgreement(),
          kH(15),
          CustomButton(
              onPressed: () {
                ref.read(cartProvider.notifier).clear();
                Navigator.popAndPushNamed(context, '/placed');
              },
              title: 'Place Order')
        ],
      ),
    );
  }

  Widget _buildAgreement() {
    return StyledText(
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.unselectedFavoriteColor,
      ),
      text:
          'By placing an order you agree to our\n<bold>Terms</bold> And <bold>Conditions</bold>',
      tags: {
        'bold': StyledTextTag(
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Checkout',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
        )
      ],
    );
  }

  Widget _createSection(String label, Widget widget) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.unselectedFavoriteColor,
        ),
      ),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          widget,
          kW(4),
          const Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }

  _createText(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
