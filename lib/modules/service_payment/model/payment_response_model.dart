// To parse this JSON data, do
//
//     final paymentResponseModel = paymentResponseModelFromJson(jsonString);

import 'dart:convert';

PaymentResponseModel paymentResponseModelFromJson(String str) => PaymentResponseModel.fromJson(json.decode(str));

String paymentResponseModelToJson(PaymentResponseModel data) => json.encode(data.toJson());

class PaymentResponseModel {
    String? status;
    String? message;

    PaymentResponseModel({
        this.status,
        this.message,
    });

    factory PaymentResponseModel.fromJson(Map<String, dynamic> json) => PaymentResponseModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
