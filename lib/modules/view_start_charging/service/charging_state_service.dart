import 'dart:convert';
import 'dart:io';
import 'package:ev_booking/constants/urls.dart';
import 'package:ev_booking/modules/view_start_charging/model/charging_state_model.dart';
import 'package:http/http.dart' as http;

Future<SingleChargingStationBillModel>bookingService(
   {
     required int booking_id,
  }
  
) async {
  try {

    //final user_id =int.parse("2");

     Map<String, dynamic> params = {
      'booking_id': booking_id.toString(),
     };

    final resp = await http.get(
      Uri.parse("https://vqp6fbbv-8001.inc1.devtunnels.ms/user/single_booking/").replace(queryParameters: params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    //final List<dynamic> decoded = jsonDecode(resp.body);
    if (resp.statusCode == 200) {

      final dynamic decoded = jsonDecode(resp.body);
      final response = SingleChargingStationBillModel.fromJson(decoded);
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