class CheckoutModelData {
  Product? product;
  double? price;
  double? protectionFee;
  double? total;
  bool? isOfferPrice;

  CheckoutModelData({
    this.product,
    this.price,
    this.protectionFee,
    this.total,
    this.isOfferPrice,
  });

  CheckoutModelData.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null
        ? Product.fromJson(json['product'])
        : null;

    price = _toDouble(json['price']);
    protectionFee = _toDouble(json['protectionFee']);
    total = _toDouble(json['total']);

    isOfferPrice = json['isOfferPrice'];
  }

  /// 🔥 Helper function
  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}

class Product {
  int? id;
  String? userId;
  String? productName;
  String? status;
  int? subCategoryId;
  String? price;
  String? description;
  String? condition;
  String? brand;
  bool? isNegotiable;
  bool? isBoosted;
  String? boostStartTime;
  String? boostEndTime;
  int? weight;
  int? length;
  String? carrerOption;
  int? width;
  int? height;
  String? createdAt;
  String? updatedAt;
  String? syntheticScore;
  User? user;
  List<Images>? images;
  List<Variants>? variants;
  String? collectionAddress;

  Product({
    this.id,
    this.userId,
    this.productName,
    this.status,
    this.subCategoryId,
    this.price,
    this.description,
    this.condition,
    this.brand,
    this.isNegotiable,
    this.isBoosted,
    this.boostStartTime,
    this.boostEndTime,
    this.weight,
    this.length,
    this.carrerOption,
    this.width,
    this.height,
    this.createdAt,
    this.updatedAt,
    this.syntheticScore,
    this.user,
    this.images,
    this.variants,
    this.collectionAddress,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productName = json['product_name'];
    status = json['status'];
    subCategoryId = json['subCategoryId'];
    price = json['price'];
    description = json['description'];
    condition = json['condition'];
    brand = json['brand'];
    isNegotiable = json['is_negotiable'];
    isBoosted = json['is_boosted'];
    boostStartTime = json['boost_start_time'];
    boostEndTime = json['boost_end_time'];
    weight = json['weight'];
    length = json['length'];
    carrerOption = json['carrer_option'];
    width = json['width'];
    height = json['height'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    syntheticScore = json['synthetic_score'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    collectionAddress = json['collectionAddress'];
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? status;
  int? rating;
  String? address;
  String? currency;
  String? fcm;
  List<String>? roles;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.status,
    this.rating,
    this.address,
    this.currency,
    this.fcm,
    this.roles,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    image = json['image'];
    status = json['status'];
    rating = json['rating'];
    address = json['address'];
    currency = json['currency'];
    fcm = json['fcm'];
    roles = json['roles'].cast<String>();
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }
}

class Images {
  int? id;
  int? productId;
  String? image;
  String? timestampSecond;

  Images({this.id, this.productId, this.image, this.timestampSecond});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    image = json['image'];
    timestampSecond = json['TimestampSecond'];
  }
}

class Variants {
  int? id;
  int? productId;
  int? colorId;
  int? sizeId;
  int? unit;
  String? sku;
  String? priceModifier;
  String? createdAt;
  String? updatedAt;
  Color? color;
  Size? size;

  Variants(
      {this.id,
        this.productId,
        this.colorId,
        this.sizeId,
        this.unit,
        this.sku,
        this.priceModifier,
        this.createdAt,
        this.updatedAt,
        this.color,
        this.size});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    colorId = json['colorId'];
    sizeId = json['sizeId'];
    unit = json['unit'];
    sku = json['sku'];
    priceModifier = json['price_modifier'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    color = json['color'] != null ? new Color.fromJson(json['color']) : null;
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
  }

}


class CheckoutPreviewModel {
  String? sessionId;
  double? basePrice;
  double? subtotal;
  double? protectionFee;
  double? discount;
  double? tax;
  double? finalPrice;

  CheckoutPreviewModel({
    this.sessionId,
    this.basePrice,
    this.subtotal,
    this.protectionFee,
    this.discount,
    this.tax,
    this.finalPrice,
  });

  CheckoutPreviewModel.fromJson(Map<String, dynamic> json) {
    sessionId = json['sessionId'];

    basePrice = (json['breakdown']['basePrice'] ?? 0).toDouble();
    subtotal = (json['breakdown']['subtotal'] ?? 0).toDouble();
    protectionFee = (json['breakdown']['protectionFee'] ?? 0).toDouble();
    discount = (json['breakdown']['discount'] ?? 0).toDouble();
    tax = (json['breakdown']['tax'] ?? 0).toDouble();

    finalPrice = (json['finalPrice'] ?? 0).toDouble();
  }
}






class Color {
  int? id;
  String? name;
  String? image;

  Color({this.id, this.name, this.image});

  Color.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Size {
  int? id;
  String? type;
  String? name;

  Size({this.id, this.type, this.name});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    return data;
  }
}


