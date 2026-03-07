class NotificationModelData {
  int? id;
  String? msg;
  String? related;
  String? action;
  String? type;
  int? targetId;
  bool? isRead;
  bool? isImportant;
  String? createdAt;
  String? updatedAt;

  NotificationModelData({
    this.id,
    this.msg,
    this.related,
    this.action,
    this.type,
    this.targetId,
    this.isRead,
    this.isImportant,
    this.createdAt,
    this.updatedAt,
  });

  NotificationModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msg = json['msg'];
    related = json['related'];
    action = json['action'];
    type = json['type'];
    targetId = json['target_id'];
    isRead = json['isRead'];
    isImportant = json['isImportant'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
