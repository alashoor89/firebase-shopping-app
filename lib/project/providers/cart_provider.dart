import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopping_app/project/common/functions.dart';
import 'package:shopping_app/project/models/product_model.dart';

part 'cart_provider.g.dart';

@riverpod
class Cart extends _$Cart {
  @override
  Map<Product, int> build() {
    return {};
  }

  void addItem(BuildContext ctx, Product product) {
    displaySnackBar(ctx, "Item has been added to your cart");
    increment(product);
  }

  void removeItem(BuildContext ctx, Product product) {
    if (!state.containsKey(product)) return;
    state.remove(product);
    state = Map.of(state);
    displaySnackBar(ctx, "Item has been removed from your cart");
  }

  void increment(Product product, [int addition = 1]) {
    state.update(product, (value) => value + addition,
        ifAbsent: () => addition);
    state = Map.of(state);
  }

  void decrement(Product product) {
    state.update(product, (value) => value <= 1 ? 1 : value - 1,
        ifAbsent: () => 1);
    state = Map.of(state);
  }

  bool hasItem(Product product) {
    return state.containsKey(product);
  }

  void clear() {
    state = {};
  }
}
