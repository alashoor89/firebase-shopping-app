class Product {
  final String title;
  final String detail;
  final double price;
  final int weight;
  final WeightUnit weightUnit;
  final List<ProductCategory> categories;
  final String image;

  Product({
    required this.title,
    required this.detail,
    required this.price,
    required this.weight,
    required this.weightUnit,
    required this.categories,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        title: json['title'],
        detail: json["detail"],
        price: json['price'],
        weight: json['weight'],
        weightUnit: WeightUnit.fromPrefix(
              json['weight_unit'],
            ) ??
            WeightUnit.kilos,
        categories: (json['categories'] as List<dynamic>)
            .map(
              (e) => ProductCategory.fromName(e)!,
            )
            .toList(),
        image: json['image']);
  }
}

enum WeightUnit {
  kilos(prefix: 'kg'),
  liters(prefix: 'L'),
  millilitre(prefix: 'ml'),
  ;

  final String prefix;

  const WeightUnit({required this.prefix});

  static WeightUnit? fromPrefix(String prefix) {
    return WeightUnit.values
        .where((element) => prefix == element.prefix)
        .firstOrNull;
  }
}

enum ProductCategory {
  exclusive(title: "Exclusives"),
  fruits(title: 'Fruits'),
  vegetables(title: 'Vegetables'),
  bakery(title: 'Bakeries'),
  beverages(title: 'Beverages');

  final String title;

  const ProductCategory({required this.title});

  static ProductCategory? fromName(String name) {
    return ProductCategory.values
        .where((element) =>
            element.toString().replaceAll("ProductCategory.", "") == name)
        .firstOrNull;
  }
}
