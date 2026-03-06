class CategoryModelData {
  int? id;
  int? categoryId;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  Category? category;

  CategoryModelData({
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  CategoryModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }
}

class Category {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
