import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/project/common/colors.dart';
import 'package:shopping_app/project/models/product_model.dart';
import 'package:shopping_app/project/providers/product_provider.dart';
import 'package:shopping_app/project/screens/product_screen.dart';

void displaySnackBar(BuildContext ctx, String message) {
  var scaffoldMessengerState = ScaffoldMessenger.of(ctx);
  scaffoldMessengerState.clearSnackBars();
  scaffoldMessengerState.showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

void navigateToProduct(BuildContext context, Product product) {
  ProviderScope.containerOf(context, listen: false)
      .read(selectedProductProvider.notifier)
      .update(
        (p0) => product,
      );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ProductScreen(),
    ),
  );
}

Padding kDiv({
  double indent = 0,
  double endIndent = 0,
  EdgeInsets insets = EdgeInsets.zero,
}) =>
    Padding(
      padding: insets,
      child: Divider(
          color: AppColors.borderColor, indent: indent, endIndent: endIndent),
    );

SizedBox kW(double width) => SizedBox(
      width: width,
    );

SizedBox kH(double height) => SizedBox(
      height: height,
    );
