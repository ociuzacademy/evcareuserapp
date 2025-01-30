import 'dart:convert';
import 'dart:io';
import 'package:ev_booking/constants/urls.dart';
import 'package:ev_booking/modules/feedback/model/feedback.dart';


import 'package:http/http.dart' as http;

Future<FeedbackModel> feedbackService({
  required String feedback,
  required String  user,
  required String repair_id,
  required String service_id,
}) async {
  try {
  
    Map<String, dynamic> param = {
      "feedback": feedback,
      "user": user,
      "service_centre": service_id,
      "repair": repair_id,
    };

    final resp = await http.post(
      Uri.parse('https://vqp6fbbv-8001.inc1.devtunnels.ms/user/feedback/'), 
      body: jsonEncode(param),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      
    );

    if (resp.statusCode == 200) {
      
      final dynamic decoded = jsonDecode(resp.body);
      final response = FeedbackModel.fromJson(decoded);
          
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