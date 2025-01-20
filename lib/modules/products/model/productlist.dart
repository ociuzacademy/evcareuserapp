// To parse this JSON data, do
//
//     final productList = productListFromJson(jsonString);

import 'dart:convert';

List<ProductListModel> productListFromJson(String str) => List<ProductListModel>.from(json.decode(str).map((x) => ProductListModel.fromJson(x)));

String productListToJson(List<ProductListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductListModel {
    int? id;
    String? name;
    String? description;
    String? price;
    String? quantity;
    String? image;
    int? serviceCentre;

    ProductListModel({
        this.id,
        this.name,
        this.description,
        this.price,
        this.quantity,
        this.image,
        this.serviceCentre,
    });

    factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        quantity: json["quantity"],
        image: json["image"],
        serviceCentre: json["service_centre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "quantity": quantity,
        "image": image,
        "service_centre": serviceCentre,
    };
}
