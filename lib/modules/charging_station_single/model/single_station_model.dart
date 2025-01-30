// To parse this JSON data, do
//
//     final singleChargingStationModel = singleChargingStationModelFromJson(jsonString);

import 'dart:convert';

SingleChargingStationModel singleChargingStationModelFromJson(String str) => SingleChargingStationModel.fromJson(json.decode(str));

String singleChargingStationModelToJson(SingleChargingStationModel data) => json.encode(data.toJson());

class SingleChargingStationModel {
    int? id;
    List<Slot>? slots;
    String? image;
    String? name;
    String? address;
    String? workingHours;
    List<String>? connectors;
    String? ratePerMinute;
    String? capacity;

    SingleChargingStationModel({
        this.id,
        this.slots,
        this.image,
        this.name,
        this.address,
        this.workingHours,
        this.connectors,
        this.ratePerMinute,
        this.capacity,
    });

    factory SingleChargingStationModel.fromJson(Map<String, dynamic> json) => SingleChargingStationModel(
        id: json["id"],
        slots: json["slots"] == null ? [] : List<Slot>.from(json["slots"]!.map((x) => Slot.fromJson(x))),
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
        "slots": slots == null ? [] : List<dynamic>.from(slots!.map((x) => x.toJson())),
        "image": image,
        "name": name,
        "address": address,
        "working_hours": workingHours,
        "connectors": connectors == null ? [] : List<dynamic>.from(connectors!.map((x) => x)),
        "rate_per_minute": ratePerMinute,
        "capacity": capacity,
    };
}

class Slot {
    int? id;
    String? startTime;
    String? endTime;
    bool? isBooked;
    int? station;

    Slot({
        this.id,
        this.startTime,
        this.endTime,
        this.isBooked,
        this.station,
    });

    factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        id: json["id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        isBooked: json["is_booked"],
        station: json["station"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": startTime,
        "end_time": endTime,
        "is_booked": isBooked,
        "station": station,
    };
}
