import 'package:flutter/cupertino.dart';

var navKey = GlobalKey<NavigatorState>();
///Navigator to the next page
Future nextPage(BuildContext context, {Widget? page}) {
  return Navigator.pushReplacement(
      context, CupertinoPageRoute(builder: (context) => page!));
}

Future nextPage1(BuildContext context, {Widget? page}) {
  return Navigator.push(
      context, CupertinoPageRoute(builder: (context) => page!));
}

Future nextPageAndRemovePrevious(BuildContext context, {Widget? page}) async {
  await Navigator.pushAndRemoveUntil(
      context, CupertinoPageRoute(builder: (_) => page!), (route) => false);
}

void nextPageOnly(BuildContext context, {Widget? page}) {
  Navigator.pushAndRemoveUntil(context,
      CupertinoPageRoute(builder: (context) => page!), (route) => false);
}

void popout(BuildContext context, {Widget? page}) {
  Navigator.pop(
    context,
  );
}
