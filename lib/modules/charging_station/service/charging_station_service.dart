import 'dart:convert';
import 'dart:io';
import 'package:ev_booking/modules/charging_station/model/charging_station_model.dart';
import 'package:http/http.dart' as http;

Future<List<ChargingStationModel>> chargingStationList(
  //int? id,
) async {
  try {
    final resp = await http.get(
      Uri.parse('https://vqp6fbbv-8001.inc1.devtunnels.ms/user/view_ev_stations/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    final List<dynamic> decoded = jsonDecode(resp.body);
    if (resp.statusCode == 200) {
      final response = decoded.map((item) => ChargingStationModel.fromJson(item)).toList();
      return response;
    } else {
      throw Exception('Failed to load response');
    }
  } on SocketException {
    throw Exception('Server error');
  } on HttpException {
    throw Exception('Something went wrong');
  } on FormatException {
    throw Exception('Bad request');
  } catch (e) {
    throw Exception(e.toString());
  }
}