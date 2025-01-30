import 'dart:convert';
import 'dart:io';
import 'package:ev_booking/constants/urls.dart';
import 'package:ev_booking/modules/view_start_charging/model/response_start_model.dart';

import 'package:http/http.dart' as http;

Future<ResponseStatusModel> stopChargingService({
  required String bookingHistoryId,
  
 

}) async {
  try {
    Map<String, dynamic> param = {
     "id":bookingHistoryId,
     
    };

    final resp = await http.patch(
      Uri.parse('https://vqp6fbbv-8001.inc1.devtunnels.ms/user/stop_charging/'), 
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (resp.statusCode == 200) {
      

      final dynamic decoded = jsonDecode(resp.body);
      final response = ResponseStatusModel.fromJson(decoded);
          
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