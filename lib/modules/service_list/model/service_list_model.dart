// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

ServiceListRequestModel loginResponseModelFromJson(String str) => ServiceListRequestModel.fromJson(json.decode(str));

String loginResponseModelToJson(ServiceListRequestModel data) => json.encode(data.toJson());

class ServiceListRequestModel {
    String? status;
    String? message;
    String? userId;

    ServiceListRequestModel({
        this.status,
        this.message,
        this.userId,
    });

    factory ServiceListRequestModel.fromJson(Map<String, dynamic> json) => ServiceListRequestModel(
        status: json["status"],
        message: json["message"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_id": userId,
    };
}
