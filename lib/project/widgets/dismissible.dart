import 'package:flutter/material.dart';
import 'package:shopping_app/project/common/colors.dart';
import 'package:shopping_app/project/common/functions.dart';

class CustomDismissible extends StatelessWidget {
  final String id;
  final Widget child;
  final double? height;
  final EdgeInsets? padding;
  final DismissDirectionCallback? onDismissed;

  const CustomDismissible({
    super.key,
    required this.id,
    required this.child,
    this.padding,
    this.height,
    this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: onDismissed,
      key: Key(id),
      direction: DismissDirection.endToStart,
      resizeDuration: const Duration(milliseconds: 25),
      background: _dismissibleBackground(),
      child: Container(
        height: height,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.borderColor),
          ),
        ),
        child: child,
      ),
    );
  }

  Container _dismissibleBackground() {
    return Container(
      color: Colors.red,
      child:  Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.delete, color: Colors.white),
            kH(10),
            const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
