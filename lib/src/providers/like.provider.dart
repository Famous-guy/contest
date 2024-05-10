import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LikeProvider with ChangeNotifier {
  bool _isLiked = false;
  int _likeCount = 0;

  bool get isLiked => _isLiked;
  int get likeCount => _likeCount;

  void updateLikeStatus(bool isLiked) {
    _isLiked = isLiked;
    notifyListeners();
  }

  Future<void> likeContest(
    String contestId,
  ) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    _isLiked = false;
    try {
      final response = await http.post(
        Uri.parse('https://contest-api.100pay.co/api/v1/contest/like-contest'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: '{"contestId": "$contestId"}',
      );

      if (response.statusCode == 200) {
        // Check if response body is a number (like count)
        final responseData = response.body;
        if (responseData is String && int.tryParse(responseData) != null) {
          print('like $responseData');
          _likeCount = int.parse(responseData);
          _isLiked = true;
          notifyListeners();
        } else {
          _isLiked = false;
          print('Unexpected response body: $responseData');
          throw Exception('Unexpected response format');
        }
      } else {
        _isLiked = false;
        throw Exception('Failed to like contest');
      }
    } catch (error) {
      _isLiked = false;
      print('Error liking contest: $error');
      throw error;
    }
  }

  // Future<void> likeContest(String contestId) async {
  //   SharedPreferences sf = await SharedPreferences.getInstance();
  //   String? token = sf.getString("token");
  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://contest-api.100pay.co/api/v1/contest/like-contest'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //       body: '{"contestId": "$contestId"}',
  //     );
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       // Parse the response and update like count
  //       final responseData = json.decode(response.body);
  //       if (responseData is Map<String, dynamic> &&
  //           responseData.containsKey('likeCount')) {
  //         _likeCount = responseData['likeCount'];
  //         _isLiked = true;
  //         notifyListeners();
  //       } else {
  //         throw Exception('Unexpected response format');
  //       }
  //     } else {
  //       throw Exception('Failed to like contest');
  //     }
  //   } catch (error) {
  //     print('Error liking contest: $error');
  //     throw error;
  //   }
  // }

  // Future<void> likeContest(String contestId) async {
  // SharedPreferences sf = await SharedPreferences.getInstance();
  // String? token = sf.getString("token");
  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://contest-api.100pay.co/api/v1/contest/like-contest'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //       body: '{"contestId": "$contestId"}',
  //     );

  //     if (response.statusCode == 200) {
  //       // Parse the response and update like count
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       _likeCount = responseData['likeCount'];
  //       _isLiked = true;
  //       notifyListeners();
  //     } else {
  //       throw Exception('Failed to like contest');
  //     }
  //   } catch (error) {
  //     print('Error liking contest: $error');
  //     throw error;
  //   }
  // }

  Future<void> dislikeContest(String contestId) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    try {
      final response = await http.delete(
        Uri.parse(
            'https://contest-api.100pay.co/api/v1/contest/like-contest/$contestId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response and update like count
        final Map<String, dynamic> responseData = json.decode(response.body);
        _likeCount = responseData['likeCount'];
        _isLiked = false;
        notifyListeners();
      } else {
        throw Exception('Failed to dislike contest');
      }
    } catch (error) {
      print('Error disliking contest: $error');
      throw error;
    }
  }
}
