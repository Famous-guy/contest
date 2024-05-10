import 'package:contest_app/src/src.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (index) => TextEditingController());
    _focusNodes = List.generate(6, (index) => FocusNode());
  }

  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _setLoading(bool isLoading) {
    // setState(() {
    //   _isLoading = isLoading;
    // });
    setState(() {
      _isLoading = isLoading;
      if (!isLoading) {
        Future.delayed(Duration(seconds: 3), () {
          nextPage(context,
              page: ChangePasswordScreen(
                otp: _controllers.toString(),
                email: widget.email,
              ));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter 6 digit code',
                      style: PageService.bigHeaderStylesmall,
                    ),
                    PageService.textSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter 6 digits code you received on your email',
                          style: PageService.labelStyle,
                        ),
                        Text(
                          widget.email,
                          style: PageService.labelStylered,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PageService.textSpaceL,
                    SizedBox(
                      height: 48,
                      width: MediaQuery.of(context).size.width,
                      child: OtpTextField(
                        keyboardType: TextInputType.number,
                        numberOfFields: 6,
                        borderColor: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                        borderWidth: 3,
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {
                          if (code.characters == 6) {
                            _setLoading(
                                true); // Display loader when OTP is complete
                          }

                          // Handle validation or checks here
                        },
                        onSubmit: (value) {
                          nextPage(context,
                              page: ChangePasswordScreen(
                                otp: value.toString(),
                                email: widget.email,
                              ));
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('If you didn’t receive the code? '),
                        TextButton(
                          onPressed: () {
                            nextPage(context,
                                page: ChangePasswordScreen(
                                  otp: _controllers.toString(),
                                  email: widget.email,
                                ));
                          },
                          child: Text(
                            'Resend',
                            style: TextStyle(
                              color: Color.fromRGBO(242, 7, 50, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    PageService.textSpaceL,
                    PageService.textSpace,
                    customButton(
                      context,
                      onTap: () async {
                        nextPage(context,
                            page: ChangePasswordScreen(
                              otp: _controllers.toString(),
                              email: widget.email,
                            ));
                        appLog(_controllers.toString());
                      },
                      text: 'Verify Code',
                      textColor: Colors.white,
                      bgColor: Colors.red,
                    ),
                    PageService.textSpaceL,
                    PageService.textSpaceL,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
