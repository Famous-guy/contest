import 'package:contest_app/src/screens/authentification/components/gender.form.field.dart';
import 'package:contest_app/src/src.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  /// text form field  controller
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _username = TextEditingController();
  bool _isLoading = false;
  bool isInputFocused = false;

  String selectedCountry = "";
  String selectedCountryCurrencyCode = '';
  String selectedCountryCode = '';
  String countryCode = '';
  String currencyCode = '';

  bool isLoading = false;

  bool accept = false;
  String? _selectedGender;

  void _handleGenderChanged(String? newValue) {
    setState(() {
      _selectedGender = newValue;
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
          title: 'Creating account...',
          show: true,
          child: Text(""),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          body: GestureDetector(
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
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create an account',
                                style: PageService.bigHeaderStylebold,
                              ),
                              PageService.textSpace,
                              Text(
                                'Sign up to continue',
                                style: PageService.labelStyle,
                              ),
                              PageService.textSpaceL,

                              Row(
                                children: [
                                  Text(
                                    'Fullname ',
                                    style: PageService.labelStyle500,
                                  ),
                                  const Text(
                                    '*',
                                    style: TextStyle(
                                      color: Color.fromRGBO(239, 68, 68, 1),
                                    ),
                                  )
                                ],
                              ),
                              PageService.textSpaceS,
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  }

                                  return null;
                                },
                                controller: _fullname,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Color(0xff9E9E9E),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: AppColor.gray2, width: 1),
                                  ),
                                  filled: true,
                                  isDense: true,
                                  hintText: 'e.g: Bredan Joshua',
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
                              Row(
                                children: [
                                  Text(
                                    'Email ',
                                    style: PageService.labelStyle500,
                                  ),
                                  const Text(
                                    '*',
                                    style: TextStyle(
                                      color: Color.fromRGBO(239, 68, 68, 1),
                                    ),
                                  )
                                ],
                              ),
                              PageService.textSpaceS,
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
                                    borderRadius: BorderRadius.circular(12),
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
                              Row(
                                children: [
                                  Text(
                                    'Username ',
                                    style: PageService.labelStyle500,
                                  ),
                                  const Text(
                                    '*',
                                    style: TextStyle(
                                      color: Color.fromRGBO(239, 68, 68, 1),
                                    ),
                                  )
                                ],
                              ),
                              PageService.textSpaceS,
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  }

                                  return null;
                                },
                                controller: _username,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Color(0xff9E9E9E),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: AppColor.gray2, width: 2),
                                  ),
                                  filled: true,
                                  isDense: true,
                                  hintText: 'e.g brainy josh',
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

                              Text(
                                'Gender: ',
                                style: PageService.labelStyle500,
                              ),

                              GenderFormField(
                                initialValue:
                                    'Male', // Set the initial value if needed
                                // onChanged: (String? newValue) {
                                //   // Handle the selected gender
                                //   print('Selected gender: $newValue');
                                // },
                                onChanged: _handleGenderChanged,
                              ),
                              PageService.textSpaceL,
                              Row(
                                children: [
                                  Text(
                                    'country ',
                                    style: PageService.labelStyle500,
                                  ),
                                  const Text(
                                    '*',
                                    style: TextStyle(
                                      color: Color.fromRGBO(239, 68, 68, 1),
                                    ),
                                  )
                                ],
                              ),
                              PageService.textSpaceS,
                              GestureDetector(
                                onTap: () {
                                  print('u must work');
                                  showCurrencyPicker(
                                    context: context,
                                    showFlag: true,
                                    showSearchField: true,
                                    showCurrencyName: true,
                                    showCurrencyCode: true,
                                    favorite: ['NG'],
                                    onSelect: (Currency currency) {
                                      selectedCountryCode =
                                          currency.code.toString();
                                      countryCode = currency.code;
                                    },
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColor.gray2,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedCountryCode, // Display selected country's currency code here
                                        style: TextStyle(
                                          color: AppColor.black,
                                        ),
                                      ), // Display selected country here
                                      GestureDetector(
                                        onTap: () {
                                          showCurrencyPicker(
                                            context: context,
                                            showFlag: true,
                                            showSearchField: true,
                                            showCurrencyName: true,
                                            showCurrencyCode: true,
                                            favorite: ['NG'],
                                            onSelect: (Currency currency) {
                                              selectedCountryCode =
                                                  currency.code.toString();
                                              countryCode = currency.code;
                                            },
                                          );
                                        },
                                        child: Icon(Icons.arrow_drop_down),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              PageService.textSpacexL,
                              // Row(
                              //   children: [
                              //     Text(
                              //       'Currency ',
                              //       style: PageService.labelStyle500,
                              //     ),
                              //     const Text(
                              //       '*',
                              //       style: TextStyle(
                              //         color: Color.fromRGBO(239, 68, 68, 1),
                              //       ),
                              //     )
                              //   ],
                              // ),
                              // PageService.textSpaceS,
                              // GestureDetector(
                              //   onTap: () {
                              //     showCurrencyPicker(
                              //       context: context,
                              //       showFlag: true,
                              //       showSearchField: true,
                              //       showCurrencyName: true,
                              //       showCurrencyCode: true,
                              //       favorite: ['NG'],
                              //       onSelect: (Currency currency) {
                              //         selectedCountryCurrencyCode =
                              //             currency.code.toString();
                              //         currencyCode = currency.code;
                              //       },
                              //     );
                              //   },
                              //   child: Container(
                              //     padding: EdgeInsets.all(10),
                              //     decoration: BoxDecoration(
                              //       border: Border.all(
                              //         color: AppColor.gray2,
                              //         width: 2,
                              //       ),
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Text(
                              //           selectedCountryCurrencyCode, // Display selected country's currency code here
                              //           style: TextStyle(
                              //             color: AppColor.black,
                              //           ),
                              //         ), // Display selected country here
                              //         GestureDetector(
                              //           onTap: () {
                              //             showCurrencyPicker(
                              //               context: context,
                              //               showFlag: true,
                              //               showSearchField: true,
                              //               showCurrencyName: true,
                              //               showCurrencyCode: true,
                              //               favorite: ['NG'],
                              //               onSelect: (Currency currency) {
                              //                 selectedCountryCurrencyCode =
                              //                     currency.code.toString();
                              //                 currencyCode = currency.code;
                              //               },
                              //             );
                              //           },
                              //           child: Icon(Icons.arrow_drop_down),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),

                              // PageService.textSpacexL,

                              Row(
                                children: [
                                  Text(
                                    'Password ',
                                    style: PageService.labelStyle500,
                                  ),
                                  Text(
                                    '*',
                                    style: TextStyle(
                                      color: Color.fromRGBO(239, 68, 68, 1),
                                    ),
                                  )
                                ],
                              ),
                              PageService.textSpaceS,
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
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Color(0xff9E9E9E),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
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

                              // Country(phoneCode: phoneCode, countryCode: countryCode, e164Sc: e164Sc, geographic: geographic, level: level, name: name, example: example, displayName: displayName, displayNameNoCountryCode: displayNameNoCountryCode, e164Key: e164Key)
                              PageService.textSpacexL,
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
                                      RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.gray9,
                                                  fontSize: 12),
                                              children: [
                                            TextSpan(
                                              text:
                                                  'Click “confirm” to accept our ',
                                            ),
                                            TextSpan(
                                                text: ' Terms of Service.',
                                                style: TextStyle(
                                                    color:
                                                        AppColor.primaryColor)),
                                          ]))
                                    ],
                                  ),
                                ],
                              ),
                              // PageService.textSpace,
                              const SizedBox(
                                height: 48,
                              ),

                              customButton(context, onTap: () async {
                                if (_fullname.text.isEmpty ||
                                    _email.text.isEmpty ||
                                    _username.text.isEmpty ||
                                    selectedCountryCode.isEmpty ||
                                    _password.text.isEmpty ||
                                    _selectedGender!.isEmpty) {
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
                                  var user = await auth.registerUser(
                                    email: _email.text.trim(),
                                    password: _password.text.trim(),
                                    fullName: _fullname.text.trim(),
                                    gender: _selectedGender!,
                                    country: selectedCountryCode.trim(),
                                    username: _username.text.trim(),
                                    context: context,
                                    currency: selectedCountryCode.trim(),
                                  );
                                  if (auth.resMessage == 'Signup successful') {
                                    nextPageAndRemovePrevious(context,
                                        page: SignInScreen());

                                    if (context.mounted) {
                                      nextPageAndRemovePrevious(context,
                                          page: SignInScreen());
                                    }
                                  } else {
                                    if (context.mounted) {
                                      successSnackBar(context, auth.resMessage);
                                    }
                                  }
                                }
                                // nextPage(context, page: const PhoneSignUp());
                              },
                                  text: 'Sign Up',
                                  bgColor: AppColor.primaryColor),

                              PageService.textSpaceL,
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Already have an account?',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColor.gray9,
                                            fontWeight: FontWeight.w400)),
                                    GestureDetector(
                                        onTap: () {
                                          nextPage(context,
                                              page: const SignInScreen());
                                        },
                                        child: Text('  Sign In',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColor.primaryColor,
                                                fontWeight: FontWeight.bold))),
                                  ],
                                ),
                              ),
                              PageService.textSpacexxL,

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
                              PageService.textSpacexxL,
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
                              //         image:
                              //             AssetImage("assets/images/apple.png"),
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
        );
      }
    });
  }

  void signin() {}
}
