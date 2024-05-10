import 'dart:convert';

import 'package:contest_app/src/providers/database_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// class TapData {
//   void tapCount(String contestId, String token) async {
//     final http.Response res = await http.get(
//         Uri.parse(
//             'https://ecommerce-qfab.onrender.com/api/v1/contest/get-contest/$contestId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         });

//     if (res.statusCode == 200) {
//       print(res.body);
//       var dataRes = jsonDecode(res.body);

//       SharedPreferences sf = await SharedPreferences.getInstance();
//       sf.setString("tapCount", dataRes["tapCount"]);
//       DatabaseProvider().getToken();
//     } else {}
//   }
// }

Future<Map<String, dynamic>> fetchContestData(String contestId) async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  String? token = sf.getString("token");
  final response = await http.get(
    Uri.parse(
        'https://contest-api.100pay.co/api/v1/contest/get-contest/$contestId'),
    headers: <String, String>{
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body);
  } else {
    throw Exception('${response.body}');
  }
}
