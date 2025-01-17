import 'dart:convert';
import 'dart:io';


import 'package:ev_booking/constants/urls.dart';
import 'package:ev_booking/modules/login/model/login_response_model.da';
import 'package:http/http.dart' as http;

Future<LoginResponseModel> UserLogin({
  required String username,
  required String password,
}) async {
  try {
    Map<String, dynamic> param = {
      "username": username,
      "password": password,
    };

    final resp = await http.post(
      Uri.parse('https://vqp6fbbv-8001.inc1.devtunnels.ms/user/login/'), 
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
      final response = LoginResponseModel.fromJson(decoded);
          
      return response;
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(resp.body);
      throw Exception(
        'Failed to login: ${errorResponse['message'] ?? 'Unknown error'}',
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