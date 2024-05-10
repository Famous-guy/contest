// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:contest_app/src/src.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'hundred_pay_response_model.dart';
// import 'package:hundredpay/src/hundred_pay_response_model.dart';

class MakeApiCall {
  static Future makePayment({
    required String amount,
    required BuildContext context, // Add context parameter
  }) async {
    SharedPreferences? sf;
    sf = await SharedPreferences.getInstance();
    // var url = urlConstants.baseUrl + urlConstants.fundWallet;
    String? token = sf.getString("token");
    try {
      var headers = {
        'Authorization': 'Bearer ${token}',
        "Content-Type": "application/json"
      };

      var url = Uri.parse(
          "https://contest-api.100pay.co/api/v1/payment/create-payment-charge");
      var response = await http.post(url,
          headers: headers,
          body: jsonEncode({
            "billing": {
              "amount": amount,
            },
          }));
      var respons = json.decode(response.body);
      print(respons);
      print(response.body);
      if (response.statusCode.toString()[0] == "2") {
        print(respons);
        return respons;
        // return HundredPayResponseModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.reasonPhrase!);
      }
    } on SocketException catch (_) {
      // Show dialog for unstable network
      showDialog(
        context: context,
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
                title: const Text('Network Unstable'),
                content: const Text(
                    'Please check your network connection and try again.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          );
        },
      );
      throw Exception(_.toString());
    } catch (e) {
      // Show dialog for other exceptions
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: const Text('Error'),
      //       content: const Text('An error occurred. Please try again later.'),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: const Text('OK'),
      //         ),
      //       ],
      //     );
      //   },
      // );
      throw Exception(e.toString());
    }
  }
}
