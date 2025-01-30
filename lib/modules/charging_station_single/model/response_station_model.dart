// To parse this JSON data, do
//
//     final responseChargingStationModel = responseChargingStationModelFromJson(jsonString);

import 'dart:convert';

ResponseChargingStationModel responseChargingStationModelFromJson(String str) => ResponseChargingStationModel.fromJson(json.decode(str));

String responseChargingStationModelToJson(ResponseChargingStationModel data) => json.encode(data.toJson());

class ResponseChargingStationModel {
    String? status;
    String? message;
    Booking? booking;

    ResponseChargingStationModel({
        this.status,
        this.message,
        this.booking,
    });

    factory ResponseChargingStationModel.fromJson(Map<String, dynamic> json) => ResponseChargingStationModel(
        status: json["status"],
        message: json["message"],
        booking: json["booking"] == null ? null : Booking.fromJson(json["booking"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "booking": booking?.toJson(),
    };
}

class Booking {
    int? id;
    int? slot;
    int? user;
    String? paymentStatus;
    String? connector;

    Booking({
        this.id,
        this.slot,
        this.user,
        this.paymentStatus,
        this.connector,
    });

    factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        slot: json["slot"],
        user: json["user"],
        paymentStatus: json["payment_status"],
        connector: json["connector"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "slot": slot,
        "user": user,
        "payment_status": paymentStatus,
        "connector": connector,
    };
}
