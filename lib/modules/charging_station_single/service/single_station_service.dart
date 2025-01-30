import 'dart:convert';
import 'dart:io';
import 'package:ev_booking/modules/charging_station_single/model/single_station_model.dart';
import 'package:http/http.dart' as http;

Future<SingleChargingStationModel>singleChargingStationService(
  {
    required String charging_station_id,
  }
  
) async {

  try {
     Map<String, dynamic> params = {
      'id': charging_station_id,
     };
     
    final resp = await http.get(
      Uri.parse('https://vqp6fbbv-8001.inc1.devtunnels.ms/user/view_single_charging_station/').replace(queryParameters: params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    final dynamic decoded = jsonDecode(resp.body);
    if (resp.statusCode == 200) {
      final response = SingleChargingStationModel.fromJson(decoded);

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