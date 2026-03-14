class InboxModelData {
  Receiver? receiver;
  Conversation? conversation;
  List<Messages>? messages;

  InboxModelData({this.receiver, this.conversation, this.messages});

  InboxModelData.fromJson(Map<String, dynamic> json) {
    receiver = json['receiver'] != null
        ? new Receiver.fromJson(json['receiver'])
        : null;
    conversation = json['conversation'] != null
        ? new Conversation.fromJson(json['conversation'])
        : null;
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }
}

class Receiver {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  bool? isActive;

  Receiver({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.isActive,
  });


  String get receiverFullName => '$firstName $lastName';


  Receiver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    image = json['image'];
    isActive = json['isActive'];
  }
}

class Conversation {
  int? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Conversation({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  Conversation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'] != null
        ? new Product.fromJson(json['product'])
        : null;
  }
}

class Product {
  int? id;
  String? productName;
  List<Images>? images;
  List<Variants>? variants;
  User? user;
  String? collectionAddress;

  Product({
    this.id,
    this.productName,
    this.images,
    this.variants,
    this.user,
    this.collectionAddress,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
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

class Messages {
  int? id;
  String? senderId;
  int? offerId;
  int? conversationId;
  String? msg;
  String? type;
  bool? isRead;
  String? createdAt;
  String? updatedAt;
  List<Attachments>? attachments;
  Offer? offer;

  Messages({
    this.id,
    this.senderId,
    this.offerId,
    this.conversationId,
    this.msg,
    this.type,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.attachments,
    this.offer,
  });

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id']?.toString();
    offerId = json['offer_id'];
    conversationId = json['conversation_id'];
    msg = json['msg']?.toString();
    type = json['type']?.toString();
    isRead = json['isRead'];
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    offer = json['offer'] != null ? Offer.fromJson(json['offer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['offer_id'] = offerId;
    data['conversation_id'] = conversationId;
    data['msg'] = msg;
    data['type'] = type;
    data['isRead'] = isRead;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    if (offer != null) {
      data['offer'] = offer!.toJson();
    }
    return data;
  }
}


class Attachments {
  int? id;
  String? fileUrl;
  String? fileType;
  String? fileName;
  String? uploadedAt;

  Attachments({
    this.id,
    this.fileUrl,
    this.fileType,
    this.fileName,
    this.uploadedAt,
  });

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileUrl = json['file_url']?.toString();
    fileType = json['file_type']?.toString();
    fileName = json['file_name']?.toString();
    uploadedAt = json['uploaded_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['file_url'] = fileUrl;
    data['file_type'] = fileType;
    data['file_name'] = fileName;
    data['uploaded_at'] = uploadedAt;
    return data;
  }
}


class Offer {
  int? id;
  String? sellerId;
  String? buyerId;
  String? orderId;
  int? productId;
  String? price;
  String? status;
  String? createdAt;
  String? updatedAt;

  Offer({
    this.id,
    this.sellerId,
    this.buyerId,
    this.orderId,
    this.productId,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id']?.toString();
    buyerId = json['buyer_id']?.toString();
    orderId = json['order_id']?.toString();
    productId = json['product_id'];
    price = json['price']?.toString();
    status = json['status']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['seller_id'] = sellerId;
    data['buyer_id'] = buyerId;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['price'] = price;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  void operator [](String other) {}
}
