import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard/clipboard.dart'; // Import the clipboard package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('OTP Input Field'),
        ),
        body: Center(
          child: OtpInputField(),
        ),
      ),
    );
  }
}

class OtpInputField extends StatefulWidget {
  @override
  _OtpInputFieldState createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      7,
      (index) => TextEditingController(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(7, (index) {
        if (index == 3) {
          return Text(
            '-',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: _controllers[6].text.isNotEmpty
                  ? Colors.red
                  : Color.fromRGBO(
                      235,
                      235,
                      235,
                      1,
                    ),
            ),
          );
        }
        return Container(
          height: 54,
          width: 40,
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _controllers[6].text.isNotEmpty
                  ? Colors.red
                  : Color.fromRGBO(235, 235, 235, 1),
            ),
          ),
          alignment: Alignment.center,
          child: TextField(
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: _controllers[6].text.isNotEmpty
                  ? Colors.red
                  : Color.fromRGBO(
                      235,
                      235,
                      235,
                      1,
                    ),
            ),
            controller: _controllers[index],
            keyboardType: TextInputType.number,
            // textAlign: TextAlign.center,
            maxLength: 1, // Limit input to one character
            onChanged: (value) {
              if (value.isNotEmpty && index < 6) {
                // Move focus to the next box
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                // Move focus to the previous box when deleting
                FocusScope.of(context).previousFocus();
              }
              setState(() {});
            },
            decoration: InputDecoration(
              // hintStyle: TextStyle(
              //   fontSize: 32,
              //   fontWeight: FontWeight.w600,
              //   color: Color.fromRGBO(
              //     235,
              //     235,
              //     235,
              //     1,
              //   ),
              // ),
              // hintText: '0',
              // contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 8,),
              border: InputBorder.none,
              counterText: '',
            ),
            // Handle pasting
            onTap: () async {
              // Read clipboard data
              // String? clipboardText =
              //     (await Clipboard.getData(Clipboard.kTextPlain))?.text;
              // // Paste clipboard data into the current box
              // if (clipboardText != null &&
              //     clipboardText.isNotEmpty &&
              //     index < 6) {
              //   _controllers[index].text = clipboardText;
              //   // Move focus to the next box
              //   FocusScope.of(context).nextFocus();
              // }
            },
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
