// To parse this JSON data, do
//
//     final serviceStatusModel = serviceStatusModelFromJson(jsonString);

import 'dart:convert';

List<ServiceStatusModel> serviceStatusModelFromJson(String str) => List<ServiceStatusModel>.from(json.decode(str).map((x) => ServiceStatusModel.fromJson(x)));

String serviceStatusModelToJson(List<ServiceStatusModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceStatusModel {
    String? serviceName;
    List<Service>? services;
    String? status;
    String? repairCost;
    int? id;

    ServiceStatusModel({
        this.serviceName,
        this.services,
        this.status,
        this.repairCost,
        this.id,
    });

    factory ServiceStatusModel.fromJson(Map<String, dynamic> json) => ServiceStatusModel(
        serviceName: json["service_name"],
        services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
        status: json["status"],
        repairCost: json["repair_cost"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "service_name": serviceName,
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
        "status": status,
        "repair_cost": repairCost,
        "id": id,
    };
}

class Service {
    String? name;
    String? time;
    int? amount;

    Service({
        this.name,
        this.time,
        this.amount,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        name: json["name"],
        time: json["time"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "time": time,
        "amount": amount,
    };
}
