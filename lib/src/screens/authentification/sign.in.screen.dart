import 'package:contest_app/src/providers/user.profile.provider.dart';
import 'package:contest_app/src/src.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  /// text form field  controller
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  // final TextEditingController _fullname = TextEditingController();
  // final TextEditingController _payid = TextEditingController();
  bool _isLoading = false;
  bool isInputFocused = false;

  // bool _isLoading = false;
  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      context.read<LeaderboardProvider>().fetchLeaderboard();
      context.read<HomeProvider>().getPastContests();
      context.read<HomeProvider>().fetchSupportedContests();
      context.read<HomeProvider>().fetchContests();
      context.read<BalanceProvider>().fetchBalance();
      context.read<UserProfileProvider>().fetchUserProfile();
      context.read<ProfileProvider>().getVouchers();
    });
  }

  bool _passwordVisible = false;
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(builder: (context, auth, child) {
      if (auth.isLoading == true) {
        return const BusyOverlay(
          title: 'Login....',
          show: true,
          child: Text(""),
        );
      } else {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
            ),
            // Center(
            //   child: Container(
            //     constraints: BoxConstraints(
            //       maxWidth: 600, // Adjust the max width as needed
            //     ),
            //     child:
            //         LoadingScreen(), // Assuming LoadingScreen is your starting screen
            //   ),
            // ),
            body: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 600, // Adjust the max width as needed
                ),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      isInputFocused = false;
                    });
                  },
                  child: Stack(
                    children: [
                      Form(
                        key: _formKey,
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome back! ',
                                      style: PageService.bigHeaderStylebold,
                                    ),
                                    PageService.textSpace,
                                    Text(
                                      'Sign in to continue',
                                      style: PageService.labelStyle,
                                    ),
                                    PageService.textSpaceL,

                                    // PageService.textSpacexL,
                                    Row(
                                      children: [
                                        Text(
                                          'Email ',
                                          style: PageService.labelStyle500,
                                        ),
                                        const Text(
                                          '*',
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(239, 68, 68, 1),
                                          ),
                                        )
                                      ],
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field is required';
                                        }

                                        return null;
                                      },
                                      controller: _email,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.email,
                                          color: Color(0xff9E9E9E),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColor.gray2, width: 2),
                                        ),
                                        filled: true,
                                        isDense: true,
                                        hintText: 'e.g: example@gmail.com',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.gray4),
                                        contentPadding: const EdgeInsets.only(
                                            top: 15, bottom: 10, left: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColor.gray2, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColor.gray2, width: 2),
                                        ),
                                      ),
                                    ),
                                    PageService.textSpacexL,

                                    Row(
                                      children: [
                                        Text(
                                          'Password ',
                                          style: PageService.labelStyle500,
                                        ),
                                        Text(
                                          '*',
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(239, 68, 68, 1),
                                          ),
                                        )
                                      ],
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field is required';
                                        }
                                        return null;
                                      },
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
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          color: Color(0xff9E9E9E),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColor.gray2, width: 2),
                                        ),
                                        isDense: true,
                                        hintText: '*************',
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.gray4),
                                        contentPadding: const EdgeInsets.only(
                                            top: 15, bottom: 10, left: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColor.gray2, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColor.gray2, width: 2),
                                        ),
                                      ),
                                    ),

                                    // PageService.textSpace,

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                side: BorderSide(
                                                  color: _isChecked
                                                      ? AppColor.primaryColor
                                                      : Colors
                                                          .grey, // Use different colors for checked/unchecked states
                                                ),
                                              ),
                                              checkColor: AppColor.primaryColor,
                                              activeColor: AppColor.altPrimary,
                                              value: _isChecked,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  _isChecked = value ?? false;
                                                });
                                              },
                                            ),
                                            const Text("Remember me"),
                                          ],
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              nextPage1(context,
                                                  page:
                                                      const ForgottenPasswordScreen());
                                            },
                                            child: Text(
                                              'Forgotten Password',
                                              style: PageService.labelStylered,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 48,
                                    ),
                                    customButton(context, onTap: () async {
                                      if (_email.text.isEmpty ||
                                          _password.text.isEmpty) {
                                        errorSnackBar(
                                            context, "All field are required");
                                      }
                                      // else if (!_isChecked) {
                                      //   errorSnackBar(context,
                                      //       'Please check the checkbox before proceeding.');
                                      //   return;
                                      // }
                                      else if (!FlutterUtilities()
                                          .isEmailValid(_email.text.trim())) {
                                        errorSnackBar(
                                            context, "Invalid email address");
                                      } else {
                                        ///Send data to api
                                        var user = await auth.login(
                                          email: _email.text.trim(),
                                          password: _password.text.trim(),
                                          context: context,
                                        );
                                        // if (auth.resMessage == 'Login successful') {
                                        //   nextPageAndRemovePrevious(context,
                                        //       page: MainActivityPage());

                                        //   if (context.mounted) {
                                        //     nextPageAndRemovePrevious(context,
                                        //         page: MainActivityPage());
                                        //   }
                                        // } else {
                                        //   if (context.mounted) {
                                        //     successSnackBar(context,  auth.resMessage);
                                        //   }
                                        // }
                                      }
                                      // nextPage(context, page: const PhoneSignUp());
                                    },
                                        text: 'Sign in',
                                        bgColor: AppColor.primaryColor),

                                    PageService.textSpaceL,
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Don\'t have an account yet?',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppColor.gray9,
                                                  fontWeight: FontWeight.w400)),
                                          GestureDetector(
                                              onTap: () {
                                                nextPage(context,
                                                    page: const SignUpScreen());
                                              },
                                              child: Text('  Sign Up',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          AppColor.primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        ],
                                      ),
                                    ),
                                    // PageService.textSpacexxL,

                                    // Row(
                                    //   children: <Widget>[
                                    //     Expanded(
                                    //       child: Divider(
                                    //         thickness: 2,
                                    //         color: AppColor.gray2,
                                    //       ),
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 8,
                                    //     ),
                                    //     Text('Sign in directly with',
                                    //         style: TextStyle(
                                    //             fontSize: 14,
                                    //             color: AppColor.gray6,
                                    //             fontWeight: FontWeight.w400)),
                                    //     const SizedBox(
                                    //       width: 8,
                                    //     ),
                                    //     Expanded(
                                    //       child: Divider(
                                    //         thickness: 2,
                                    //         color: AppColor.gray2,
                                    //       ),
                                    //     ),

                                    //     // const Image(image: AssetImage("assets/images/Line.png")),
                                    //   ],
                                    // ),
                                    // // PageService.textSpacexxL,
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     ScoiallTabButton(
                                    //       onTap: () {},
                                    //       icon: const Image(
                                    //         image: AssetImage(
                                    //             "assets/images/google.png"),
                                    //       ),
                                    //     ),
                                    //     ScoiallTabButton(
                                    //       onTap: () {},
                                    //       icon: const Image(
                                    //         image: AssetImage(
                                    //             "assets/images/facebook.png"),
                                    //       ),
                                    //     ),
                                    //     ScoiallTabButton(
                                    //       onTap: () {},
                                    //       icon: const Image(
                                    //         image: AssetImage(
                                    //             "assets/images/devicon_twitter.png"),
                                    //       ),
                                    //     ),
                                    //     ScoiallTabButton(
                                    //       onTap: () {},
                                    //       icon: const Image(
                                    //         image: AssetImage(
                                    //             "assets/images/apple.png"),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      }
    });
  }
}
