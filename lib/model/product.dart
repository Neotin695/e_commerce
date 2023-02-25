import 'dart:convert';

class Product {
  String id;
  String name;
  double price;
  String disc;
  String category;
  List<String> imagesUrls;
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.disc,
    required this.imagesUrls,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'disc': disc,
      'imagesUrls': imagesUrls,
      'category': category
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
