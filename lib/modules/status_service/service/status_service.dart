import 'dart:convert';
import 'dart:io';
import 'package:ev_booking/modules/status_service/model/status_service_model.dart';
import 'package:http/http.dart' as http;

Future<List<ServiceStatusModel>> serviceCenterStatusService({
  required int user_id,
  }
) async {
  try {
    
    Map<String,dynamic> param = {
      "user": user_id.toString(),
    };

    final resp = await http.get(
      Uri.parse('https://vqp6fbbv-8001.inc1.devtunnels.ms/user/view_repair_requests/').replace(queryParameters: param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    final List<dynamic> decoded = jsonDecode(resp.body);
    if (resp.statusCode == 200) {
      final response = decoded.map((item) => ServiceStatusModel.fromJson(item)).toList();
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