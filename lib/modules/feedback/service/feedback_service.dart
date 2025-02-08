import 'dart:convert';
import 'dart:io';
import 'package:ev_booking/constants/urls.dart';
import 'package:ev_booking/modules/feedback/model/feedback.dart';
import 'package:ev_booking/utils/preference_values.dart';

import 'package:http/http.dart' as http;

Future<FeedbackModel> feedbackService({
  required String feedback,
  required String repair_id,
  required String service_id,
}) async {
  try {
    String user = await PreferenceValues.getUserId();
    Map<String, dynamic> param = {
      "feedback": feedback,
      "user": user,
      "service_centre": service_id,
      "repair": repair_id,
    };

    final resp = await http.post(
      Uri.parse(UserUrl.feedback),
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
