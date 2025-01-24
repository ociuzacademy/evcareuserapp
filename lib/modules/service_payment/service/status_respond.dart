import 'dart:convert';
import 'dart:io';
import 'package:ev_booking/modules/service_payment/model/payment_response_model.dart';


import 'package:http/http.dart' as http;

Future<PaymentResponseModel> paymentServiceRespond(
  {
    required int  reairId,
  }
  
) async {
  try {
     Map<String, dynamic> params = {
       'repair': reairId.toString(),
     };
    final resp = await http.patch(
      Uri.parse('https://vqp6fbbv-8001.inc1.devtunnels.ms/user/user_update_status/').replace(queryParameters: params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    //final dynamic decoded = jsonDecode(resp.body);
    if (resp.statusCode == 200) {

      final dynamic decoded = jsonDecode(resp.body);
      final response = PaymentResponseModel.fromJson(decoded);
          
      return response;
      // final response = decoded.map((item) => SingleProductListModel.fromJson(item)).toList();
      // return response;
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