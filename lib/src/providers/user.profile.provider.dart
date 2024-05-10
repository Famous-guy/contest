

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserProfileProvider extends ChangeNotifier {
  String? username;

  Future<void> fetchUserProfile() async {
    final url = Uri.parse('https://contest-api.100pay.co/api/v1/user/');
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    try {
      final response = await http.get(url, headers: {
        // "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      });
      if (response.statusCode == 200) {
        print(token);
        print(response.body);
        final data = json.decode(response.body);
        username = data['username'];
        sf.setString('username', username ?? '');
        notifyListeners();
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }
}
