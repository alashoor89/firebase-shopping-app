import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/project/common/colors.dart';
import 'package:shopping_app/project/providers/product_provider.dart';
import 'package:shopping_app/project/screens/category_screen.dart';
import 'package:shopping_app/project/screens/main_screen.dart';
import 'package:shopping_app/project/screens/placed_order.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: "Shopping App",
      debugShowCheckedModeBanner: false,
      home: ref.watch(productsProvider).when(
            data: (_) {
              return const MainScreen();
            },
            error: (error, _) {
              return Scaffold(
                body: ErrorWidget(error),
              );
            },
            loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      theme: getTheme(),
      routes: {
        "/main": (_) => const MainScreen(),
        "/category": (_) => const CategoryScreen(),
        "/placed": (_) => const PlacedOrderScreen(),
      },
    );
  }

  ThemeData getTheme() {
    ThemeData themeData = ThemeData.light();
    return themeData.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: themeData.colorScheme.copyWith(
        primary: AppColors.secondary,
      ),
      bottomNavigationBarTheme: themeData.bottomNavigationBarTheme.copyWith(
        unselectedItemColor: AppColors.primary,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primary,
      ),
    );
  }
}
