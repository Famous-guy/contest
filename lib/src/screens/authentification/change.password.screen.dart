import 'package:contest_app/src/src.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String otp;
  final String email;
  ChangePasswordScreen({super.key, required this.otp, required this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  bool _passwordVisible = false;
  bool _passwordVisiblee = false;
  bool _isLoading = false;
  bool isInputFocused = false;

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return ForgottenPasswordScreen();
              },
            ));
          },
          color: AppColor.black,
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 600, // Adjust the max width as needed
          ),
          child:
              Consumer<AuthenticationProvider>(builder: (context, auth, child) {
            if (auth.isLoading == true) {
              return const BusyOverlay(
                title: 'Password Update',
                show: true,
                child: Text(""),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isInputFocused = false;
                  });
                },
                child: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create new password',
                                  style: PageService.bigHeaderStyle,
                                ),
                                PageService.textSpace,
                                Text(
                                  'New password must be different from previously used password',
                                  style: PageService.labelStyle,
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                // TextFormField(
                                //   controller: _otp,
                                //   decoration: InputDecoration(
                                //     // errorText:
                                //     //     _isEmailValid ? null : 'Invalid email format',
                                //     prefixIcon: const Icon(
                                //       Icons.email,
                                //       color: Color(0xff9E9E9E),
                                //     ),
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(12),
                                //       borderSide:
                                //       BorderSide(color: AppColor.gray2, width: 2),
                                //     ),
                                //     filled: true,
                                //     isDense: true,
                                //     hintText: widget.otp,
                                //     hintStyle: TextStyle(
                                //         fontSize: 14,
                                //         fontWeight: FontWeight.w400,
                                //         color: AppColor.gray4),
                                //     contentPadding: const EdgeInsets.only(
                                //         top: 15, bottom: 10, left: 10),
                                //     enabledBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(12),
                                //       borderSide:
                                //       BorderSide(color: AppColor.gray2, width: 2),
                                //     ),
                                //     focusedBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(12),
                                //       borderSide:
                                //       BorderSide(color: AppColor.gray2, width: 2),
                                //     ),
                                //   ),
                                // ),

                                // PageService.textSpaceL,
                                TextFormField(
                                  obscureText: !_passwordVisible,
                                  controller: _password,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: const Color(0xff9BA59F),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Color(0xff9E9E9E),
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    hintText: ' Password',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.gray4),
                                    contentPadding: const EdgeInsets.only(
                                        top: 15, bottom: 10, left: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: AppColor.gray2, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: AppColor.gray2, width: 1),
                                    ),
                                  ),
                                ),

                                PageService.textSpacexL,
                                TextFormField(
                                  obscureText: !_passwordVisiblee,
                                  controller: _confirmPassword,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisiblee
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: const Color(0xff9BA59F),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisiblee =
                                              !_passwordVisiblee;
                                        });
                                      },
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Color(0xff9E9E9E),
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    hintText: 'confirm Password',
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.gray4),
                                    contentPadding: const EdgeInsets.only(
                                        top: 15, bottom: 10, left: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: AppColor.gray2, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: AppColor.gray2, width: 1),
                                    ),
                                  ),
                                ),
                                // PageService.textSpace,

                                PageService.textSpacexxL,
                                customButton(
                                  bgColor: Colors.red,
                                  context,
                                  onTap: () {
                                    if (_password.text.isEmpty ||
                                        _confirmPassword.text.isEmpty) {
                                      errorSnackBar(
                                          context, 'All Fields are required');

                                      _confirmPassword.clear();
                                      return;
                                    }
                                    if (_password.text.trim() !=
                                        _confirmPassword.text.trim()) {
                                      errorSnackBar(
                                          context, 'Password does not match');
                                      _confirmPassword.clear();
                                      return;
                                    }
                                    auth.verifyForgotPassword(
                                      otp: widget.otp,
                                      email: widget.email.trim(),
                                      newPassword: _password.text.trim(),
                                      context: context,
                                    );
                                  },
                                  text: 'Reset password',
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
