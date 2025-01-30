import 'dart:convert';
import 'dart:io';


import 'package:ev_booking/constants/urls.dart';
import 'package:ev_booking/modules/charging_station_single/model/response_station_model.dart';


import 'package:http/http.dart' as http;

Future<ResponseChargingStationModel> bookSlotService({
  required int user_id,
  required String connector,
  required int slot_id,

}) async {
  try {
    Map<String, dynamic> param = {
     "user":user_id,
      "connector":connector,
      "slot":slot_id,
    };

    final resp = await http.post(
      Uri.parse('https://vqp6fbbv-8001.inc1.devtunnels.ms/user/book_slot/'), 
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (resp.statusCode == 200) {
      
      final dynamic decoded = jsonDecode(resp.body);
      final response = ResponseChargingStationModel.fromJson(decoded);
          
      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(resp.body);
      throw Exception(
        '${errorResponse['message'] ?? 'Unknown error'}',
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