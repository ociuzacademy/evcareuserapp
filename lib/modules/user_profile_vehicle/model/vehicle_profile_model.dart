// To parse this JSON data, do
//
//     final vehicleProfileModel = vehicleProfileModelFromJson(jsonString);

import 'dart:convert';

List<VehicleProfileModel> vehicleProfileModelFromJson(String str) => List<VehicleProfileModel>.from(json.decode(str).map((x) => VehicleProfileModel.fromJson(x)));

String vehicleProfileModelToJson(List<VehicleProfileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VehicleProfileModel {
    int? id;
    String? brand;
    String? model;
    String? connectorType;
    String? vin;
    String? registrationNum;
    int? user;

    VehicleProfileModel({
        this.id,
        this.brand,
        this.model,
        this.connectorType,
        this.vin,
        this.registrationNum,
        this.user,
    });

    factory VehicleProfileModel.fromJson(Map<String, dynamic> json) => VehicleProfileModel(
        id: json["id"],
        brand: json["brand"],
        model: json["model"],
        connectorType: json["connector_type"],
        vin: json["vin"],
        registrationNum: json["registration_num"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "brand": brand,
        "model": model,
        "connector_type": connectorType,
        "vin": vin,
        "registration_num": registrationNum,
        "user": user,
    };
}
