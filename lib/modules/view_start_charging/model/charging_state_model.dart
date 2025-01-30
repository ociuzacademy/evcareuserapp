// To parse this JSON data, do
//
//     final singleChargingStationBillModel = singleChargingStationBillModelFromJson(jsonString);

import 'dart:convert';

SingleChargingStationBillModel singleChargingStationBillModelFromJson(String str) => SingleChargingStationBillModel.fromJson(json.decode(str));

String singleChargingStationBillModelToJson(SingleChargingStationBillModel data) => json.encode(data.toJson());

class SingleChargingStationBillModel {
    String? chargingStationName;
    String? amount;
    DateTime? bookingDate;
    String? startTime;
    String? endTime;
    String? address;
    String? chargingStatus;

    SingleChargingStationBillModel({
        this.chargingStationName,
        this.amount,
        this.bookingDate,
        this.startTime,
        this.endTime,
        this.address,
        this.chargingStatus,
    });

    factory SingleChargingStationBillModel.fromJson(Map<String, dynamic> json) => SingleChargingStationBillModel(
        chargingStationName: json["charging_station_name"],
        amount: json["amount"],
        bookingDate: json["booking_date"] == null ? null : DateTime.parse(json["booking_date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        address: json["address"],
        chargingStatus: json["charging_status"],
    );

    Map<String, dynamic> toJson() => {
        "charging_station_name": chargingStationName,
        "amount": amount,
        "booking_date": "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "address": address,
        "charging_status": chargingStatus,
    };
}
