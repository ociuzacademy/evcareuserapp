import 'dart:convert';
import 'dart:io';
import 'package:ev_booking/constants/urls.dart';
import 'package:ev_booking/modules/user_profile_vehicle/model/vehicle_profile_model.dart';
import 'package:ev_booking/utils/preference_values.dart';
import 'package:http/http.dart' as http;

Future<VehicleProfileModel> vehicleProfileService() async {
  try {
    //final user_id =int.parse("2");
    String userId = await PreferenceValues.getUserId();
    Map<String, dynamic> params = {
      'user_id': userId.toString(),
    };

    final resp = await http.get(
      Uri.parse(UserUrl.view_vehicle_profile)
          .replace(queryParameters: params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    //final List<dynamic> decoded = jsonDecode(resp.body);
    if (resp.statusCode == 200) {
      final dynamic decoded = jsonDecode(resp.body);

      final response = VehicleProfileModel.fromJson(decoded);
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
