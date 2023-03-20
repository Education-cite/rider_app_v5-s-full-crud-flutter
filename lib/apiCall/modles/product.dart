// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.active,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.name,
    this.email,
    this.price,
    this.quantity,
  });

  int? id;
  bool? active;
  DateTime? createdAt;
  dynamic createdBy;
  DateTime? updatedAt;
  dynamic updatedBy;
  String? name;
  String? email;
  String? price;
  String? quantity;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    active: json["active"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    createdBy: json["createdBy"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    updatedBy: json["updatedBy"],
    name: json["name"],
    email: json["email"],
    price: json["price"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "active": active,
    "createdAt": createdAt?.toIso8601String(),
    "createdBy": createdBy,
    "updatedAt": updatedAt?.toIso8601String(),
    "updatedBy": updatedBy,
    "name": name,
    "email": email,
    "price": price,
    "quantity": quantity,
  };
}
