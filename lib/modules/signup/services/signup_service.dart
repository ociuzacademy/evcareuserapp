import 'dart:convert';
import 'dart:io';

import 'package:ev_booking/constants/urls.dart';
import 'package:http/http.dart' as http;

Future<String> UserRegistration({
  required String name,
  required String username,
  required String email,
  required String password,
  required String phone,
}) async {
  try {
    Map<String, dynamic> param = {
      "name": name,
      "username": username,
      "email": email,
      "password": password,
      "phone": phone,
    };

    final response = await http.post(
      Uri.parse(UserUrl.userRegUrl),
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      return "Registration successful";
    } else {
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
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
