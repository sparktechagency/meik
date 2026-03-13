import 'package:danceattix/services/api_urls.dart';

class UserModelData {
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

  UserModelData({
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
    this.phone,
    this.roles,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

   String get fullName => "${firstName ?? ''} ${lastName ?? ''}";
   String get profileImage => "${ApiUrls.imageBaseUrl}${image ?? ""}";

  UserModelData.fromJson(Map<String, dynamic> json) {
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
    roles = json['roles'] != null ? List<String>.from(json['roles']) : [];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }
}
