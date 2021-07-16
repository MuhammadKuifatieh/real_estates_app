// To parse this JSON data, do
//
//     final House = HouseFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';

House houseFromJson(String str) => House.fromJson(json.decode(str));

String houseToJson(House data) => json.encode(data.toJson());

class House with ChangeNotifier {
  House({
    this.id,
    this.description,
    this.streetAddress,
    this.price,
    this.baseImage,
    this.otherImage,
    this.bedrooms,
    this.bathrooms,
    this.sqftLiving,
    this.sqftLot,
    this.floors,
    this.waterfront,
    this.view,
    this.condition,
    this.grade,
    this.sqftAbove,
    this.sqftBasement,
    this.yrBuilt,
    this.yrRenovated,
    this.zipcode,
    this.lattitude,
    this.longitude,
    this.isliked,
    this.countlikes,
    this.countcomments,
    this.user,
  });

  int id;
  String description;
  String streetAddress;
  double price;
  String baseImage;
  List<String> otherImage;
  int bedrooms;
  int bathrooms;
  int sqftLiving;
  int sqftLot;
  int floors;
  int waterfront;
  int view;
  int condition;
  int grade;
  int sqftAbove;
  int sqftBasement;
  int yrBuilt;
  int yrRenovated;
  int zipcode;
  String lattitude;
  String longitude;
  bool isliked;
  int countlikes;
  int countcomments;
  User user;

  factory House.fromJson(Map<String, dynamic> json) => House(
        id: json["id"],
        description: json["description"],
        streetAddress: json["street_address"],
        price: (json['price'] != null) ? json["price"].toDouble() : null,
        baseImage: json["base_image"],
        otherImage: List<String>.from(json["other_image"].map((x) => x)),
        bedrooms: json["bedrooms"],
        bathrooms: json["bathrooms"],
        sqftLiving: json["sqft_living"],
        sqftLot: json["sqft_lot"],
        floors: json["floors"],
        waterfront: json["waterfront"],
        view: json["view"],
        condition: json["condition"],
        grade: json["grade"],
        sqftAbove: json["sqft_above"],
        sqftBasement: json["sqft_basement"],
        yrBuilt: json["yr_built"],
        yrRenovated: json["yr_renovated"],
        zipcode: json["zipcode"],
        lattitude: json["lattitude"],
        longitude: json["longitude"],
        isliked: json["isliked"],
        countlikes: json["countlikes"],
        countcomments: json["countcomments"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "street_address": streetAddress,
        "price": price,
        "base_image": baseImage,
        "other_image": List<dynamic>.from(otherImage.map((x) => x)),
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "sqft_living": sqftLiving,
        "sqft_lot": sqftLot,
        "floors": floors,
        "waterfront": waterfront,
        "view": view,
        "condition": condition,
        "grade": grade,
        "sqft_above": sqftAbove,
        "sqft_basement": sqftBasement,
        "yr_built": yrBuilt,
        "yr_renovated": yrRenovated,
        "zipcode": zipcode,
        "lattitude": lattitude,
        "longitude": longitude,
        "isliked": isliked,
        "countlikes": countlikes,
        "countcomments": countcomments,
        "user": user.toJson(),
      };
  changeLike() {
    isliked = !isliked;
    notifyListeners();
  }
}
