// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Cart {
  final int selectedCount;
  final int selectedColor;
  final String selectedSize;
  final String productID;

  Cart({
    required this.productID,
    required this.selectedColor,
    required this.selectedSize,
    required this.selectedCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'selectedCount': selectedCount,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
      'productID': productID,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      selectedCount: int.parse(map['selectedCount'].toString()),
      selectedColor: int.parse(map['selectedColor'].toString()),
      selectedSize: map['selectedSize'] as String,
      productID: map['productID'] as String,
    );
  }

 
}
