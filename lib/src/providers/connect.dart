// // // import 'dart:async';
// // // import 'dart:convert';
// // // import 'dart:io';
// // // import 'dart:ui';

// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:pay100_pos/api/connectpos.dart';
// // // import 'package:pay100_pos/payos.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';

// // // class UserDataProvider with ChangeNotifier {
// // //   UserData? _userData;

// // //   UserData? get userData => _userData;

// // //   Future<bool> connectPOS(BuildContext context, String inviteCode) async {
// // //     try {
// // //       var url = Uri.parse('https://api.100pay.co/api/v1/send-pos-otp');
// // //       var body = {"accountId": inviteCode};
// // //       var headers = {"Content-Type": "application/json"};
// // //       var res = await http.post(url, body: jsonEncode(body), headers: headers);

// // //       if (res.statusCode == 200) {
// // //         var data = jsonDecode(res.body);
// // //         _userData = UserData.fromJson(data);
// // //         await saveUserDataToPrefs();
// // //         Navigator.pushReplacement(
// // //           context,
// // //           MaterialPageRoute(
// // //             builder: (context) => Pay100(),
// // //           ),
// // //         );
// // //         notifyListeners();
// // //         return true; // Connection successful
// // //       } else {
// // //         showDialog(
// // //           context: context,
// // //           barrierDismissible: false, // Prevents dismissing by tapping outside
// // //           builder: (BuildContext context) {
// // //             return Stack(
// // //               children: [
// // //                 BackdropFilter(
// // //                   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// // //                   child: Container(
// // //                     color: Colors.black
// // //                         .withOpacity(0.5), // Adjust opacity as needed
// // //                   ),
// // //                 ),
// // //                 AlertDialog(
// // //                   elevation: 0,
// // //                   titleTextStyle: TextStyle(
// // //                     color: Colors.black,
// // //                     fontWeight: FontWeight.bold,
// // //                     fontFamily: 'space_grotesk',
// // //                     fontSize: 25,
// // //                   ),
// // //                   contentTextStyle: TextStyle(
// // //                     color: Colors.black,
// // //                     fontWeight: FontWeight.w400,
// // //                     fontFamily: 'space_grotesk',
// // //                     fontSize: 16,
// // //                   ),
// // //                   backgroundColor: Colors.white,
// // //                   title: Text(
// // //                     'Error',
// // //                     textAlign: TextAlign.center,
// // //                   ),
// // //                   content: Column(
// // //                     mainAxisSize: MainAxisSize.min,
// // //                     children: [
// // //                       Text(
// // //                         'Invalid user id! Do check your 100pay app, or sign in to get one',
// // //                         textAlign: TextAlign.center,
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   actions: <Widget>[
// // //                     TextButton(
// // //                       onPressed: () {
// // //                         Navigator.of(context).pop();
// // //                       },
// // //                       child: Text('OK'),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ],
// // //             );
// // //           },
// // //         );
// // //         return false; // Connection failed
// // //       }
// // //     } on SocketException catch (_) {
// // //       showDialog(
// // //         context: context,
// // //         barrierDismissible: false, // Prevents dismissing by tapping outside
// // //         builder: (BuildContext context) {
// // //           return Stack(
// // //             children: [
// // //               BackdropFilter(
// // //                 filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// // //                 child: Container(
// // //                   color:
// // //                       Colors.black.withOpacity(0.5), // Adjust opacity as needed
// // //                 ),
// // //               ),
// // //               AlertDialog(
// // //                 elevation: 0,
// // //                 titleTextStyle: TextStyle(
// // //                   color: Colors.black,
// // //                   fontWeight: FontWeight.bold,
// // //                   fontFamily: 'space_grotesk',
// // //                   fontSize: 25,
// // //                 ),
// // //                 contentTextStyle: TextStyle(
// // //                   color: Colors.black,
// // //                   fontWeight: FontWeight.w400,
// // //                   fontFamily: 'space_grotesk',
// // //                   fontSize: 16,
// // //                 ),
// // //                 backgroundColor: Colors.white,
// // //                 title: Text(
// // //                   'Network Unstable',
// // //                   textAlign: TextAlign.center,
// // //                 ),
// // //                 content: Column(
// // //                   mainAxisSize: MainAxisSize.min,
// // //                   children: [
// // //                     Text(
// // //                       'Please check your network connection and try again.',
// // //                       textAlign: TextAlign.center,
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 actions: <Widget>[
// // //                   TextButton(
// // //                     onPressed: () {
// // //                       Navigator.of(context).pop();
// // //                     },
// // //                     child: Text('OK'),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ],
// // //           );
// // //         },
// // //       );
// // //       return false; // Connection failed due to unstable network
// // //     } catch (_) {
// // //       showDialog(
// // //         context: context,
// // //         barrierDismissible: false, // Prevents dismissing by tapping outside
// // //         builder: (BuildContext context) {
// // //           return Stack(
// // //             children: [
// // //               BackdropFilter(
// // //                 filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// // //                 child: Container(
// // //                   color:
// // //                       Colors.black.withOpacity(0.5), // Adjust opacity as needed
// // //                 ),
// // //               ),
// // //               AlertDialog(
// // //                 title: Text('Error'),
// // //                 content: Text('An error occurred. Please try again later.'),
// // //                 actions: [
// // //                   TextButton(
// // //                     onPressed: () {
// // //                       Navigator.of(context).pop();
// // //                     },
// // //                     child: Text('OK'),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ],
// // //           );
// // //         },
// // //       );
// // //       return false; // Other unknown error
// // //     }
// // //   }

// // //   Future<void> saveUserDataToPrefs() async {
// // //     SharedPreferences prefs = await SharedPreferences.getInstance();

// // //     await prefs.setString('accountId', _userData!.accountId);
// // //   }
// // // }

// // import 'dart:async';
// // import 'dart:convert';
// // import 'dart:io';
// // import 'dart:ui';

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:pay100_pos/api/connectpos.dart';
// // import 'package:pay100_pos/onboarding_screen/otp.dart';
// // import 'package:pay100_pos/payos.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class SendPOS with ChangeNotifier {
// //   UserData? _userData;

// //   UserData? get userData => _userData;

// //   Future<bool> seendPOS(BuildContext context, String inviteCode) async {
// //     try {
// //       var url = Uri.parse('https://api.100pay.co/api/v1/send-pos-otp');
// //       var body = {"accountId": inviteCode};
// //       var headers = {"Content-Type": "application/json"};
// //       var res = await http.post(url, body: jsonEncode(body), headers: headers);
// //       print('Response body: ${res.body}');
// //       if (res.statusCode == 200) {
// //         var data = jsonDecode(res.body);
// //         // _userData = UserData.fromJson(data);
// //         // await saveUserDataToPrefs();
// //         // await saveInviteCodeToPrefs(inviteCode);
// //         await saveInviteCodeToPrefs(inviteCode); // Save inviteCode to prefs
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => OTPScreen(),
// //           ),
// //         );
// //         notifyListeners();
// //         return true; // Connection successful
// //       } else {
// //         showDialog(
// //           context: context,
// //           barrierDismissible: false, // Prevents dismissing by tapping outside
// //           builder: (BuildContext context) {
// //             return Stack(
// //               children: [
// //                 BackdropFilter(
// //                   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// //                   child: Container(
// //                     color: Colors.black
// //                         .withOpacity(0.5), // Adjust opacity as needed
// //                   ),
// //                 ),
// //                 AlertDialog(
// //                   elevation: 0,
// //                   titleTextStyle: TextStyle(
// //                     color: Colors.black,
// //                     fontWeight: FontWeight.bold,
// //                     fontFamily: 'space_grotesk',
// //                     fontSize: 25,
// //                   ),
// //                   contentTextStyle: TextStyle(
// //                     color: Colors.black,
// //                     fontWeight: FontWeight.w400,
// //                     fontFamily: 'space_grotesk',
// //                     fontSize: 16,
// //                   ),
// //                   backgroundColor: Colors.white,
// //                   title: Text(
// //                     'Error',
// //                     textAlign: TextAlign.center,
// //                   ),
// //                   content: Column(
// //                     mainAxisSize: MainAxisSize.min,
// //                     children: [
// //                       Text(
// //                         'Invalid user id! Do check your 100pay app, or sign in to get one',
// //                         textAlign: TextAlign.center,
// //                       ),
// //                     ],
// //                   ),
// //                   actions: <Widget>[
// //                     TextButton(
// //                       onPressed: () {
// //                         Navigator.of(context).pop();
// //                       },
// //                       child: Text('OK'),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             );
// //           },
// //         );
// //         return false; // Connection failed
// //       }
// //     } on SocketException catch (_) {
// //       showDialog(
// //         context: context,
// //         barrierDismissible: false, // Prevents dismissing by tapping outside
// //         builder: (BuildContext context) {
// //           return Stack(
// //             children: [
// //               BackdropFilter(
// //                 filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// //                 child: Container(
// //                   color:
// //                       Colors.black.withOpacity(0.5), // Adjust opacity as needed
// //                 ),
// //               ),
// //               AlertDialog(
// //                 elevation: 0,
// //                 titleTextStyle: TextStyle(
// //                   color: Colors.black,
// //                   fontWeight: FontWeight.bold,
// //                   fontFamily: 'space_grotesk',
// //                   fontSize: 25,
// //                 ),
// //                 contentTextStyle: TextStyle(
// //                   color: Colors.black,
// //                   fontWeight: FontWeight.w400,
// //                   fontFamily: 'space_grotesk',
// //                   fontSize: 16,
// //                 ),
// //                 backgroundColor: Colors.white,
// //                 title: Text(
// //                   'Network Unstable',
// //                   textAlign: TextAlign.center,
// //                 ),
// //                 content: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     Text(
// //                       'Please check your network connection and try again.',
// //                       textAlign: TextAlign.center,
// //                     ),
// //                   ],
// //                 ),
// //                 actions: <Widget>[
// //                   TextButton(
// //                     onPressed: () {
// //                       Navigator.of(context).pop();
// //                     },
// //                     child: Text('OK'),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           );
// //         },
// //       );
// //       return false; // Connection failed due to unstable network
// //     } catch (_) {
// //       showDialog(
// //         context: context,
// //         barrierDismissible: false, // Prevents dismissing by tapping outside
// //         builder: (BuildContext context) {
// //           return Stack(
// //             children: [
// //               BackdropFilter(
// //                 filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
// //                 child: Container(
// //                   color:
// //                       Colors.black.withOpacity(0.5), // Adjust opacity as needed
// //                 ),
// //               ),
// //               AlertDialog(
// //                 title: Text('Error'),
// //                 content: Text('An error occurred. Please try again later.'),
// //                 actions: [
// //                   TextButton(
// //                     onPressed: () {
// //                       Navigator.of(context).pop();
// //                     },
// //                     child: Text('OK'),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           );
// //         },
// //       );
// //       return false; // Other unknown error
// //     }
// //   }

// //   Future<void> saveUserDataToPrefs() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('accountId', _userData!.accountId);
// //   }

// //   Future<void> saveInviteCodeToPrefs(String inviteCode) async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('inviteCode', inviteCode);
// //   }
// // }

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pay100_pos/onboarding_screen/otp.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SendPos with ChangeNotifier {
//   Future<void> sendPos(BuildContext context, String accountId) async {
//     try {
//       var url = Uri.parse('https://api.100pay.co/api/v1/send-pos-otp');
//       var body = {"accountId": accountId};
//       var headers = {"Content-Type": "application/json"};

//       var response =
//           await http.post(url, body: jsonEncode(body), headers: headers);

//       if (response.statusCode == 200) {
//         var responseData = jsonDecode(response.body);
//         String message = responseData['message'];

//         // Show toast message
//         Fluttertoast.showToast(
//           msg: message,
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.CENTER,
//         );

//         // Save account ID to shared preferences
//         await saveAccountIdToPrefs(accountId);

//         // Navigate to the next screen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OTPScreen(),
//           ),
//         );
//       } else {
//         // Handle other status codes
//         throw Exception(
//             'Failed to send OTP. Status code: ${response.statusCode}');
//       }
//     } on SocketException catch (_) {
//       // Handle socket exception
//       print('Network error: Please check your internet connection.');
//     } catch (e) {
//       // Handle other exceptions
//       print('Error: $e');
//     }
//   }

//   Future<void> saveAccountIdToPrefs(String accountId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('accountId', accountId);
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:pay100_pos/onboarding_screen/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendPos with ChangeNotifier {
  bool _isLoading = false;
  bool _hasData = false;
  bool _hasError = false;
  bool _isEmpty = false;
  bool get isLoading => _isLoading;
  bool get hasData => _hasData;
  bool get hasError => _hasError;
  bool get isEmpty => _isEmpty;
  Future<bool> sendPos(
    BuildContext context,
    String accountId,
    Function() update,
  ) async {
    try {
      var url = Uri.parse('https://api.100pay.co/api/v1/send-pos-otp');
      var body = {"accountId": accountId};
      var headers = {"Content-Type": "application/json"};
      _isLoading = true;
      print(_isLoading);
      print(_hasData);
      var response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        _isLoading = false;

        _hasData = true;
        print(_isLoading);
        print(_hasData);
        var responseData = response.body;
        print(response.body);
        await saveAccountIdToPrefs(accountId);
        update();
        // Check if the response contains the expected message
        // if (responseData.contains(
        //     'Your account verification code has been sent to your email.')) {
        //   // Show toast message
        //   Fluttertoast.showToast(
        //     msg: responseData,
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.SNACKBAR,
        //   );

        //   // Save account ID to shared preferences
        //   await saveAccountIdToPrefs(accountId);
        //   update();
        //   // navigateToOTPScreen(context, accountId);
        //   // Navigate to the next screen
        //   // Navigator.pushReplacement(
        //   //   context,
        //   //   MaterialPageRoute(
        //   //     builder: (context) => OTPScreen(),
        //   //   ),
        //   // );
        // } else {
        //   // Handle unexpected response
        //   throw Exception('Unexpected response: $responseData');
        // }
        return false;
      } else {
        _isLoading = false;
        _hasError = true;
        _hasData = false;
        print(_isLoading);
        print(_hasData);
        print(_hasError);
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
      // else {
      //   // Handle other status codes
      //   throw Exception(
      //       'Failed to send OTP. Status code: ${response.statusCode}');
      // }
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
      return false;
      // return false; // Connection failed due to unstable network
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

    // on SocketException catch (_) {
    //   // Handle socket exception
    //   print('Network error: Please check your internet connection.');
    // } catch (e) {
    //   // Handle other exceptions
    //   print('Error: $e');
    // }
  }

  // void navigateToOTPScreen(BuildContext context, String accountId) {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => OTPScreen(accountid: accountId),
  //     ),
  //   );
  // }

  Future<void> saveAccountIdToPrefs(String accountId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accountId', accountId);
  }
}
