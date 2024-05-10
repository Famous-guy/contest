import 'package:flutter/material.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final Function onResume;
  final Function onPause;

  LifecycleEventHandler({required this.onResume, required this.onPause});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResume();
        break;
      case AppLifecycleState.paused:
        onPause();
        break;
      default:
        break;
    }
  }
}
