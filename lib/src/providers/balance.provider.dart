import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class BalanceProvider extends ChangeNotifier {
  String currency = "";
  num amount = 0;

  Future<void> fetchBalance() async {
    final url = Uri.parse('https://contest-api.100pay.co/api/v1/user/balance');

    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    try {
      final response = await http.get(url, headers: {
        // "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      });
      ;
      if (response.statusCode == 200) {
        print(token);
        print(response.body);
        final data = json.decode(response.body);
        currency = data['currency'];
        amount = data['amount'];
        sf.setDouble('amount', amount.toDouble());
        sf.setString('currency', currency);
        notifyListeners();
      } else {
        throw Exception('Failed to load balance');
      }
    } catch (error) {
      print('Error1: $error');
      throw error;
    }
  }
}
