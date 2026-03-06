class SizeModelData {
  int? id;
  String? type;
  String? name;

  SizeModelData({this.id, this.type, this.name});

  SizeModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
  }
}
