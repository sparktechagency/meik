
class ProductModelData {
  int? id;
  String? userId;
  String? productName;
  String? status;
  int? subCategoryId;
  int? price;
  int? unit;
  String? description;
  String? condition;
  int? sizeId;
  int? colorId;
  String? brand;
  bool? isNegotiable;
  bool? isBoosted;
  String? boostStartTime;
  String? boostEndTime;
  String? weight;
  String? length;
  String? carrerOption;
  String? width;
  String? height;
  String? createdAt;
  String? updatedAt;
  List<Images>? images;
  User? user;
  String? collectionAddress;
  double? buyerProtection;
  String? currency;

  ProductModelData(
      {this.id,
        this.userId,
        this.productName,
        this.status,
        this.subCategoryId,
        this.price,
        this.unit,
        this.description,
        this.condition,
        this.sizeId,
        this.colorId,
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
        this.images,
        this.user,
        this.collectionAddress,
        this.buyerProtection,
        this.currency});

  ProductModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productName = json['product_name'];
    status = json['status'];
    subCategoryId = json['subCategoryId'];
    price = json['price'];
    unit = json['unit'];
    description = json['description'];
    condition = json['condition'];
    sizeId = json['sizeId'];
    colorId = json['colorId'];
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
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    collectionAddress = json['collectionAddress'];
    buyerProtection = json['buyer_protection'];
    currency = json['currency'];
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
  String? phone;
  List<String>? roles;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.image,
        this.status,
        this.rating,
        this.address,
        this.currency,
        this.fcm,
        this.phone,
        this.roles,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

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
    phone = json['phone'];
    roles = json['roles'].cast<String>();
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }
}
