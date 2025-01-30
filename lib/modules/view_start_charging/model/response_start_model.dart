// To parse this JSON data, do
//
//     final responseStatusModel = responseStatusModelFromJson(jsonString);

import 'dart:convert';

ResponseStatusModel responseStatusModelFromJson(String str) => ResponseStatusModel.fromJson(json.decode(str));

String responseStatusModelToJson(ResponseStatusModel data) => json.encode(data.toJson());

class ResponseStatusModel {
    String? status;
    String? message;

    ResponseStatusModel({
        this.status,
        this.message,
    });

    factory ResponseStatusModel.fromJson(Map<String, dynamic> json) => ResponseStatusModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
