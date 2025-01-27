// To parse this JSON data, do
//
//     final chargingStationModel = chargingStationModelFromJson(jsonString);

import 'dart:convert';

List<ChargingStationModel> chargingStationModelFromJson(String str) => List<ChargingStationModel>.from(json.decode(str).map((x) => ChargingStationModel.fromJson(x)));

String chargingStationModelToJson(List<ChargingStationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChargingStationModel {
    int? id;
    String? image;
    String? name;
    String? address;
    String? workingHours;
    List<String>? connectors;
    String? ratePerMinute;
    String? capacity;

    ChargingStationModel({
        this.id,
        this.image,
        this.name,
        this.address,
        this.workingHours,
        this.connectors,
        this.ratePerMinute,
        this.capacity,
    });

    factory ChargingStationModel.fromJson(Map<String, dynamic> json) => ChargingStationModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        address: json["address"],
        workingHours: json["working_hours"],
        connectors: json["connectors"] == null ? [] : List<String>.from(json["connectors"]!.map((x) => x)),
        ratePerMinute: json["rate_per_minute"],
        capacity: json["capacity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "address": address,
        "working_hours": workingHours,
        "connectors": connectors == null ? [] : List<dynamic>.from(connectors!.map((x) => x)),
        "rate_per_minute": ratePerMinute,
        "capacity": capacity,
    };
}
