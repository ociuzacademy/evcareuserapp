// To parse this JSON data, do
//
//     final singleRepairModel = singleRepairModelFromJson(jsonString);

import 'dart:convert';

List<SingleRepairModel> singleRepairModelFromJson(String str) => List<SingleRepairModel>.from(json.decode(str).map((x) => SingleRepairModel.fromJson(x)));

String singleRepairModelToJson(List<SingleRepairModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SingleRepairModel {
    String? serviceName;
    List<Service>? services;
    String? status;
    String? repairCost;
    int? id;
    int? serviceCentre;

    SingleRepairModel({
        this.serviceName,
        this.services,
        this.status,
        this.repairCost,
        this.id,
        this.serviceCentre,
    });

    factory SingleRepairModel.fromJson(Map<String, dynamic> json) => SingleRepairModel(
        serviceName: json["service_name"],
        services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
        status: json["status"],
        repairCost: json["repair_cost"],
        id: json["id"],
        serviceCentre: json["service_centre"],
    );

    Map<String, dynamic> toJson() => {
        "service_name": serviceName,
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
        "status": status,
        "repair_cost": repairCost,
        "id": id,
        "service_centre": serviceCentre,
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
