import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopping_app/project/models/product_model.dart';

part 'favorite_provider.g.dart';

@riverpod
class Favorites extends _$Favorites {
  @override
  List<Product> build() {
    return [];
  }

  void addFavorite(Product product) {
    if (state.contains(product)) return;
    state = [...state, product];
  }

  void removeFavorite(Product product) {
    if (!state.contains(product)) return;
    state = state.where((element) => element != product).toList();
  }
}
