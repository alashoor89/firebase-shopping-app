import 'package:flutter/material.dart';
import 'package:shopping_app/project/common/colors.dart';
import 'package:shopping_app/project/common/functions.dart';
import 'package:shopping_app/project/widgets/buttons/custom_button.dart';

class PlacedOrderScreen extends StatelessWidget {
  const PlacedOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _buildOverview(),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOverview() {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: Image.asset('assets/images/order_placed.png'),
          ),
          kH(30),
          const Text(
            'Your Order has been\naccepted',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          kH(20),
          const Text(
            'Your items has been placed and is on it’s way to being processed',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.unselectedFavoriteColor,
            ),
          ),
          kH(120),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomButton(
            onPressed: () {},
            title: 'Track Order',
          ),
          kH(10),
          CustomButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            title: 'Back to home',
            backgroundColor: Colors.white,
            textColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
