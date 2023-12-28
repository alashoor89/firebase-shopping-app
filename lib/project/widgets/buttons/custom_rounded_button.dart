import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final BorderSide? border;
  final Color backgroundColor;
  final Color iconColor;

  const CustomRoundedButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 45,
      child: IconButton(
        style: IconButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            side: border ?? BorderSide.none,
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
