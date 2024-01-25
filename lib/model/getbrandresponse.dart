// To parse this JSON data, do
//
//     final getbrandresponse = getbrandresponseFromJson(jsonString);

import 'dart:convert';

import 'package:manjha/services/custom_api.dart';

import '../const.dart';

Getbrandresponse getbrandresponseFromJson(String str) => Getbrandresponse.fromJson(json.decode(str));

String getbrandresponseToJson(Getbrandresponse data) => json.encode(data.toJson());

class Getbrandresponse {
  bool? success;
  List<Brands>? data;
  String? message;

  Getbrandresponse({
    this.success,
    this.data,
    this.message,
  });

  factory Getbrandresponse.fromJson(Map<String, dynamic> json) => Getbrandresponse(
    success: json["success"],
    data: List<Brands>.from(json["data"].map((x) => Brands.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}


class Brands {
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

  String? getName() {
    if (brandName!.isEmpty) {
      return brandName?.replaceAll('&amp;', '&');
    }
    return '';
  }

  String getImageUrl() {
    return image_brand_url +
        (brandImage!.isEmpty
            ? "no-photo.png"
            : brandImage!);
  }

  Brands({
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


  factory Brands.fromJson(Map<String, dynamic> json) => Brands(
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
