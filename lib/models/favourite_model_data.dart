class FavouriteModelData {
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
  List<Images>? images;
  List<Variants>? variants;
  User? user;
  String? collectionAddress;

  FavouriteModelData({
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
    this.images,
    this.variants,
    this.user,
    this.collectionAddress,
  });

  FavouriteModelData.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    collectionAddress = json['collectionAddress'];
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
  String? createdAt;
  String? updatedAt;

  Variants({
    this.id,
    this.productId,
    this.colorId,
    this.sizeId,
    this.unit,
    this.sku,
    this.createdAt,
    this.updatedAt,
  });

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    colorId = json['colorId'];
    sizeId = json['sizeId'];
    unit = json['unit'];
    sku = json['sku'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
