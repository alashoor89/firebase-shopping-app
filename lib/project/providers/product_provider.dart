import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopping_app/project/models/product_model.dart';

part 'product_provider.g.dart';

@riverpod
class Products extends _$Products {
  @override
  FutureOr<List<Product>> build() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response) as List<dynamic>;
    return data.map((element) => Product.fromJson(element)).toList();
  }

  List<Product> getCategory(ProductCategory category) {
    return state.value!
        .where((element) => element.categories.contains(category))
        .toList();
  }
}

final categoryMenuProvider = StateProvider<ProductCategory?>(
  (ref) => null,
);

final selectedProductProvider = StateProvider<Product?>(
  (ref) => null,
);
