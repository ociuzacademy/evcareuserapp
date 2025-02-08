import 'dart:convert';
import 'dart:io';

import 'package:ev_booking/constants/urls.dart';
import 'package:ev_booking/modules/products/model/productlist.dart';
import 'package:http/http.dart' as http;

Future<List<SingleProductListModel>> productList({
  required String service_centre_id,
}) async {
  try {
    Map<String, dynamic> params = {
      'service_centre': service_centre_id,
    };
    final resp = await http.get(
      Uri.parse(UserUrl.productListUrl)
          .replace(queryParameters: params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    final List<dynamic> decoded = jsonDecode(resp.body);
    if (resp.statusCode == 200) {
      final response =
          decoded.map((item) => SingleProductListModel.fromJson(item)).toList();
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
