import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

// import 'package:contest_app/src/models/user.data.model.dart';
import 'package:contest_app/src/models/userdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pay100_pos/api/connectpos.dart';
// import 'package:pay100_pos/payos.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider with ChangeNotifier {
  UserData? _userData;

  UserData? get userData => _userData;

  Future<bool> connectPOS(
      {required BuildContext context,
      required String inviteCode,
      required Function() update,
      required String otp}) async {
    try {
      var url = Uri.parse('https://api.100pay.co/api/v1/user/connect-pos');
      var body = {
        "accountId": inviteCode,
        "code": otp,
      };
      var headers = {"Content-Type": "application/json"};
      var res = await http.post(url, body: jsonEncode(body), headers: headers);
      print(res.body);
      if (res.statusCode == 200) {
        print(res.body);
        update();
        var data = jsonDecode(res.body);
        _userData = UserData.fromJson(data);
        // await saveUserDataToPrefs();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // SharedPreferences sf = await SharedPreferences.getInstance();
        // sf.setString("100pay_token", dataRes["token"]);
        prefs.setString('publicKey', _userData!.publicKey);
        prefs.setString('email', _userData!.email);
        prefs.setString('phone', _userData!.phone);
        prefs.setString('accountName', _userData!.accountName);
        prefs.setString('currency', _userData!.currency);
        prefs.setString('accountId', _userData!.accountId);
        prefs.setString('businessId', _userData!.businessId);
        prefs.setString('100pay_token', _userData!.token);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Pay100(),
        //   ),
        // );
        notifyListeners();
        return true; // Connection successful
      } else {
        showDialog(
          context: context,
          barrierDismissible: false, // Prevents dismissing by tapping outside
          builder: (BuildContext context) {
            return Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black
                        .withOpacity(0.5), // Adjust opacity as needed
                  ),
                ),
                AlertDialog(
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'space_grotesk',
                    fontSize: 25,
                  ),
                  contentTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'space_grotesk',
                    fontSize: 16,
                  ),
                  backgroundColor: Colors.white,
                  title: Text(
                    'Error',
                    textAlign: TextAlign.center,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Invalid user id! Do check your 100pay app, or sign in to get one',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              ],
            );
          },
        );
        return false; // Connection failed
      }
    } on SocketException catch (_) {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevents dismissing by tapping outside
        builder: (BuildContext context) {
          return Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color:
                      Colors.black.withOpacity(0.5), // Adjust opacity as needed
                ),
              ),
              AlertDialog(
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'space_grotesk',
                  fontSize: 25,
                ),
                contentTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'space_grotesk',
                  fontSize: 16,
                ),
                backgroundColor: Colors.white,
                title: Text(
                  'Network Unstable',
                  textAlign: TextAlign.center,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Please check your network connection and try again.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            ],
          );
        },
      );
      return false; // Connection failed due to unstable network
    } catch (_) {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevents dismissing by tapping outside
        builder: (BuildContext context) {
          return Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color:
                      Colors.black.withOpacity(0.5), // Adjust opacity as needed
                ),
              ),
              AlertDialog(
                title: Text('Error'),
                content: Text('An error occurred. Please try again later.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            ],
          );
        },
      );
      return false; // Other unknown error
    }
  }

  // Future<void> saveUserDataToPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // SharedPreferences sf = await SharedPreferences.getInstance();
  //   // sf.setString("100pay_token", dataRes["token"]);
  //   prefs.setString('publicKey', _userData!.publicKey);
  //   prefs.setString('email', _userData!.email);
  //   prefs.setString('phone', _userData!.phone);
  //   prefs.setString('accountName', _userData!.accountName);
  //   prefs.setString('currency', _userData!.currency);
  //   prefs.setString('accountId', _userData!.accountId);
  //   prefs.setString('businessId', _userData!.businessId);
  //   prefs.setString('100pay_token', _userData!.token);
  // }
}
