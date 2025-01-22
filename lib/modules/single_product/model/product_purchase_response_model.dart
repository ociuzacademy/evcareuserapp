// To parse this JSON data, do
//
//     final productPurchaseResponseModel = productPurchaseResponseModelFromJson(jsonString);

import 'dart:convert';

ProductPurchaseResponseModel productPurchaseResponseModelFromJson(String str) => ProductPurchaseResponseModel.fromJson(json.decode(str));

String productPurchaseResponseModelToJson(ProductPurchaseResponseModel data) => json.encode(data.toJson());

class ProductPurchaseResponseModel {
    String? status;
    String? message;
    Data? data;

    ProductPurchaseResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory ProductPurchaseResponseModel.fromJson(Map<String, dynamic> json) => ProductPurchaseResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    int? quantity;
    String? price;
    DateTime? date;
    int? user;
    int? product;

    Data({
        this.id,
        this.quantity,
        this.price,
        this.date,
        this.user,
        this.product,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        quantity: json["quantity"],
        price: json["price"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        user: json["user"],
        product: json["product"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "price": price,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "user": user,
        "product": product,
    };
}
