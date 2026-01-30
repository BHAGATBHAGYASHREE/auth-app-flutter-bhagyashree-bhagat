import 'package:http/http.dart' as http;
import 'package:auth_app/models/user.dart';
import 'dart:convert';

class UserService {
  static String API_URL = "http://localhost:4000/auth";

  static Future<Map<String, dynamic>> register(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$API_URL/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()),
      );

      // Check if response is successful
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Check if response body is JSON
        if (response.headers['content-type']?.contains('application/json') ??
            false) {
          return jsonDecode(response.body);
        } else {
          return {
            'error': 'Server returned non-JSON response: ${response.body}',
          };
        }
      } else {
        // Parse error response to extract message
        try {
          final errorData = jsonDecode(response.body);
          return {'error': errorData['message'] ?? 'Unknown error occurred'};
        } catch (e) {
          return {'error': 'Server error: ${response.statusCode}'};
        }
      }
    } catch (e) {
      return {'error': 'Failed to connect to server: $e'};
    }
  }

  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$API_URL/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'username': username, 'password': password}),
      );

      // Check if response is successful
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Check if response body is JSON
        if (response.headers['content-type']?.contains('application/json') ??
            false) {
          return jsonDecode(response.body);
        } else {
          return {
            'error': 'Server returned non-JSON response: ${response.body}',
          };
        }
      } else {
        // Parse error response to extract message
        try {
          final errorData = jsonDecode(response.body);
          return {'error': errorData['message'] ?? 'Unknown error occurred'};
        } catch (e) {
          return {'error': 'Server error: ${response.statusCode}'};
        }
      }
    } catch (e) {
      return {'error': 'Failed to connect to server: $e'};
    }
  }
}
