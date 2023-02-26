// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:e_commerce/model/product.dart';

class ClothesProduct extends Product {
  final List<String> sizes;
  final List<int> colors;

  ClothesProduct({
    required super.id,
    required super.name,
    required super.price,
    required super.disc,
    required super.imagesUrls,
    required super.category,
    required this.sizes,
    required this.colors,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sizes': sizes,
      'colors': colors,
    };
  }

  factory ClothesProduct.fromMap(Map<String, dynamic> map) {
    return ClothesProduct(
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      disc: map['disc'] as String,
      imagesUrls: List<String>.from(map['imagesUrls'].map((value) => value)),
      category: map['category'] as String,
      sizes: List<String>.from(map['sizes'].map((value) => value)),
      colors: List<int>.from(map['colors'].map((value) => value)),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ClothesProduct.fromJson(String source) =>
      ClothesProduct.fromMap(json.decode(source) as Map<String, dynamic>);
}
