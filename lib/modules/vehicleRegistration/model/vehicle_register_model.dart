// To parse this JSON data, do
//
//     final vehicleRegisterResponseModel = vehicleRegisterResponseModelFromJson(jsonString);

import 'dart:convert';

VehicleRegisterResponseModel vehicleRegisterResponseModelFromJson(String str) => VehicleRegisterResponseModel.fromJson(json.decode(str));

String vehicleRegisterResponseModelToJson(VehicleRegisterResponseModel data) => json.encode(data.toJson());

class VehicleRegisterResponseModel {
    String? status;
    String? message;

    VehicleRegisterResponseModel({
        this.status,
        this.message,
    });

    factory VehicleRegisterResponseModel.fromJson(Map<String, dynamic> json) => VehicleRegisterResponseModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
