import 'dart:ui';

class ProductModelData {
  int? id;
  String? productName;
  String? price;
  String? description;
  String? image;
  int? rating;
  int? reviewCount;

  ProductModelData({
    this.id,
    this.productName,
    this.price,
    this.description,
    this.image,
    this.rating,
    this.reviewCount,
  });

  ProductModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    rating = json['rating'];
    reviewCount = json['reviewCount'];
  }
}







/// ======================== products add ===========================>
class ColorEntry {
  final Color color;
  final int imageIndex;
  final String hex;

  const ColorEntry({
    required this.color,
    required this.imageIndex,
    required this.hex,
  });
}
