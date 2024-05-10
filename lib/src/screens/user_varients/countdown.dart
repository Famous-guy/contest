import 'package:flutter/material.dart';
import 'dart:async';

class CountdownUtil {
  static String getRemainingTime(DateTime targetTime) {
    DateTime now = DateTime.now();
    Duration difference = targetTime.difference(now);

    // if (difference.isNegative) {
    //   // The target time has passed
    //   return 'Contest has already started';
    // } else {
    int days = difference.inDays;
    int hours = difference.inHours.remainder(24);
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);

    if (days > 0) {
      // print('${days}: ${hours}: ${minutes}: ${seconds}');
      return '${days}: ${hours}: ${minutes}: ${seconds}';
    } else if (hours > 0) {
      // print('${hours}: ${minutes}: ${seconds}');
      return '${days}: ${hours}: ${minutes}: ${seconds}';
    } else if (minutes > 0) {
      // print('${minutes}: ${seconds}');
      return '${days}: ${hours}: ${minutes}: ${seconds}';
    } else if (seconds > 0) {
      // print('${seconds}');
      return '${days}: ${hours}: ${minutes}: ${seconds}';
    } else if (seconds <= 0) {
      return '${0}: ${0}: ${0}: ${0}';
    } else {
      return '';
    }
  }
}
// }
