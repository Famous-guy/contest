import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Rohash extends ChangeNotifier {
  String _avatarUrl = '';

  String get avatarUrl => _avatarUrl;

  Future<void> fetchAvatar(String username) async {
    final response = await http.get(
        Uri.parse('https://robohash.org/$username.png?size=100x100&set=set1'));
    if (response.statusCode == 200) {
      _avatarUrl = response.body;
      notifyListeners();
    } else {
      throw Exception('Failed to load avatar');
    }
  }
}
