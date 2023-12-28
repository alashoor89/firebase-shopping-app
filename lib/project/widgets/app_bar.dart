import 'package:flutter/material.dart';
import 'package:shopping_app/project/common/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool border;
  final bool cartIcon;
  final Color background;

  const CustomAppBar({
    this.title,
    this.border = false,
    this.cartIcon = true,
    this.background = AppColors.background,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: background,
      surfaceTintColor: Colors.transparent,
      shape: border
          ? const Border(bottom: BorderSide(color: AppColors.borderColor))
          : null,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: cartIcon
              ? IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {},
                )
              : null,
        )
      ],
      title: title == null
          ? null
          : Text(
              title!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
