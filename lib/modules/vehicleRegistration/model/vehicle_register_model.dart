// To parse this JSON data, do
//
//     final serviceListModel = serviceListModelFromJson(jsonString);

import 'dart:convert';

ServiceListModel serviceListModelFromJson(String str) =>
    ServiceListModel.fromJson(json.decode(str));

String serviceListModelToJson(ServiceListModel data) =>
    json.encode(data.toJson());

class ServiceListModel {
  String? status;
  String? message;
  int? vehicleId;

  ServiceListModel({
    this.status,
    this.message,
    this.vehicleId,
  });

  factory ServiceListModel.fromJson(Map<String, dynamic> json) =>
      ServiceListModel(
        status: json["status"],
        message: json["message"],
        vehicleId: json["vehicle_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "vehicle_id": vehicleId,
      };
}
