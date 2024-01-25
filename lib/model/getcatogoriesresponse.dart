// To parse this JSON data, do
//
//     final getcategoriesresponse = getcategoriesresponseFromJson(jsonString);

import 'dart:convert';

Getcategoriesresponse getcategoriesresponseFromJson(String str) => Getcategoriesresponse.fromJson(json.decode(str));

String getcategoriesresponseToJson(Getcategoriesresponse data) => json.encode(data.toJson());

class Getcategoriesresponse {
  bool? success;
  List<Categorys>? data;
  String? message;

  Getcategoriesresponse({
    this.success,
    this.data,
    this.message,
  });

  factory Getcategoriesresponse.fromJson(Map<String, dynamic> json) => Getcategoriesresponse(
    success: json["success"],
    data: List<Categorys>.from(json["data"].map((x) => Categorys.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Categorys {
  int? id;
  String? categoryName;
  String? categoryDescription;
  String? categoryImage;
  int? parentId;
  String? brandIds;
  int? sortOrder;
  bool? isActive;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? totalChildren;
  List<Brand>? brands;
  String? imageUrl;

  Categorys({
    this.id,
    this.categoryName,
    this.categoryDescription,
    this.categoryImage,
    this.parentId,
    this.brandIds,
    this.sortOrder,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.totalChildren,
    this.brands,
    this.imageUrl,
  });

  factory Categorys.fromJson(Map<String, dynamic> json) => Categorys(
    id: json["id"],
    categoryName: json["category_name"],
    categoryDescription: json["category_description"],
    categoryImage: json["category_image"],
    parentId: json["parent_id"],
    brandIds: json["brand_ids"],
    sortOrder: json["sort_order"],
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    totalChildren: json["total_children"],
    brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "category_description": categoryDescription,
    "category_image": categoryImage,
    "parent_id": parentId,
    "brand_ids": brandIds,
    "sort_order": sortOrder,
    "is_active": isActive,
    "is_deleted": isDeleted,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "total_children": totalChildren,
    "brands": List<dynamic>.from(brands!.map((x) => x.toJson())),
    "image_url": imageUrl,
  };
}

class Brand {
  int? id;
  String? brandName;
  String? brandDescription;
  String? brandImage;
  int? sortOrder;
  int? moqLotSize;
  bool? isActive;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  Brand({
    this.id,
    this.brandName,
    this.brandDescription,
    this.brandImage,
    this.sortOrder,
    this.moqLotSize,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    brandName: json["brand_name"],
    brandDescription: json["brand_description"],
    brandImage: json["brand_image"],
    sortOrder: json["sort_order"],
    moqLotSize: json["moq_lot_size"],
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand_name": brandName,
    "brand_description": brandDescription,
    "brand_image": brandImage,
    "sort_order": sortOrder,
    "moq_lot_size": moqLotSize,
    "is_active": isActive,
    "is_deleted": isDeleted,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image_url": imageUrl,
  };
}
