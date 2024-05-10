import 'package:contest_app/src/utils/regular.text.dart';
import 'package:flutter/material.dart';

import '../constants/appcolors.dart';


Widget buttonWithBorder(
    String text, {
      Color? buttonColor,
      Color? textColor,
      VoidCallback? onTap,
      Color? borderColor,
      FontWeight? fontWeight,
      double? fontSize,
      double? horiMargin,
      double? borderRadius,
      String? icon,
      double? height,
      double? width,
      bool busy = false,
      bool isActive = true,
    }) {
  return InkWell(
    onTap: isActive ? (busy ? null : onTap) : null,
    // onTap: onTap,
    child: Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: horiMargin ?? 0),
      decoration: BoxDecoration(
          color: isActive ? buttonColor : AppColor.white,
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          border: Border.all(
              width: .7,
              color: isActive
                  ? (borderColor ?? Colors.transparent)
                  : const Color(0xffF6F6F6))),
      child: Center(
          child:
          busy
              ? SizedBox(
            height: 20,
            width: 20,
            child: const CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
              :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              regularText(
                text,
                color: isActive
                    ? textColor
                    : const Color(0xff8E8B8B).withOpacity(.5),
                fontSize: fontSize,
                fontWeight: fontWeight ?? FontWeight.w600,
              ),
              if (icon != null)
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Image.asset(
                    'assets/images/$icon.png',
                    height: 13,
                    width: 13,
                  ),
                ),
            ],
          )),
    ),
  );
}