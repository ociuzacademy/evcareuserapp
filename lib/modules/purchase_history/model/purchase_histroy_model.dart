// To parse this JSON data, do
//
//     final purchaseHistoryModel = purchaseHistoryModelFromJson(jsonString);

import 'dart:convert';

List<PurchaseHistoryModel> purchaseHistoryModelFromJson(String str) => List<PurchaseHistoryModel>.from(json.decode(str).map((x) => PurchaseHistoryModel.fromJson(x)));

String purchaseHistoryModelToJson(List<PurchaseHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PurchaseHistoryModel {
    int? id;
    String? productName;
    int? quantity;
    String? price;
    DateTime? date;
    int? user;
    int? product;
    int? serviceCentre;

    PurchaseHistoryModel({
        this.id,
        this.productName,
        this.quantity,
        this.price,
        this.date,
        this.user,
        this.product,
        this.serviceCentre,
    });

    factory PurchaseHistoryModel.fromJson(Map<String, dynamic> json) => PurchaseHistoryModel(
        id: json["id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        price: json["price"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        user: json["user"],
        product: json["product"],
        serviceCentre: json["service_centre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "quantity": quantity,
        "price": price,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "user": user,
        "product": product,
        "service_centre": serviceCentre,
    };
}
