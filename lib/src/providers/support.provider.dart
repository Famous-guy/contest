// // import 'dart:convert';

// // import 'package:contest_app/export/export.dart';
// // import 'package:contest_app/screens/bottom_nav_pages/home/contestendpoint.dart';
// // import 'package:http/http.dart' as http;

// // class ContestProvider extends ChangeNotifier {
// //   List<Contest> _contests = [];

// //   List<Contest> get contests => _contests;

// //   Future<void> fetchContests() async {
// //     final response = await http.get(Uri.parse(
// //         'https://contest-api.100pay.co/api/v1/contest/upcoming-supported-contests'));
// //     if (response.statusCode == 200) {
// //       final List<dynamic> jsonResponse = json.decode(response.body);
// //       _contests = jsonResponse.map((data) => Contest.fromJson(data)).toList();
// //       notifyListeners();
// //     } else {
// //       throw Exception('Failed to load contests');
// //     }
// //   }
// // }

// import 'package:contest_app/proivders/searchModal.dart';
// import 'package:contest_app/screens/suported/supportmodal.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Supported extends ChangeNotifier {
//   // final Dio _dio = Dio();
//   final dio = Dio();
//   List<Support> _searchResults = [];
//   bool _isLoading = false;

//   List<Support> get searchResults => _searchResults;
//   bool get isLoading => _isLoading;

//   Future<void> support(String productName) async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     String? token = sf.getString("token");
//     try {
//       _isLoading = true;
//       notifyListeners();

//       final dio = Dio();
//       // void search() async {
//       //   final response = await dio.get(
//       //     'https://contest-api.100pay.co/api/v1/contest/search-name',
//       //     // queryParameters: {"productName": 'Fan'},
//       //     data: {"productName": 'F'},
//       //     options: Options(
//       //       headers: {
//       //         // Add your header key-value pairs here
//       //         "Authorization":
//       //             "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWQ0ZjI5NjU0NGNjNTA0MmY1ZTdjNzYiLCJlbWFpbCI6ImhvZ2FuaXp5ODVAZ21haWwuY29tIiwiaWF0IjoxNzExNTI5ODAxLCJleHAiOjE3MjAxNjk4MDF9.GAIiAso_UAmuSkFGxGJMI9P43MAvXkx2HXGLTR-yf9o",
//       //         "Content-Type": "application/json",
//       //       },
//       //     ),
//       //   );
//       //   print(response.data);
//       // }
//       final response = await dio.get(
//         'https://contest-api.100pay.co/api/v1/contest/upcoming-supported-contests',
//         // data: {"productName": productName},
//         options: Options(
//           headers: {
//             "Authorization": "Bearer $token",
//             "Content-Type": "application/json",
//           },
//         ),
//       );

//       final List<dynamic> responseData = response.data;
//       _searchResults =
//           responseData.map((json) => Support.fromJson(json)).toList();
//     } catch (e) {
//       // Handle error
//       print("Error: $e");
//       _searchResults = [];
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }

// import 'package:contest_app/export/export.dart';
import 'package:contest_app/src/models/support.modal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SupportProvider extends ChangeNotifier {
  final Dio dio = Dio();
  List<Support> _supportedContests = [];
  bool _isLoading = false;

  List<Support> get supportedContests => _supportedContests;
  bool get isLoading => _isLoading;

  SupportProvider() {
    fetchSupportedContests(); // Fetch supported contests when the class is initialized
  }

  Future<void> fetchSupportedContests() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    try {
      _isLoading = true;
      // notifyListeners();

      // final response = await dio.get(
      //   'https://contest-api.100pay.co/api/v1/contest/upcoming-supported-contests',
      //   options: Options(
      //     headers: {
      //       "Authorization": "Bearer $token",
      //       // "Content-Type": "application/json",
      //     },
      //   ),
      // );

      http.Response response = await http.get(
          Uri.parse(
              'https://contest-api.100pay.co/api/v1/contest/upcoming-supported-contests'),
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWQ5ZjAzZTExMTNlNDliOTcyOGJlYzgiLCJlbWFpbCI6ImdpZGVvbmdhYnJpZWw1NTdAZ21haWwuY29tIiwiaWF0IjoxNzEyMTU1NzUzLCJleHAiOjE3NDM3MTMzNTN9.fDOI0QSROYTzd25n9SA0dJ0xSDtyVavM964NRfmzchA",
          });

      print(response.body);
      final List<dynamic> responseData = response.bodyBytes;
      _supportedContests =
          responseData.map((json) => Support.fromJson(json)).toList();
    } catch (e) {
      print("Error: $e");
      _supportedContests = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
