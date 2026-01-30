import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

// class UserService {
//   static String API_URL = 'http://localhost:4000/auth';

//   static Future<Map<String, dynamic>> register(User user) async {
//   final response = await http.post(
//     Uri.parse("$API_URL/register"),
//     headers: {"Content-Type": "application/json"},
//     body: jsonEncode(user.toJson()),
//   );

//   return jsonDecode(response.body);
// }


//   static Future<Map<String, dynamic>> login(
//     String username,
//     String password,
// ) async {
//   final response = await http.post(
//     Uri.parse('${API_URL}/login'),
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode({
//       'username': username,
//       'password': password,
//     }),
//   );

//   return jsonDecode(response.body);
// }

// }
class UserService {

  static String API_URL = 'http://localhost:4000/auth';

  static Future<Map<String, dynamic>> register(User user) async {
    final response = await http.post(
      Uri.parse('${API_URL}/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final response = await http.post(
      Uri.parse('${API_URL}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    return jsonDecode(response.body);
  }
}
