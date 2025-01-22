// To parse this JSON data, do
//
//     final singleProductListModel = singleProductListModelFromJson(jsonString);

import 'dart:convert';

SingleProductListModel singleProductListModelFromJson(String str) => SingleProductListModel.fromJson(json.decode(str));

String singleProductListModelToJson(SingleProductListModel data) => json.encode(data.toJson());

class SingleProductListModel {
    int? id;
    String? image;
    String? name;
    String? description;
    String? price;
    String? quantity;
    int? serviceCentre;

    SingleProductListModel({
        this.id,
        this.image,
        this.name,
        this.description,
        this.price,
        this.quantity,
        this.serviceCentre,
    });

    factory SingleProductListModel.fromJson(Map<String, dynamic> json) => SingleProductListModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        quantity: json["quantity"],
        serviceCentre: json["service_centre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "price": price,
        "quantity": quantity,
        "service_centre": serviceCentre,
    };
}
