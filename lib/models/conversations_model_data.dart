class ConversationsModelData {
  int? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;
  List<Participants>? participants;
  Lastmsg? lastmsg;

  ConversationsModelData({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.participants,
    this.lastmsg,
  });

  ConversationsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
    lastmsg = json['lastmsg'] != null
        ? new Lastmsg.fromJson(json['lastmsg'])
        : null;
  }
}

class Participants {
  int? id;
  bool? isMuted;
  String? joinedAt;
  User? user;

  Participants({this.id, this.isMuted, this.joinedAt, this.user});

  Participants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isMuted = json['isMuted'];
    joinedAt = json['joined_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  bool? isActive;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.isActive,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    image = json['image'];
    isActive = json['isActive'];
  }
}

class Lastmsg {
  int? id;
  String? senderId;
  int? offerId;
  int? conversationId;
  String? msg;
  String? type;
  bool? isRead;
  String? createdAt;
  String? updatedAt;

  Lastmsg({
    this.id,
    this.senderId,
    this.offerId,
    this.conversationId,
    this.msg,
    this.type,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  Lastmsg.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    offerId = json['offer_id'];
    conversationId = json['conversation_id'];
    msg = json['msg'];
    type = json['type'];
    isRead = json['isRead'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
