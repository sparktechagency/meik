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
