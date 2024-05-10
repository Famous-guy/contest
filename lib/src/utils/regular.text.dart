import 'package:blur/blur.dart';
import 'package:contest_app/src/src.dart';

Widget regularText(String text,
    {Color? color,
    double? fontSize = 14,
    double? letterSpacing,
    double? height,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    bool blur = false}) {
  return blur
      ? Blur(
          blur: 3,
          blurColor: Colors.white,
          child: Text(
            text,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
            softWrap: true,
            style: PageService.labelStylered,
          ))
      : Text(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          softWrap: true,
          style: PageService.labelStylered,
        );
}
