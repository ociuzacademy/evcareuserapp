// To parse this JSON data, do
//
//     final vehicleRegisterResponseModel = vehicleRegisterResponseModelFromJson(jsonString);

import 'dart:convert';

ServiceListModel vehicleRegisterResponseModelFromJson(String str) => ServiceListModel.fromJson(json.decode(str));

String vehicleRegisterResponseModelToJson(ServiceListModel data) => json.encode(data.toJson());

class ServiceListModel {
    String? status;
    String? message;

    ServiceListModel({
        this.status,
        this.message,
    });

    factory ServiceListModel.fromJson(Map<String, dynamic> json) => ServiceListModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
