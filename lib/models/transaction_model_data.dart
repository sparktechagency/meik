import 'package:danceattix/models/user_model_data.dart';

class TransactionModelData {
  int? id;
  String? userId;
  int? orderId;
  int? productId;
  int? walletId;
  String? amount;
  String? transectionType;
  String? paymentId;
  String? paymentMethod;
  String? status;
  String? createdAt;
  String? updatedAt;
  UserModelData? user;
  Wallet? wallet;
  String? order;
  Product? product;

  TransactionModelData({
    this.id,
    this.userId,
    this.orderId,
    this.productId,
    this.walletId,
    this.amount,
    this.transectionType,
    this.paymentId,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.wallet,
    this.order,
    this.product,
  });

  TransactionModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    walletId = json['wallet_id'];
    amount = json['amount'];
    transectionType = json['transection_type'];
    paymentId = json['paymentId'];
    paymentMethod = json['paymentMethod'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new UserModelData.fromJson(json['user']) : null;
    wallet = json['wallet'] != null
        ? new Wallet.fromJson(json['wallet'])
        : null;
    order = json['order'];
    product = json['product'] != null
        ? new Product.fromJson(json['product'])
        : null;
  }
}


class Wallet {
  int? id;
  String? userId;
  dynamic? balance;
  String? currency;
  int? version;
  String? createdAt;
  String? updatedAt;

  Wallet({
    this.id,
    this.userId,
    this.balance,
    this.currency,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    balance = json['balance'];
    currency = json['currency'];
    version = json['version'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
  }
}
