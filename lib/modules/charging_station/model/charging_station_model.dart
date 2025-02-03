// To parse this JSON data, do
//
//     final chargingStationModel = chargingStationModelFromJson(jsonString);

import 'dart:convert';

List<ChargingStationModel> chargingStationModelFromJson(String str) =>
    List<ChargingStationModel>.from(
        json.decode(str).map((x) => ChargingStationModel.fromJson(x)));

String chargingStationModelToJson(List<ChargingStationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChargingStationModel {
  int? id;
  List<Slot>? slots;
  String? image;
  String? name;
  String? address;
  String? workingHours;
  List<Connector>? connectors;
  String? ratePerSlot;
  String? capacity;

  ChargingStationModel({
    this.id,
    this.slots,
    this.image,
    this.name,
    this.address,
    this.workingHours,
    this.connectors,
    this.ratePerSlot,
    this.capacity,
  });

  factory ChargingStationModel.fromJson(Map<String, dynamic> json) =>
      ChargingStationModel(
        id: json["id"],
        slots: json["slots"] == null
            ? []
            : List<Slot>.from(json["slots"]!.map((x) => Slot.fromJson(x))),
        image: json["image"],
        name: json["name"],
        address: json["address"],
        workingHours: json["working_hours"],
        connectors: json["connectors"] == null
            ? []
            : List<Connector>.from(
                json["connectors"]!.map((x) => connectorValues.map[x]!)),
        ratePerSlot: json["rate_per_slot"],
        capacity: json["capacity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slots": slots == null
            ? []
            : List<dynamic>.from(slots!.map((x) => x.toJson())),
        "image": image,
        "name": name,
        "address": address,
        "working_hours": workingHours,
        "connectors": connectors == null
            ? []
            : List<dynamic>.from(
                connectors!.map((x) => connectorValues.reverse[x])),
        "rate_per_slot": ratePerSlot,
        "capacity": capacity,
      };
}

enum Connector { GB_T, TYPE_1, TYPE_2_CONNECTORS }

final connectorValues = EnumValues({
  "GB/T ": Connector.GB_T,
  "Type 1": Connector.TYPE_1,
  "Type 2 connectors": Connector.TYPE_2_CONNECTORS
});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
