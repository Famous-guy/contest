import 'dart:ui';

import 'package:contest_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
// import 'package:hundredpay/src/hundred_pay_response_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'make_api_call.dart';
import 'pay_ui.dart';

class HundredPay {
  static Future? s;

  static makePayment({
    required String amount,
    required Function(Object? error) onError,
    Map? metadata,
    required BuildContext context, // Change BuildContext? to BuildContext
  }) async {
    // ignore: unnecessary_null_comparison
    if (context == null) {
      // Remove this check as context is required and cannot be null
      throw Exception("Please provide a context");
    }
    // Map metadata0 = {};
    // if (metadata == null) {
    //   metadata0 = {"is_approved": "yes"};
    // } else {
    //   metadata0 = metadata;
    // }
    s = MakeApiCall.makePayment(
        amount: amount,
        context: context); // Pass the valid BuildContext here instead of null
    s!.onError((error, stackTrace) async {
      onError(error);
      throw error!;
    });
    showWebviewModal(
      context: context,
      amount: amount,
    );
  }

  static showWebviewModal({
    required String amount,
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      builder: (BuildContext bc) {
        // ignore: deprecated_member_use
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          height: MediaQuery.of(context).size.height * 0.9,
          child: FutureBuilder(
              future: s,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: BusyOverlay(
                      title: 'Please wait...',
                      show: true,
                      child: Text(""),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  throw snapshot.error!;
                }
                return PayUi(
                  url: snapshot.data,
                );
              }),
        );

        // WillPopScope(
        //   child: Container(
        //     clipBehavior: Clip.hardEdge,
        //     decoration: const BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(20),
        //           topRight: Radius.circular(20),
        //         )),
        //     height: MediaQuery.of(context).size.height * 0.9,
        //     child: FutureBuilder(
        //         future: s,
        //         builder: (context, snapshot) {
        //           if (!snapshot.hasData) {
        //             return const Center(
        //               child: BusyOverlay(
        //                 title: 'Please wait...',
        //                 show: true,
        //                 child: Text(""),
        //               ),
        //             );
        //           }
        //           if (snapshot.hasError) {
        //             throw snapshot.error!;
        //           }
        //           return PayUi(
        //             url: snapshot.data,
        //           );
        //         }),
        //   ),
        //   // onWillPop: () async {
        //   //   bool quit = await showDialog(
        //   //     context: context,
        //   //     builder: (BuildContext context) {
        //   //       return Stack(
        //   //         children: [
        //   //           BackdropFilter(
        //   //             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        //   //             child: Container(
        //   //               color: Colors.black
        //   //                   .withOpacity(0.5), // Adjust opacity as needed
        //   //             ),
        //   //           ),
        //   //           AlertDialog(
        //   //             backgroundColor: Colors.white,
        //   //             title: const Text('Quit Payment'),
        //   //             content: const Text(
        //   //                 'Do you want to quit the payment process?'),
        //   //             actions: [
        //   //               TextButton(
        //   //                 onPressed: () {
        //   //                   Navigator.of(context)
        //   //                       .pop(false); // Stay on the bottom sheet
        //   //                 },
        //   //                 child: const Text('Stay'),
        //   //               ),
        //   //               TextButton(
        //   //                 onPressed: () {
        //   //                   Navigator.of(context)
        //   //                       .pop(true); // Allow dismissing the bottom sheet
        //   //                 },
        //   //                 child: const Text(
        //   //                   'Quit',
        //   //                   style: TextStyle(color: Colors.red),
        //   //                 ),
        //   //               ),
        //   //             ],
        //   //           ),
        //   //         ],
        //   //       );
        //   //     },
        //   //   );
        //   //   return quit;
        //   // },
        // );
      },
    );
  }
}
