import 'dart:convert';

class Product {
  String id;
  String name;
  double price;
  String disc;
  String category;
  int count;
  List<String> imagesUrls;
  final List<String> sizes;
  final List<int> colors;
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.disc,
    required this.imagesUrls,
    required this.category,
    required this.count,
    required this.colors,
    required this.sizes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'disc': disc,
      'imagesUrls': imagesUrls,
      'category': category,
      'count': count,
      'sizes': sizes,
      'colors': colors
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      disc: map['disc'] as String,
      imagesUrls: List<String>.from(map['imagesUrls'].map((e) => e)),
      category: map['category'] as String,
      count: int.parse(map['count'].toString()),
      sizes: List<String>.from(map['sizes'].map((value) => value)),
      colors: List<int>.from(map['colors'].map((value) => value)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
