import 'package:another_flushbar/flushbar.dart';
import 'package:contest_app/src/utils/regular.text.dart';
import 'package:flutter/material.dart';

import '../constants/appcolors.dart';

void success(
  BuildContext context, {
  required String message,
}) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    icon: Icon(
      Icons.done,
      size: 28.0,
      color: AppColor.primaryColor,
    ),
    duration: const Duration(seconds: 5),
    leftBarIndicatorColor: AppColor.primaryColor,
  ).show(context);
}

void error(BuildContext context, {required String message}) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    icon: Icon(
      Icons.error,
      size: 28.0,
      color: AppColor.red,
    ),
    duration: const Duration(seconds: 5),
    leftBarIndicatorColor: AppColor.red,
  ).show(context);
}

void errorSnackBar(BuildContext context, String title) {
  final Flushbar<void> flushBar = Flushbar<void>(
    title: title,
    titleText: Row(
      children: [
        Icon(
          Icons.error_outline_rounded,
          color: AppColor.btnRed,
          size: 22,
        ),
        const Spacer(),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.close,
            size: 20,
            color: AppColor.btnRed,
          ),
        )
      ],
    ),
    messageText: regularText(
      title,
      fontSize: 15,
      color: AppColor.btnRed,
      fontWeight: FontWeight.w600,
    ),
    borderRadius: BorderRadius.circular(8),
    margin: EdgeInsets.all(16),
    borderColor: AppColor.btnRed,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    duration: const Duration(seconds: 2),
    backgroundColor: const Color(0xFFE3CDC6),
  );

  if (!flushBar.isShowing()) {
    flushBar.show(context);
  }
}

successSnackBar(BuildContext context, String title) {
  final Flushbar<void> flushBar = Flushbar<void>(
    title: title,
    titleText: Row(
      children: [
        Image.asset(
          'assets/images/check-circle.png',
          width: 20,
          height: 20,
        ),
        const Spacer(),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.close,
            size: 20,
            color: AppColor.darkGreen,
          ),
        )
      ],
    ),
    messageText: regularText(
      title,
      fontSize: 15,
      color: AppColor.darkGreen,
      fontWeight: FontWeight.w600,
    ),
    borderRadius: BorderRadius.circular(8),
    margin: EdgeInsets.all(16),
    borderColor: AppColor.darkGreen,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    duration: const Duration(seconds: 4),
    backgroundColor: const Color(0xffF6FEF9),
  );

  if (!flushBar.isShowing()) {
    flushBar.show(context);
  }
}
