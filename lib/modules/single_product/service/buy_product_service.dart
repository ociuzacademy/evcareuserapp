import 'dart:convert';
import 'dart:io';


import 'package:ev_booking/constants/urls.dart';

import 'package:ev_booking/modules/single_product/model/product_purchase_response_model.dart';
import 'package:http/http.dart' as http;

Future<ProductPurchaseResponseModel> buyProductService({
  required String user_id,
  required String product_id,
  required int quantity,

}) async {
  try {
    Map<String, dynamic> param = {
     "user":user_id,
      "product": product_id,
      "quantity": quantity,
    };

    final resp = await http.post(
      Uri.parse('https://vqp6fbbv-8001.inc1.devtunnels.ms/user/buy_product/'), 
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (resp.statusCode == 200) {
      /**
       *  final List<dynamic> decoded = jsonDecode(resp.body);
      final response =
          decoded.map((item) => ProductModel.fromJson(item)).toList();
      return response;
       */

      final dynamic decoded = jsonDecode(resp.body);
      final response = ProductPurchaseResponseModel.fromJson(decoded);
          
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