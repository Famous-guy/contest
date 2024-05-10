import 'package:flutter/material.dart' show Color, MaterialColor;
import 'dart:math';

import 'package:contest_app/src/export/export.dart';

const Color primaryColor = Color(0xffF20732);
const Color placeholderBackground = Color.fromRGBO(235, 235, 235, 1.0);

class AppColor {
  static Color primaryColor = Color.fromRGBO(242, 7, 50, 1);
  static Color red = const Color(0xffFF0000);
  static Color gray8 = const Color(0xff5C5C5C);
  static Color gray2 = const Color(0xffD6D6D6);
  static Color moonstone = const Color(0xff0097EC);
  static Color gray1 = const Color(0xffEBEBEB);
  static Color jungleGreen = const Color(0xff15152D);
  static Color gray9 = const Color(0xff474747);
  static Color gray6 = const Color(0xff858585);
  static Color gray4 = const Color(0xffADADAD);
  static Color ghostWhite = const Color(0xffF9FAFB);
  static Color altPrimary = const Color.fromARGB(255, 230, 145, 144);
  static Color quickSilver = const Color(0xff9BA59F);
  static Color cultured = const Color(0xffF5F5F5);
  static Color black = const Color(0xff0A0A0A);
  static Color chineseWhite = const Color(0xffE1E1E1);
  static Color white = const Color(0xffF5F5F5);
  static const Color darkGreen = Color(0xff027A48);
  static const Color btnRed = Color(0xffF23051);

  static Map<int, Color> colorPallete = {
    50: const Color.fromRGBO(27, 93, 47, .1),
    100: const Color.fromRGBO(27, 93, 47, .2),
    200: const Color.fromRGBO(27, 93, 47, .3),
    300: const Color.fromRGBO(27, 93, 47, .4),
    400: const Color.fromRGBO(27, 93, 47, .5),
    500: const Color.fromRGBO(27, 93, 47, .6),
    600: const Color.fromRGBO(27, 93, 47, .7),
    700: const Color.fromRGBO(27, 93, 47, .8),
    800: const Color.fromRGBO(27, 93, 47, .9),
    900: const Color.fromRGBO(27, 93, 47, 1),
  };

  static MaterialColor primaryMaterialColor =
      MaterialColor(0xFF1B5D2F, AppColor.colorPallete);
  static Color transColor = const Color.fromRGBO(0, 0, 0, 0.2);
  static Color grayColor = const Color.fromRGBO(128, 128, 128, 1.0);
  static Color whiteSmokeColor = const Color.fromRGBO(235, 235, 235, 1.0);
  static Color whiteSmokeColor2 = const Color.fromRGBO(235, 235, 235, 0.7);
  static Color separatorColor = const Color.fromRGBO(128, 128, 128, 0.3);

  Color primaryRandColour = randColor();
  static Color randColor() {
    var colourList = [
      primaryColor,
      const Color.fromRGBO(0, 100, 255, 0.4),
      const Color.fromRGBO(0, 104, 132, 1),
      const Color.fromRGBO(0, 144, 158, 1),
      const Color.fromRGBO(234, 0, 52, 1),
      const Color.fromRGBO(250, 157, 0, 1),
      const Color.fromRGBO(145, 39, 143, 1),
      const Color.fromRGBO(87, 62, 126, 1),
      const Color.fromRGBO(255, 130, 42, 1),
      const Color.fromRGBO(102, 136, 90, 1),
      const Color.fromRGBO(27, 93, 47, 1),
      const Color.fromRGBO(192, 108, 132, 1),
      const Color.fromRGBO(246, 114, 128, 1),
      const Color.fromRGBO(248, 177, 149, 1),
      const Color.fromRGBO(116, 180, 155, 1),
    ];
    Random random = Random();
    return colourList[random.nextInt(8)];
  }
}

// var procedure1=Procedure(userid: "userid", recordId: "recordId", patientId: "patientId", centerId: "centerId");
// procedure1.dateCreated=DateTime(2023,10,20,10,29,20);
// procedure1.name="FBC";
// procedure1.avgCost=9000;
// var procedure2=Procedure(userid: "userid", recordId: "recordId", patientId: "patientId", centerId: "centerId");
// procedure2.dateCreated=DateTime(2023,10,20,5,29,20);
// procedure2.avgCost=10000;
// procedure2.name="FBC";
// var procedure3=Procedure(userid: "userid", recordId: "recordId", patientId: "patientId", centerId: "centerId");
// procedure3.dateCreated=DateTime(2023,10,20,5,29,20);
// procedure3.avgCost=5000;
// procedure3.name="FBG";
// var procedure4=Procedure(userid: "userid", recordId: "recordId", patientId: "patientId", centerId: "centerId");
// procedure4.dateCreated=DateTime(2023,10,3,10,29,20);
// procedure4.avgCost=2000;
// procedure4.name="FBG";
// var procedure5=Procedure(userid: "userid", recordId: "recordId", patientId: "patientId", centerId: "centerId");
// procedure5.dateCreated=DateTime(2023,11,20,10,29,20);
// procedure5.avgCost=20000;
// procedure5.name="FBG";
// var procedure6=Procedure(userid: "userid", recordId: "recordId", patientId: "patientId", centerId: "centerId");
// procedure6.dateCreated=DateTime(2023,7,20,10,29,20);
// procedure6.avgCost=20000;
// procedure6.name="Blood Chemistry";
// var procedure7=Procedure(userid: "userid", recordId: "recordId", patientId: "patientId", centerId: "centerId");
// procedure7.avgCost=20000;
// procedure7.name="SEUCR";
// var procedure8=Procedure(userid: "userid", recordId: "recordId", patientId: "patientId", centerId: "centerId");
// procedure8.avgCost=8960;
// procedure8.name="SEMEN";
// var procedure9=Procedure(userid: "userid", recordId: "recordId", patientId: "patientId", centerId: "centerId");
// procedure9.avgCost=9000;
// procedure9.name="TFT";
