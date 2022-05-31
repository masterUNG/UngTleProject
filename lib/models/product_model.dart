import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String id;
  final String category;
  final String nameFood;
  final String price;
  final String detail;
  final String image;
  ProductModel({
    required this.id,
    required this.category,
    required this.nameFood,
    required this.price,
    required this.detail,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'nameFood': nameFood,
      'price': price,
      'detail': detail,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: (map['id'] ?? '') as String,
      category: (map['category'] ?? '') as String,
      nameFood: (map['nameFood'] ?? '') as String,
      price: (map['price'] ?? '') as String,
      detail: (map['detail'] ?? '') as String,
      image: (map['image'] ?? '') as String,
    );
  }

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
