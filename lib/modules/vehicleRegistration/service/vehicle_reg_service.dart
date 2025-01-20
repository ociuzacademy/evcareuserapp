import 'dart:convert';
import 'dart:io';
import 'package:ev_booking/constants/urls.dart';
import 'package:ev_booking/modules/vehicleRegistration/model/vehicle_register_model.dart';

import 'package:http/http.dart' as http;

Future<VehicleRegisterResponseModel> vehicleRegisterService({
  required String brand,
  required String model,
  required String connector_type,
  required String vin,
  required String registration_num,
  required int user,
}) async {
  try {
        final s =int.parse("2");
    Map<String, dynamic> param = {
      "brand": brand,
      "model": model,
      "connector_type": connector_type,
      "vin": vin,
      "registration_num": registration_num,
      "user" : s,  
    };

    final resp = await http.post(
      Uri.parse('https://vqp6fbbv-8001.inc1.devtunnels.ms/user/user_register_vehicle/'), 
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      
    );

    if (resp.statusCode == 200) {
      
      final dynamic decoded = jsonDecode(resp.body);
      final response = VehicleRegisterResponseModel.fromJson(decoded);
          
      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(resp.body);
      throw Exception(
        'Failed to register: ${errorResponse['message'] ?? 'Unknown error'}',
      );
    }
  } on SocketException {
    throw Exception('No Internet connection');
  } on HttpException {
    throw Exception('Server error');
  } on FormatException {
    throw Exception('Bad response format');
  } catch (e) {
    throw Exception('Unexpected error: ${e.toString()}');
  }
}