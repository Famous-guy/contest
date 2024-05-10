import 'dart:convert';

import 'package:contest_app/src/providers/database_provider.dart';
import 'package:contest_app/src/utils/app.log.dart';
import 'package:contest_app/src/providers/database_provider.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class Profile1Provider with ChangeNotifier {
  String? _fullName;
  double? _balance;
  String? _email;
  String? _country;
  String? _username;

  String? get fullName => _fullName;
  double? get balance => _balance;
  String? get email => _email;
  String? get country => _country;
  String? get username => _username;

  Future<void> fetchUserProfile(String userToken) async {
    final String userToken = await DatabaseProvider().getToken();

    try {
      // Make HTTP GET request to fetch user profile data
      final response = await http.get(
        Uri.parse('https://contest-api.100pay.co/api/v1/user/'),
        headers: {
          'Authorization': 'Bearer $userToken', // Include user token in headers
        },
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> userData = json.decode(response.body);

        // Update instance variables with user information
        _fullName = userData['fullName'];
        _balance = userData['balance']['amount'].toDouble();
        _email = userData['email'];
        _country = userData['country'];
        _username = userData['username'];

        // Save balance using DatabaseProvider (if needed)
        DatabaseProvider().saveBalance(balance: _balance!);

        // Notify listeners that data has changed
        notifyListeners();
      } else {
        throw Exception('Failed to fetch user profile: ${response.statusCode}');
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _fullName = prefs.getString('fullName');
      _balance = prefs.getDouble('balance');
      DatabaseProvider().saveBalance(balance: balance!.toDouble());
      DatabaseProvider().saveFirstName(name: fullName);

      notifyListeners();
    } catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }
}
