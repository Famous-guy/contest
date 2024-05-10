
import 'package:contest_app/src/src.dart';

class PageService {
  static BuildContext? homeContext;
  Size pageSize(BuildContext context) {
    var context = GlobalVariable.navState.currentContext;
    if (context != null) {
      var size = MediaQuery.of(context).size;
      return Size(size.width, size.height);
    }
    return const Size(0, 0);
  }

  void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  static double? headerFontSize = 17;
  static double? textFontSize = 15;
  static SizedBox textSpaceS = const SizedBox(
    height: 5,
    width: 5,
  );
  static SizedBox textSpace = const SizedBox(
    height: 10,
    width: 10,
  );
  static SizedBox textSpaceL = const SizedBox(height: 15, width: 15);
  static SizedBox textSpacexL = const SizedBox(
    height: 16,
    width: 16,
  );
  static SizedBox textSpacexxL = const SizedBox(
    height: 30,
    width: 30,
  );
  static TextStyle bigHeaderStyle = TextStyle(
      fontSize: 28, color: AppColor.gray9, fontFamily: 'SpaceGrotesk');
  static TextStyle bigHeaderStylesmall = TextStyle(
      fontSize: 20,
      color: AppColor.gray8,
      fontFamily: 'SpaceGrotesk',
      fontWeight: FontWeight.w700);
  static TextStyle bigHeaderStylebold = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColor.gray9,
      fontFamily: 'SpaceGrotesk');
  static TextStyle bigHeaderStylebold2 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColor.gray9,
      fontFamily: 'SpaceGrotesk');

  static TextStyle bigHeaderStyle2 = TextStyle(
      fontSize: 15,
      // fontWeight: FontWeight.w700,
      color: AppColor.gray9,
      fontFamily: 'SpaceGrotesk');
  static TextStyle headerStyle = const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: Color(0xff000000),
      fontFamily: 'SpaceGrotesk');

  static TextStyle labelStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.gray8,
      fontFamily: 'SpaceGrotesk');

  static TextStyle labelStyle2 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColor.gray8,
      fontFamily: 'SpaceGrotesk');
  static TextStyle labelStyle500 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColor.gray8,
      fontFamily: 'SpaceGrotesk');
  static TextStyle labelStylered = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.red,
      fontFamily: 'SpaceGrotesk');
  static TextStyle normalLabelStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'SpaceGrotesk',
      color: AppColor.black);
  static TextStyle emailLabelStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.white,
      fontFamily: 'SpaceGrotesk');
  static TextStyle whitelabelStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColor.white,
      fontFamily: 'SF Pro Display');
  static TextStyle textEditStyle =
      const TextStyle(fontSize: 14, fontFamily: 'SF Pro Display');
}
