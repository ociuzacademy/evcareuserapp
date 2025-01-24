import 'dart:convert';
import 'dart:io';                                      

import 'package:ev_booking/modules/service_list/model/service_list_model.dart';
import 'package:http/http.dart' as http;

Future<ServiceListRequestModel> serviceListRequestService({
  
  required int user,
  required  List<Map<String, dynamic>> service,
  required int  service_center_id,
}) async {
  try {
    
    //final user =int.parse("2");
    final vehicle = int.parse("5");

    Map<String, dynamic> param = {
      
      "user" : user.toString(), 
      "services"  :service,
      "service_centre" : service_center_id.toString(),
      "vehicle" : vehicle.toString(),


    };

    final resp = await http.post(
      Uri.parse('https://vqp6fbbv-8001.inc1.devtunnels.ms/user/repair_request/'), 
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      
    );

    if (resp.statusCode == 200) {
      
      final dynamic decoded = jsonDecode(resp.body);
      final response = ServiceListRequestModel.fromJson(decoded);
          
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