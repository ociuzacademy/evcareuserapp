// import 'dart:convert';
// import 'dart:io';
// import 'package:ev_booking/modules/signup/model/userregi_model.dart';
// import 'package:http/http.dart' as http;

// //import 'package:ev_booikng/lib/constants/urls.dart';


// //import model ,urls


// Future<UserRegisterModel> UserRegList() async {
//   try {
//     final resp = await http.get(
//       Uri.parse(userRegUrl.UserRegList),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=utf-8',
//       },
//     );
//     final Map<String, dynamic> decoded = jsonDecode(resp.body);
//     if (resp.statusCode == 201) {
//       final response = UserRegisterModel.fromJson(decoded);
//       return response;
//     } else {
//       throw Exception('Failed to load response');
//     }
//   } on SocketException {
//     throw Exception('Server error');
//   } on HttpException {
//     throw Exception('Something went wrong');
//   } on FormatException {
//     throw Exception('Bad request');
//   } catch (e) {
//     throw Exception(e.toString());
//   }
// }