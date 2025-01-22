import 'dart:convert';
import 'dart:io';



import 'package:ev_booking/modules/user_profile/model/user_profile_model.dart';
import 'package:http/http.dart' as http;

Future<List<UserProfileModel>> userProfileService(
  {
    required String user_id,
  }
  
) async {
  try {
     Map<String, dynamic> params = {
      'userid': user_id,
     };
    final resp = await http.get(
      Uri.parse('https://vqp6fbbv-8001.inc1.devtunnels.ms/user/user_view_profile/').replace(queryParameters: params),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    final List<dynamic> decoded = jsonDecode(resp.body);
    if (resp.statusCode == 200) {
      final response = decoded.map((item) => UserProfileModel.fromJson(item)).toList();
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