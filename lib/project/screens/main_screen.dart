import 'package:flutter/material.dart';
import 'package:shopping_app/project/screens/cart_screen.dart';
import 'package:shopping_app/project/screens/explore_screen.dart';
import 'package:shopping_app/project/screens/favorite_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _screens = const [
    ExploreScreen(),
    FavoriteScreen(),
    CartScreen(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined), label: 'Explore'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border), label: 'Favorite'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
      ],
      onTap: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
      currentIndex: _currentIndex,
    );
  }
}
