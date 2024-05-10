import 'package:contest_app/export/export.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dio/dio.dart';

// Future<void> ProductSearch() async {
// //   final dio = Dio();
// //   final url = "https://ecommerce-qfab.onrender.com/api/v1/contest/search-name";
// //
// //   final body = {"productName": "shar"};
// //   Response res = await dio.get(
// //
// //   );
// //
// //
// //
// //   dio.request<dynamic>(
// //       "https://ecommerce-qfab.onrender.com/api/v1/contest/search-name",
// //       queryParameters: <String,dynamic>{
// //         'cn': 'iPhone_11', 'qt': '20', 'ct': 'Delhi'},
// //       options: Options(method: "GET"));
// // }
//
//   final dio = Dio();
//
//   dio.options.headers['Content-Type'] = 'application/json';
//   dio.options.headers["Authorization"] =
//       "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWQ0ZjI5NjU0NGNjNTA0MmY1ZTdjNzYiLCJlbWFpbCI6ImhvZ2FuaXp5ODVAZ21haWwuY29tIiwiaWF0IjoxNzExNTI5ODAxLCJleHAiOjE3MjAxNjk4MDF9.GAIiAso_UAmuSkFGxGJMI9P43MAvXkx2HXGLTR-yf9o";
//
//   final response = await dio.get(
//       'https://ecommerce-qfab.onrender.com/api/v1/contest/search-name',
//       queryParameters: {
//         'productName': 'shar',
//       });
//
//   print(response.);
// }

Future<void> SupportedContest() async {
  final url = "https://ecommerce-qfab.onrender.com/api/v1/contest/leadersboard";
  // body = {}
  final http.Response res = await http.get(Uri.parse(url), headers: {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjAzZjM1YTVmY2RjNDcwMjJiZmRiNzAiLCJlbWFpbCI6Imhpc3JlYWwxMzdAdW5pcG9ydC5lZHUubmciLCJpYXQiOjE3MTE1MzY1MTksImV4cCI6MTcyMDE3NjUxOX0.F74HU2NaOZFgZl_lvyurtwkkJ0fYaNymAtFeWhFdqPY'
  });

  print(res.statusCode);
  print(res.body);
}

class UserDetails {
  UserDetails(
      {required this.password,
      required this.id,
      required this.email,
      required this.fullName,
      required this.createdAt,
      required this.updatedAt,
      required this.v,
      required this.isAdmin,
      required this.amount,
      required this.currency,
      required this.username,
      required this.profilePhoto,
      required this.country,
      required this.count});

  final String fullName;
  final String email;
  final int id;
  final String password;
  final int createdAt;
  final int updatedAt;
  final int v;
  final bool isAdmin;
  final int amount;
  final String currency;
  final String username;
  final Image profilePhoto;
  final String country;
  final int count;

  // factory UserDetails.onJson(Map<String, dynamic> json) {
  //   password:
  //   json[''];
  // }
}
//
// class UserDetails (){
//   UserDetails({ required this._id, required this.email, required this.fullName,required this.createdAt,
// required this.updatedAt,required this.__v,required this.isAdmin,required this.amount,
// required this.currency,required this.username,required this.profilePhoto,required this.country,required this.count})
//
//
//  int _id;
// String fullName;
// String email;
// String password;
// int createdAt
// int updatedAt
//  int __v;
// bool isAdmin;
// int amount;
// String currency;
// String username;
//
// Image profilePhoto;
// Sting country;
// int count;
// }
