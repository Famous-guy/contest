import 'dart:developer';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenUtil {
  static Future persistToken({
    required String token,
    required String refresh,
  }) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
    await pref.setString('refresh', refresh);
    log('Saved token: $token');
  }

  static Future clearToken() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    log('Token Cleared');
  }

  static Future<String?> retrieveToken() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    log('Retrieve token: $token');
    return token;
  }

  static Future<bool?> checkToken() async {
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    log('Check token: $token');
    if (token == null) {
      return true;
    }
    try {
      return JwtDecoder.isExpired(token);
    } on Exception catch (_) {
      return true;
    }
  }
}
