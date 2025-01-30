// To parse this JSON data, do
//
//     final viewChargingStationModel = viewChargingStationModelFromJson(jsonString);

import 'dart:convert';

List<ViewChargingStationModel> viewChargingStationModelFromJson(String str) => List<ViewChargingStationModel>.from(json.decode(str).map((x) => ViewChargingStationModel.fromJson(x)));

String viewChargingStationModelToJson(List<ViewChargingStationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewChargingStationModel {
    int? id;
    String? chargingStationName;
    String? amount;
    DateTime? bookingDate;
    String? startTime;

    ViewChargingStationModel({
        this.id,
        this.chargingStationName,
        this.amount,
        this.bookingDate,
        this.startTime,
    });

    factory ViewChargingStationModel.fromJson(Map<String, dynamic> json) => ViewChargingStationModel(
        id: json["id"],
        chargingStationName: json["charging_station_name"],
        amount: json["amount"],
        bookingDate: json["booking_date"] == null ? null : DateTime.parse(json["booking_date"]),
        startTime: json["start_time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "charging_station_name": chargingStationName,
        "amount": amount,
        "booking_date": "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
    };
}
