// To parse this JSON data, do
//
//     final vehicleRegisterModel = vehicleRegisterModelFromJson(jsonString);

import 'dart:convert';

VehicleRegisterModel vehicleRegisterModelFromJson(String str) => VehicleRegisterModel.fromJson(json.decode(str));

String vehicleRegisterModelToJson(VehicleRegisterModel data) => json.encode(data.toJson());

class VehicleRegisterModel {
    String? status;
    String? message;
    int? user;
    

    VehicleRegisterModel({
        this.status,
        this.message,
        this.user,
    });

    factory VehicleRegisterModel.fromJson(Map<String, dynamic> json) => VehicleRegisterModel(
        status: json["status"],
        message: json["message"],
        user: json['user']
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        'user':user,
    };
}
