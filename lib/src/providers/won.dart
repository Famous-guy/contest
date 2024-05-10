// import 'package:contest_app/src/models/wonmodal.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ContestProvider with ChangeNotifier {
//   ContestModal? contestData;

//   Future<void> fetchContestData() async {
//     final url =
//         Uri.parse('https://contest-api.100pay.co/api/v1/contest/won-contests');

//     try {
//       final response = await http.get(url, headers: {
//         "Authorization":
//             "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWQ0ZjI5NjU0NGNjNTA0MmY1ZTdjNzYiLCJlbWFpbCI6ImhvZ2FuaXp5ODVAZ21haWwuY29tIiwiaWF0IjoxNzExNTI5ODAxLCJleHAiOjE3MjAxNjk4MDF9.GAIiAso_UAmuSkFGxGJMI9P43MAvXkx2HXGLTR-yf9o",
//       });
//       print(response.body);
//       print(response.statusCode);
//       final extractedData = json.decode(response.body) as Map<String, dynamic>;
//       contestData = ContestModal.fromJson(extractedData);
//       notifyListeners();
//     } catch (error) {
//       throw (error);
//     }
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:contest_app/src/models/wonmodal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContestProvider with ChangeNotifier {
  List<ContestModal> _contests = [];

  List<ContestModal> get contests => [..._contests];
  bool _isLoading = false;
  bool _hasData = false;
  bool _hasError = false;
  bool _isEmpty = false;
  bool get isLoading => _isLoading;
  bool get hasData => _hasData;
  bool get hasError => _hasError;
  bool get isEmpty => _isEmpty;
  Future<void> fetchContestData() async {
    _isLoading = true;
    final url =
        Uri.parse('https://contest-api.100pay.co/api/v1/contest/won-contests');
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    try {
      final response =
          await http.get(url, headers: {"Authorization": "Bearer $token"});
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        _isLoading = false;
        _hasData = true;

        final List<dynamic> responseData = json.decode(response.body);
        final List<ContestModal> loadedContests = [];
        responseData.forEach((contestData) {
          loadedContests.add(ContestModal.fromJson(contestData));
        });
        _contests = loadedContests;
        notifyListeners();
      } else {
        _isLoading = false;
        _hasData = false;
        _isEmpty = true;
        var error = jsonDecode(response.body)['error'];
        notifyListeners();
        throw error;
      }
    } catch (error) {
      _isLoading = false;
      _hasData = false;
      _isEmpty = true;
      notifyListeners();
      throw (error);
    }
  }
}
