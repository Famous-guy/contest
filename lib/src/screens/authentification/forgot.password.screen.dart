import 'dart:ui';

import 'package:contest_app/src/src.dart';



class ForgottenPasswordScreen extends StatefulWidget {
  // final String otp;

  const ForgottenPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgottenPasswordScreen> createState() =>
      _ForgottenPasswordScreenState();
}

class _ForgottenPasswordScreenState extends State<ForgottenPasswordScreen> {
  final TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool isInputFocused = false;

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(builder: (context, auth, child) {
      if (auth.isLoading == true) {
        return const BusyOverlay(
          title: 'Requesting Otp',
          show: true,
          child: Text(""),
        );
      } else {
        return SafeArea(
          child: Scaffold(
            // appBar: AppBar(
            //   leading: BackButton(),
            // ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isInputFocused = false;
                  });
                },
                child: Form(
                  key: _formKey,
                  child: Stack(
                    children: [
                      CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Forgot password',
                                    style: PageService.bigHeaderStyle,
                                  ),
                                  PageService.textSpace,
                                  Text(
                                    'Reset your Contest account password',
                                    style: PageService.labelStyle,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  PageService.textSpaceL,
                                  TextFormField(
                                    // onChanged: _validateEmail,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field is required';
                                      } else if (!isEmail(value)) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                    controller: _email,
                                    decoration: InputDecoration(
                                      // errorText:
                                      //     _isEmailValid ? null : 'Invalid email format',
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Color(0xff9E9E9E),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: AppColor.gray2, width: 2),
                                      ),
                                      filled: true,
                                      isDense: true,
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.gray4),
                                      contentPadding: const EdgeInsets.only(
                                          top: 15, bottom: 10, left: 10),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: AppColor.gray2, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: AppColor.gray2, width: 2),
                                      ),
                                    ),
                                  ),
                                  PageService.textSpacexL,
                                  customButton(context, onTap: () async {
                                    if (_email.text.isEmpty) {
                                      errorSnackBar(
                                          context, "All field are required");
                                    } else if (!FlutterUtilities()
                                        .isEmailValid(_email.text.trim())) {
                                      errorSnackBar(
                                          context, "Invalid email address");
                                    } else {
                                      ///Send data to api
                                      var user = await auth.sendEmailOtp(
                                        email: _email.text.trim(),
                                        context: context,
                                      );
                                      if (auth.resMessage ==
                                          'Signup successful') {
                                        nextPageAndRemovePrevious(context,
                                            page: OtpScreen(
                                              email: _email.text.toString(),
                                            ));

                                        if (context.mounted) {
                                          nextPage(context,
                                              page: OtpScreen(
                                                email: _email.text.toString(),
                                              ));
                                        }
                                      }
                                      // else {
                                      //   if (context.mounted) {
                                      //     successSnackBar(context, auth.resMessage);
                                      //   }
                                      // }
                                    }
                                    // nextPage(context, page: const PhoneSignUp());
                                  },
                                      text: 'Send code',
                                      bgColor: AppColor.primaryColor),
                                  PageService.textSpace,
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      if (_isLoading)
                        Container(
                          color: Colors.white
                              .withOpacity(0.5), // Adjust opacity as needed
                          child: Center(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 5,
                                  sigmaY:
                                      5), // Adjust sigmaX and sigmaY for the blur effect
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    });
  }

  bool isEmail(String em) {
    String p =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
