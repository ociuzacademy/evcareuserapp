// To parse this JSON data, do
//
//     final serviceCentre = serviceCentreFromJson(jsonString);

import 'dart:convert';

List<ServiceCentre> serviceCentreFromJson(String str) => List<ServiceCentre>.from(json.decode(str).map((x) => ServiceCentre.fromJson(x)));

String serviceCentreToJson(List<ServiceCentre> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceCentre {
    int? id;
    String? name;
    String? username;
    String? phone;
    String? email;
    String? password;
    String? address;
    String? longitude;
    String? latitude;
    dynamic image;
    String? workingHours;
    String? utype;
    String? status;

    ServiceCentre({
        this.id,
        this.name,
        this.username,
        this.phone,
        this.email,
        this.password,
        this.address,
        this.longitude,
        this.latitude,
        this.image,
        this.workingHours,
        this.utype,
        this.status,
    });

    factory ServiceCentre.fromJson(Map<String, dynamic> json) => ServiceCentre(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        image: json["image"],
        workingHours: json["working_hours"],
        utype: json["utype"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "phone": phone,
        "email": email,
        "password": password,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "image": image,
        "working_hours": workingHours,
        "utype": utype,
        "status": status,
    };
}
