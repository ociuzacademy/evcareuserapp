import 'dart:convert';
import 'dart:io';
import 'package:ev_booking/constants/urls.dart';
import 'package:ev_booking/modules/vehicleRegistration/model/vehicle_register_model.dart';
import 'package:ev_booking/utils/preference_values.dart';

import 'package:http/http.dart' as http;

Future<ServiceListModel> vehicleRegisterService({
  required String brand,
  required String model,
  required String connector_type,
  required String vin,
  required String registration_num,
}) async {
  try {
    String user = await PreferenceValues.getUserId();
    Map<String, dynamic> param = {
      "brand": brand,
      "model": model,
      "connector_type": connector_type,
      "vin": vin,
      "registration_num": registration_num,
      "user": user,
    };

    final resp = await http.post(
      Uri.parse(UserUrl.vehicleProfileUrl),
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(resp.body);
      final response = ServiceListModel.fromJson(decoded);

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
