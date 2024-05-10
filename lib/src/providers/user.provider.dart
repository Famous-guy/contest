// // import 'dart:convert';
// // import 'package:contest_app/proivders/authentication/userdata.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';

// // class UserService {
// //   static const String _baseUrl =
// //       'https://ecommerce-qfab.onrender.com/api/v1/user/';

// //   static Future<User> fetchUser() async {
// //     SharedPreferences sf = await SharedPreferences.getInstance();
// //     String? token = sf.getString("token");
// //     final response = await http.get(
// //       Uri.parse(_baseUrl),
// //       headers: {'Authorization': 'Bearer $token'},
// //     );
// //     print(response.body);
// //     if (response.statusCode == 200) {
// //       print(response.body);
// //       final jsonData = jsonDecode(response.body);
// //       return User.fromJson(jsonData);
// //     } else {
// //       print(response.body);
// //       throw Exception('Failed to load user data');
// //     }
// //   }
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:contest_app/proivders/authentication/userdata.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class UserService with ChangeNotifier {
//   static const String _baseUrl =
//       'https://ecommerce-qfab.onrender.com/api/v1/user/';

//   User? _user;

//   User? get user => _user;

//   Future<void> fetchUser() async {
//     try {
//       SharedPreferences sf = await SharedPreferences.getInstance();
//       String? token = sf.getString("token");
//       final response = await http.get(
//         Uri.parse(_baseUrl),
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         _user = User.fromJson(jsonData);
//         notifyListeners();
//       } else {
//         throw Exception('Failed to load user data');
//       }
//     } catch (error) {
//       throw Exception('Failed to fetch user data: $error');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _baseUrl =
      'https://ecommerce-qfab.onrender.com/api/v1/user/';

  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', jsonEncode(userData));
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }

  static Future<void> fetchAndSaveUser() async {
    try {
      String? token = await _getAuthToken();
      if (token != null) {
        final response = await http.get(
          Uri.parse(_baseUrl),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          await saveUserData(jsonData);
        } else {
          throw Exception('Failed to load user data');
        }
      } else {
        throw Exception('Authentication token not found');
      }
    } catch (error) {
      throw Exception('Failed to fetch and save user data: $error');
    }
  }

  static Future<String?> _getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}
