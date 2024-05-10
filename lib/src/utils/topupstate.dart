import 'package:flutter/material.dart';

class Top extends StatefulWidget {
  Top({super.key, required this.counter});
  int counter;

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  int number = 0;
  void increment({required int num1}) {
    setState(() {
      widget.counter++;
      // num1 = number++;
      number++;
      print(num1);
    });
  }

  void decrement({required int num2}) {
    setState(() {
      if (number > 0) {
        // num2 = number--;

        widget.counter--;
        // num1 = number++;
        number--;
        print(num2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      // fit: StackFit.passthrough,
      // mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Positioned(
          // left: 10,
          top: 8,
          child: IconButton(
            onPressed: () {
              increment(
                num1: widget.counter,
              );
              // setState
            },
            icon: ImageIcon(
              AssetImage('assets/images/up.png'),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Positioned(
          // right: 10,
          bottom: 8,
          child: IconButton(
            onPressed: () {
              decrement(
                num2: widget.counter,
              );
            },
            icon: ImageIcon(
              AssetImage('assets/images/down.png'),
            ),
          ),
        ),
      ],
    );
  }
}
