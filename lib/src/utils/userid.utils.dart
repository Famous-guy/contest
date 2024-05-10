import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class UserId {
  static Future persistuserId({
    required String id,
  }) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString('_id', id);

    log('Saved id: $id');
  }

  static Future clearUserid() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove('_id');
    log('id Cleared');
  }

  static Future<String?> retrieveUserid() async {
    var pref = await SharedPreferences.getInstance();
    var id = pref.getString('_id');
    log('Retrieve id: $id');
    return id;
  }
}
