import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/appcolors.dart';


class BusyOverlay extends StatelessWidget {
  final Widget child;
  final String title;
  final bool show;

  const BusyOverlay({
    Key? key,
    required this.child,
    required this.title,
    this.show = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Visibility(
          visible: show,
          child: IgnorePointer(
            ignoring: !show,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                color: Colors.white, // Set opacity to 0.0
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SpinKitSquareCircle(
                      color: AppColor.primaryColor,
                      size: 100.0,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


