import 'dart:ui';

import 'package:contest_app/main.dart';
import 'package:contest_app/src/constants/appcolors.dart';
import 'package:contest_app/src/export/export.dart';
import 'package:contest_app/src/models/userdata.dart';
import 'package:contest_app/src/providers/connect.dart';
import 'package:contest_app/src/providers/connectpos.dart';
import 'package:contest_app/src/providers/providers.dart';
import 'package:contest_app/src/providers/voucher.dart';
import 'package:contest_app/src/utils/utils.dart';
import 'package:contest_app/src/widgets/widgets.dart';
// import 'package:contest_app/src/src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  // late List<TextEditingController> _controllers;
  bool isInputFocused = false;
  // late UserData userData;
  bool connected = false;
  bool _isLoading = false;
  bool _isApiKeyValid = true;
  void _showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: Please input a value.'),
        duration: Duration(seconds: 1),
      ),
    );
    _isLoading = false;
  }

  @override
  void initState() {
    // _controllers = List.generate(
    //   7,
    //   (index) => TextEditingController(),
    // );
    loadData();
    initializeData();

    // userData = await getUserDataFromPrefs();
    // TODO: implement initState
    super.initState();
    // getContest();
  }

  Future<void> loadData() async {
    print('okay');
    await Provider.of<VoucherProvider>(context, listen: false).fetchVouchers();
    print('okay');
  }
  // Future<void> initializeData() async {
  //   UserData userData = await getUserDataFromPrefs();
  //   print(userData.token);
  //   connected = true;
  //   print(userData.token != null ? 'heelo' : 'fuck');
  // }

  Future<void> initializeData() async {
    UserData userData = await getUserDataFromPrefs();
    print(userData.token);
    setState(() {
      connected = userData
          .token.isNotEmpty; // Set connected based on whether token exists
    });
    print(connected ? 'hello' : 'not connected');
  }

  // @override
  // void dispose() {
  //   for (var controller in _controllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

  Future<void> getContest() async {
    await Provider.of<ProfileProvider>(context, listen: false).getVouchers();
  }

//  UserData userData = await getUserDataFromPrefs();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      var data = provider.contests;
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                'Vouchers',
                style: PageService.headerStyle,
              ),
              Text(
                'Spendable on 100pay partner site',
                style: TextStyle(
                  fontSize: 9,
                  color: AppColor.gray8,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          // actions: [
          //   GestureDetector(
          //     onTap: () {
          //       connected == true ? null : Connect1(context);
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.all(15.0),
          //       child: Text(
          //         connected == true ? 'Connected' : 'Connect',
          //         style: TextStyle(
          //           color: Color.fromRGBO(
          //             22,
          //             163,
          //             74,
          //             1,
          //           ),
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: Center(
          child: Consumer<VoucherProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return CircularProgressIndicator();
              } else if (provider.vouchers.isEmpty) {
                return Center(
                  child: Image.asset(
                    'assets/images/vouchers.png',
                    width: 268,
                    height: 143.91,
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: provider.vouchers.length,
                  itemBuilder: (context, index) {
                    final voucher = provider.vouchers[index];

                    String code = voucher.code;
                    String firstThree = code.substring(0, 3);
                    String lastThree = code.substring(code.length - 3);
                    String formattedDiscount =
                        NumberFormat('#,##0').format(voucher.discount);
                    String formattedDiscountwithdraw =
                        NumberFormat('#,##0').format(voucher.discount - 6);
                    String formattedconvert = NumberFormat('#,##0').format(
                        voucher.discount * double.parse('${33.888 ?? 31.888}'));
                    NumberFormat('#,##0').format(voucher.discount);
                    // currencySymbol =
                    //     getCurrencySymbol('${voucher.voucherCurrency}');

                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: ShapeDecoration(
                              shape: SwTicketBorder(
                                radius: 8,
                                fillColor: AppColor.primaryColor,
                                borderColor: AppColor.primaryColor,
                                borderWidth: 2,
                                bottomLeft: false,
                                bottomRight: true,
                                topLeft: false,
                                topRight: true,
                              ),
                            ),
                            child: Column(
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: '\$PAY ${formattedDiscount}',
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700)),
                                ])),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'NGN $formattedconvert',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                  border: Border(
                                      top: BorderSide(
                                          color: Color(0xffF3F4F6), width: 1),
                                      bottom: BorderSide(
                                          color: Color(0xffF3F4F6), width: 1),
                                      right: BorderSide(
                                          color: Color(0xffF3F4F6), width: 1))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _copyToClipboard(
                                                          context, code);
                                                    },
                                                    child: Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Voucher code: ',
                                                          ),
                                                          TextSpan(
                                                            text: firstThree,
                                                          ),
                                                          TextSpan(
                                                            text: '***',
                                                          ),
                                                          TextSpan(
                                                            text: lastThree,
                                                          ),
                                                        ],
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () {
                                        connected == true
                                            ? Use(context,
                                                formattedDiscountwithdraw)
                                            : Connect1(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                            color: Color(
                                              0xfff20732,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: const Text(
                                          'Use voucher',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );

                    // return ListTile(
                    //   title: Text('Discount: ${voucher.discount.toString()}'),
                    //   subtitle: Text('Code: ${voucher.code}'),
                    //   // Add more fields as needed
                    // );
                  },
                );
              }
            },
          ),
        ),
        // RefreshIndicator(
        //   triggerMode: RefreshIndicatorTriggerMode.anywhere,
        //   color: Colors.white,
        //   backgroundColor: Colors.red,
        //   onRefresh: getContest,
        //   child: Consumer<ProfileProvider>(builder: (context, provider, child) {
        //     var data = provider.contests;
        // Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 3),
        //     child: FutureBuilder<List<Voucher>>(
        //         future: provider.getVouchers(),
        //         builder: (context, snapshot) {
        //           if (snapshot.connectionState == ConnectionState.waiting) {
        //             return Center(
        //               child: CircularProgressIndicator(),
        //             );
        //           } else if (snapshot.hasError) {
        //             return Center(
        //               child: Text(
        //                 "An error occurred when trying to retrive your vouchers from the server",
        //                 textAlign: TextAlign.center,
        //               ),
        //             );
        //           } else if (snapshot.data!.isEmpty) {
        //             return Center(
        //               child: Image.asset(
        //                 'assets/images/vouchers.png',
        //                 width: 268,
        //                 height: 143.91,
        //               ),
        //             );
        //           } else {
        //             return CustomScrollView(
        //               slivers: <Widget>[
        //                 SliverPadding(
        //                   padding: EdgeInsets.symmetric(horizontal: 3),
        //                   sliver: SliverList(
        //                     delegate: SliverChildBuilderDelegate(
        //                       (BuildContext context, int index) {
        //                         return VoucherWidget(
        //                           voucher: snapshot.data![index],
        //                         );
        //                       },
        //                       childCount: snapshot.data!.length,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             );
        //             // ListView.builder(
        //             //   itemCount: snapshot.data!.length,
        //             //   itemBuilder: (context, index) {
        //             //     return VoucherWidget(
        //             //         voucher: snapshot.data![index]);
        //             //   },
        //             // );
        //           }
        //         })),
      );
    });
  }

  Future<dynamic> Connect1(BuildContext context) {
    TextEditingController amount = TextEditingController();
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      enableDrag: true,
      context: context,
      builder: (ctx) {
        return Container(
          child: Container(
            child: Consumer<WalletProvider>(
              builder: (context, wallet, child) {
                return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                        // Adjusted padding to accommodate keyboard
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 6),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 32,
                              ),
                              Center(
                                child: Image.asset(
                                  'assets/images/pay100.png',
                                  height: 16,
                                  width: 74.39,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Center(
                                child: Text(
                                  "Connect Your 100Pay account",
                                  style: TextStyle(
                                      color: Color.fromRGBO(
                                        92,
                                        92,
                                        92,
                                        1,
                                      ),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 5, right: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                      'Pay ID ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[800],
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      maxLength: 6,
                                      controller: amount,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          borderSide: BorderSide(
                                              color: AppColor.gray9, width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1),
                                        ),
                                        hintText: 'Enter pay ID',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[400],
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 16),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Consumer<SendPos>(builder: (context, pos, _) {
                                if (pos.isLoading) {
                                  print('this man');
                                }
                                //  else {}
                                return customButton(
                                  context,
                                  onTap: () async {
                                    Fluttertoast.showToast(
                                      // timeInSecForIosWeb: 2,
                                      webShowClose: pos.isLoading == false &&
                                          pos.hasData == true,
                                      msg: "Loading...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                    print(amount);
                                    // await auth.login(
                                    //   email: _email.text.trim(),
                                    //   password: _password.text.trim(),
                                    //   context: context,
                                    // );
                                    // Navigator.pop(ctx);
                                    setState(() {
                                      _isLoading = true;

                                      // Future.delayed(Duration(seconds: 1),
                                      //     () async {
                                      //   if (amount.text.isEmpty) {
                                      //     _showErrorMessage();
                                      //     _isLoading = false;
                                      //     return;
                                      //   }

                                      // _isApiKeyValid = _validateApiKey(
                                      //     apiKeyController.text);

                                      // await Provider.of<SendPos>(
                                      //   context,
                                      //   listen: false,
                                      // ).sendPos(
                                      //   context,
                                      //   amount.text,
                                      //   () {
                                      // Navigator.pop(ctx);
                                      // _showSecondContainer(
                                      //   context,
                                      // );
                                      //   },
                                      // );
                                      pos.sendPos(context, amount.text, () {
                                        print(pos.isLoading);
                                        Navigator.pop(ctx);
                                        _showSecondContainer(context,
                                            inviteCode: amount.text);
                                      });

                                      // Navigate to the next screen
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => Pay100(),
                                      //   ),
                                      // );

                                      _isLoading = false;
                                      // });
                                    });

                                    // await Provider.of<SendPos>(
                                    //   context,
                                    //   listen: false,
                                    // ).sendPos(
                                    //   context,
                                    //   amount.text,
                                    //   () => _showSecondContainer(
                                    //     context,
                                    //   ),
                                    // );
                                    // _showSecondContainer(context);
                                  },
                                  text: pos.isLoading == true &&
                                          pos.hasData == false
                                      ? 'Please wait...'
                                      : 'Connect account',
                                  bgColor: pos.isLoading == true &&
                                          pos.hasData == false
                                      ? Colors.grey
                                      : Color.fromRGBO(
                                          242,
                                          7,
                                          50,
                                          1,
                                        ),
                                  textColor: Color.fromRGBO(
                                    255,
                                    255,
                                    255,
                                    1,
                                  ),
                                );
                              }),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showSecondContainer(BuildContext context,
      {required String inviteCode}) {
    late List<TextEditingController> _controllers;

    _controllers = List.generate(
      7,
      (index) => TextEditingController(),
    );

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      enableDrag: true,
      context: context,
      builder: (verify) {
        return Container(
          child: Container(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    // Adjusted padding to accommodate keyboard
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 6,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 32,
                          ),
                          Center(
                            child: Image.asset(
                              'assets/images/pay100.png',
                              height: 16,
                              width: 74.39,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Text(
                              "Connect Your 100Pay account",
                              style: TextStyle(
                                color: Color.fromRGBO(
                                  92,
                                  92,
                                  92,
                                  1,
                                ),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 5,
                              right: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Secure code ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(
                                      71,
                                      71,
                                      71,
                                      1,
                                    ),
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Enter 6 digits code you received on your email to continue the process',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(
                                      92,
                                      92,
                                      92,
                                      1,
                                    ),
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 48,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(7, (index) {
                                    if (index == 3) {
                                      return Text(
                                        '-',
                                        style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              // _controllers[6].text.isNotEmpty
                                              // ?
                                              Colors.red,
                                          // : Color.fromRGBO(
                                          //     235,
                                          //     235,
                                          //     235,
                                          //     1,
                                          //   ),
                                        ),
                                      );
                                    }
                                    return Container(
                                      height: 54,
                                      width: 40,
                                      margin: EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color:
                                              // _controllers[6].text.isNotEmpty
                                              //     ?
                                              Colors.red,
                                          // : Color.fromRGBO(
                                          //     235, 235, 235, 1),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              // _controllers[6].text.isNotEmpty
                                              //     ?
                                              Colors.red,
                                          // : Color.fromRGBO(
                                          //     235, 235, 235, 1),
                                        ),
                                        controller: _controllers[index],
                                        keyboardType: TextInputType.number,
                                        maxLength:
                                            1, // Limit input to one character
                                        onChanged: (value) {
                                          if (value.isNotEmpty && index < 6) {
                                            // Move focus to the next box
                                            FocusScope.of(context).nextFocus();
                                          } else if (value.isEmpty &&
                                              index > 0) {
                                            // Move focus to the previous box when deleting
                                            FocusScope.of(context)
                                                .previousFocus();
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: '',
                                        ),
                                        onTap: () async {},
                                      ),
                                    );
                                  }),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'If you didn’t receive the code? ',
                                style: TextStyle(
                                  color: Color.fromRGBO(133, 133, 133, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                                text: 'Resend',
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 48,
                          ),
                          Consumer<UserDataProvider>(
                              builder: (context, user, _) {
                            return customButton(
                              context,
                              onTap: () {
                                Fluttertoast.showToast(
                                  // timeInSecForIosWeb: 2,
                                  // webShowClose: pos.isLoading == false &&
                                  //     pos.hasData == true,
                                  msg: "Loading...",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                print(inviteCode);
                                print(_controllers.toString());
                                // await auth.login(
                                //   email: _email.text.trim(),
                                //   password: _password.text.trim(),
                                //   context: context,
                                // );
                                // Navigator.pop(ctx);
                                setState(() {
                                  _isLoading = true;

                                  // Future.delayed(Duration(seconds: 1),
                                  //     () async {
                                  //   if (amount.text.isEmpty) {
                                  //     _showErrorMessage();
                                  //     _isLoading = false;
                                  //     return;
                                  //   }

                                  // _isApiKeyValid = _validateApiKey(
                                  //     apiKeyController.text);

                                  // await Provider.of<SendPos>(
                                  //   context,
                                  //   listen: false,
                                  // ).sendPos(
                                  //   context,
                                  //   amount.text,
                                  //   () {
                                  // Navigator.pop(ctx);
                                  // _showSecondContainer(
                                  //   context,
                                  // );
                                  //   },
                                  // );
                                  // pos.sendPos(context, amount.text, () {
                                  //   print(pos.isLoading);
                                  //   Navigator.pop(ctx);
                                  //   _showSecondContainer(
                                  //     context,
                                  //   );
                                  // });
                                  print(_controllers.toString());
                                  user.connectPOS(
                                      context: context,
                                      inviteCode: inviteCode,
                                      update: () async {
                                        UserData userData =
                                            await getUserDataFromPrefs();
                                        print(userData.token);
                                        setState(() {
                                          connected = userData.token
                                              .isNotEmpty; // Set connected based on whether token exists
                                        });
                                        print(connected
                                            ? 'hello'
                                            : 'not connected');
                                        Navigator.pop(
                                          verify,
                                        );
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              elevation: 0,
                                              backgroundColor: Color.fromRGBO(
                                                255,
                                                255,
                                                255,
                                                1,
                                              ),
                                              title: Image.asset(
                                                'assets/images/successIcon.png',
                                                height: 48,
                                                width: 48,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Account Connected',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                        71,
                                                        71,
                                                        71,
                                                        1,
                                                      ),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Your account has been successfully connect to your 100 pay account.',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                        92,
                                                        92,
                                                        92,
                                                        1,
                                                      ),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                customButton(
                                                  context,
                                                  onTap: () async {
                                                    // connected = true;
                                                    Navigator.pop(context);
                                                    UserData userData =
                                                        await getUserDataFromPrefs();
                                                    print(userData.token);
                                                    setState(() {
                                                      connected = userData.token
                                                          .isNotEmpty; // Set connected based on whether token exists
                                                    });
                                                    print(connected
                                                        ? 'hello'
                                                        : 'not connected');
                                                  },
                                                  text: 'Done',
                                                  bgColor:
                                                      AppColor.primaryColor,
                                                  textColor: Colors.white,
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      otp: _controllers.toString());

                                  // Navigate to the next screen
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => Pay100(),
                                  //   ),
                                  // );

                                  _isLoading = false;
                                  // });
                                });

                                // Navigator.pop(
                                //   verify,
                                // );
                                // showDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return AlertDialog(
                                //       elevation: 0,
                                //       backgroundColor: Color.fromRGBO(
                                //         255,
                                //         255,
                                //         255,
                                //         1,
                                //       ),
                                //       title: Image.asset(
                                //         'assets/images/successIcon.png',
                                //         height: 48,
                                //         width: 48,
                                //       ),
                                //       content: Column(
                                //         mainAxisSize: MainAxisSize.min,
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.center,
                                //         children: [
                                //           Text(
                                //             'Account Connected',
                                //             style: TextStyle(
                                //               color: Color.fromRGBO(
                                //                 71,
                                //                 71,
                                //                 71,
                                //                 1,
                                //               ),
                                //               fontSize: 18,
                                //               fontWeight: FontWeight.w700,
                                //             ),
                                //           ),
                                //           Text(
                                //             'Your account has been successfully connect to your 100 pay account.',
                                //             textAlign: TextAlign.center,
                                //             style: TextStyle(
                                //               color: Color.fromRGBO(
                                //                 92,
                                //                 92,
                                //                 92,
                                //                 1,
                                //               ),
                                //               fontSize: 16,
                                //               fontWeight: FontWeight.w400,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //       actions: [
                                //         customButton(
                                //           context,
                                //           onTap: () {
                                //             connected = true;
                                //             Navigator.pop(context);
                                //           },
                                //           text: 'Done',
                                //           bgColor: AppColor.primaryColor,
                                //           textColor: Colors.white,
                                //         )
                                //       ],
                                //     );
                                //   },
                                // );
                              },
                              text: 'Verify',
                              bgColor: AppColor.primaryColor,
                              textColor: Color.fromRGBO(255, 255, 255, 1),
                            );
                          }),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    Fluttertoast.showToast(
      msg: "Vocher code Copied",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Copied to clipboard'),
    //   ),
    // );
  }

  Future<dynamic> Use(BuildContext context, String formattedDiscountwithdraw) {
    late List<TextEditingController> _controllers;

    _controllers = List.generate(
      7,
      (index) => TextEditingController(),
    );
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      enableDrag: true,
      context: context,
      builder: (ctx) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            setState(() {
              isInputFocused = false;
            });
          },
          child: Container(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  isInputFocused = false;
                });
              },
              child: Container(
                child: Consumer<WalletProvider>(
                  builder: (context, wallet, child) {
                    return LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return SingleChildScrollView(
                          padding: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 10,
                            // Adjusted padding to accommodate keyboard
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 17, vertical: 6),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Image.asset(
                                      'assets/images/contestvo.png',
                                      height: 26.28,
                                      width: 41.98,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Center(
                                    child: Text(
                                      "You’re sending",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                            92,
                                            92,
                                            92,
                                            1,
                                          ),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "${formattedDiscountwithdraw}.00",
                                      style: TextStyle(
                                        color: Color.fromRGBO(
                                          107,
                                          114,
                                          128,
                                          1,
                                        ),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 36,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "pay token voucher",
                                      style: TextStyle(
                                        color: Color.fromRGBO(
                                          133,
                                          133,
                                          133,
                                          1,
                                        ),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(
                                        249,
                                        250,
                                        251,
                                        1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'To 100 pay account:',
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Image.asset(
                                              'assets/images/pay100.png',
                                              height: 10.62,
                                              width: 49.39,
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          color: Color.fromRGBO(
                                            229,
                                            231,
                                            235,
                                            1,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/thisman.png.png',
                                              height: 30,
                                              width: 30,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Oscar Raymond',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                  75,
                                                  85,
                                                  99,
                                                  1,
                                                ),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Image.asset(
                                              'assets/images/line2.png',
                                              height: 30,
                                              width: 30,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'Pay ID: P234GH6',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                  156,
                                                  163,
                                                  175,
                                                  1,
                                                ),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Transaction Fee:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(
                                            156,
                                            163,
                                            175,
                                            1,
                                          ),
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '6 \$Pay',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(
                                            107,
                                            114,
                                            128,
                                            1,
                                          ),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 5, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20),
                                        Text(
                                          'Transaction Pin',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[800],
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(7, (index) {
                                            if (index == 3) {
                                              return Text(
                                                '-',
                                                style: TextStyle(
                                                  fontSize: 36,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      //  _controllers[6]
                                                      //         .text
                                                      //         .isNotEmpty
                                                      //     ?
                                                      Colors.red,
                                                  // : Color
                                                  //     .fromRGBO(
                                                  //     235,
                                                  //     235,
                                                  //     235,
                                                  //     1,
                                                  //   ),
                                                ),
                                              );
                                            }
                                            return Container(
                                              height: 54,
                                              width: 40,
                                              margin: EdgeInsets.only(right: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color:
                                                      // _controllers[6]
                                                      //         .text
                                                      //         .isNotEmpty
                                                      //     ?
                                                      Colors.red,
                                                  // : Color.fromRGBO(
                                                  //     235,
                                                  //     235,
                                                  //     235,
                                                  //     1),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      // _controllers[6]
                                                      //         .text
                                                      //         .isNotEmpty
                                                      //     ?
                                                      Colors.red,
                                                  // : Color.fromRGBO(
                                                  //     235,
                                                  //     235,
                                                  //     235,
                                                  //     1),
                                                ),
                                                controller: _controllers[index],
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength:
                                                    1, // Limit input to one character
                                                onChanged: (value) {
                                                  if (value.isNotEmpty &&
                                                      index < 6) {
                                                    // Move focus to the next box
                                                    FocusScope.of(context)
                                                        .nextFocus();
                                                  } else if (value.isEmpty &&
                                                      index > 0) {
                                                    // Move focus to the previous box when deleting
                                                    FocusScope.of(context)
                                                        .previousFocus();
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  counterText: '',
                                                ),
                                                onTap: () async {},
                                              ),
                                            );
                                          }),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              'Enter your transaction pin to continue. ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromRGBO(
                                                133, 133, 133, 1),
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Create transaction ID',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pop(ctx);
                                              _showSecondContainer1(context);
                                            },
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(242, 7, 50, 1),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),

                                  // Text.rich(
                                  //   TextSpan(
                                  //     children: [
                                  //       TextSpan(
                                  //         text:
                                  //             'Enter your transaction pin to continue. ',
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.w500,
                                  //           color: Color.fromRGBO(
                                  //             133,
                                  //             133,
                                  //             133,
                                  //             1,
                                  //           ),
                                  //           fontSize: 14,
                                  //         ),
                                  //       ),
                                  //       TextSpan(
                                  //         text: 'Create transaction ID',
                                  //         recognizer: TapGestureRecognizer()
                                  //           ..onTap =
                                  //               () => _showSecondContainer,
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.w500,
                                  //           color: Color.fromRGBO(
                                  //             242,
                                  //             7,
                                  //             50,
                                  //             1,
                                  //           ),
                                  //           fontSize: 14,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //     style: TextStyle(
                                  //       fontSize: 10,
                                  //     ),
                                  //   ),
                                  // ),

                                  SizedBox(
                                    height: 50,
                                  ),
                                  customButton(
                                    context,
                                    onTap: () {
                                      Navigator.pop(
                                        ctx,
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            elevation: 0,
                                            backgroundColor: Color.fromRGBO(
                                              255,
                                              255,
                                              255,
                                              1,
                                            ),
                                            title: Image.asset(
                                              'assets/images/successIcon.png',
                                              height: 48,
                                              width: 48,
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Sent Successfully',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                      71,
                                                      71,
                                                      71,
                                                      1,
                                                    ),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  'You have successfully sent your voucher to your 100 pay account.',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                      92,
                                                      92,
                                                      92,
                                                      1,
                                                    ),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              customButton(
                                                context,
                                                onTap: () {
                                                  // connected = true;
                                                  Navigator.pop(context);
                                                },
                                                text: 'Done',
                                                bgColor: AppColor.primaryColor,
                                                textColor: Colors.white,
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    text: 'Proceed',
                                    bgColor: Color.fromRGBO(
                                      242,
                                      7,
                                      50,
                                      1,
                                    ),
                                    textColor: Color.fromRGBO(
                                      255,
                                      255,
                                      255,
                                      1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> Connect2(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      enableDrag: true,
      context: context,
      builder: (ctx) {
        return Container(
          child: Container(
            child: Consumer<WalletProvider>(
              builder: (context, wallet, child) {
                return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                        // Adjusted padding to accommodate keyboard
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 6),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 32,
                              ),
                              Center(
                                child: Image.asset(
                                  'assets/images/contestvo.png',
                                  height: 26.28,
                                  width: 41.98,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Center(
                                child: Text(
                                  "Connect Your 100Pay account",
                                  style: TextStyle(
                                      color: Color.fromRGBO(
                                        92,
                                        92,
                                        92,
                                        1,
                                      ),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 5, right: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                      'Pay ID ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[800],
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      maxLength: 6,
                                      // controller: amount,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          borderSide: BorderSide(
                                              color: AppColor.gray9, width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 1),
                                        ),
                                        hintText: 'Enter pay ID',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[400],
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 16),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              customButton(
                                context,
                                onTap: () {
                                  Navigator.pop(ctx);
                                  _showSecondContainer1(context);
                                },
                                text: 'Connect account',
                                bgColor: Color.fromRGBO(
                                  242,
                                  7,
                                  50,
                                  1,
                                ),
                                textColor: Color.fromRGBO(
                                  255,
                                  255,
                                  255,
                                  1,
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showSecondContainer1(BuildContext context) {
    late List<TextEditingController> _controllers;

    _controllers = List.generate(
      7,
      (index) => TextEditingController(),
    );

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      enableDrag: true,
      context: context,
      builder: (verify) {
        return Container(
          child: Container(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    // Adjusted padding to accommodate keyboard
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 6,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 32,
                          ),
                          Center(
                            child: Image.asset(
                              'assets/images/padlock.png',
                              height: 48,
                              width: 48,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Text(
                              "Create Transaction Pin",
                              style: TextStyle(
                                color: Color.fromRGBO(
                                  92,
                                  92,
                                  92,
                                  1,
                                ),
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 5,
                              right: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Secure code ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(
                                      71,
                                      71,
                                      71,
                                      1,
                                    ),
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Enter 6 digits code you received on your email to continue the process',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(
                                      92,
                                      92,
                                      92,
                                      1,
                                    ),
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 48,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(7, (index) {
                                    if (index == 3) {
                                      return Text(
                                        '-',
                                        style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              // _controllers[6].text.isNotEmpty
                                              //     ?
                                              Colors.red,
                                          // : Color.fromRGBO(
                                          //     235,
                                          //     235,
                                          //     235,
                                          //     1,
                                          // ),
                                        ),
                                      );
                                    }
                                    return Container(
                                      height: 54,
                                      width: 40,
                                      margin: EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color:
                                              // _controllers[6].text.isNotEmpty
                                              //     ?
                                              Colors.red,
                                          // :
                                          // Color.fromRGBO(
                                          //     235, 235, 235, 1),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              // _controllers[6].text.isNotEmpty
                                              //     ?
                                              Colors.red,
                                          // : Color.fromRGBO(
                                          //     235, 235, 235, 1),
                                        ),
                                        controller: _controllers[index],
                                        keyboardType: TextInputType.number,
                                        maxLength:
                                            1, // Limit input to one character
                                        onChanged: (value) {
                                          if (value.isNotEmpty && index < 6) {
                                            // Move focus to the next box
                                            FocusScope.of(context).nextFocus();
                                          } else if (value.isEmpty &&
                                              index > 0) {
                                            // Move focus to the previous box when deleting
                                            FocusScope.of(context)
                                                .previousFocus();
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: '',
                                        ),
                                        onTap: () async {},
                                      ),
                                    );
                                  }),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'If you didn’t receive the code? ',
                                style: TextStyle(
                                  color: Color.fromRGBO(133, 133, 133, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                                text: 'Resend',
                              )
                            ]),
                          ),
                          SizedBox(
                            height: 48,
                          ),
                          customButton(
                            context,
                            onTap: () {
                              Navigator.pop(
                                verify,
                              );
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    elevation: 0,
                                    backgroundColor: Color.fromRGBO(
                                      255,
                                      255,
                                      255,
                                      1,
                                    ),
                                    title: Image.asset(
                                      'assets/images/successIcon.png',
                                      height: 48,
                                      width: 48,
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Created Successfully',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                              71,
                                              71,
                                              71,
                                              1,
                                            ),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          'Your transaction pin has been created successfully',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                              92,
                                              92,
                                              92,
                                              1,
                                            ),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      customButton(
                                        context,
                                        onTap: () {
                                          // connected = true;
                                          Navigator.pop(context);
                                        },
                                        text: 'Done',
                                        bgColor: AppColor.primaryColor,
                                        textColor: Colors.white,
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            text: 'Verify',
                            bgColor: AppColor.primaryColor,
                            textColor: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// class VoucherWidget extends StatefulWidget {
//   final Voucher voucher;

//   VoucherWidget({
//     required this.voucher,
//   });

//   @override
//   State<VoucherWidget> createState() => _VoucherWidgetState();
// }

// class _VoucherWidgetState extends State<VoucherWidget> {
//   // late IOWebSocketChannel channel;
//   // double? cValue;
//   bool isInputFocused = false;
//   // late List<TextEditingController> _controllers;
//   @override
//   void initState() {
//     // _controllers = List.generate(
//     //   7,
//     //   (index) => TextEditingController(),
//     // );
//     super.initState();
//     // connectToWebSocket();
//   }

//   @override
//   void dispose() {
//     // for (var controller in _controllers) {
//     //   controller.dispose();
//     // }
//     // Close WebSocket connection when the widget is disposed
//     // channel.sink.close();
//     super.dispose();
//   }

//   // void connectToWebSocket() {
//   //   // Establish WebSocket connection
//   //   channel = IOWebSocketChannel.connect(
//   //     'ws://jfxrates.com/websocket/asset-price/',
//   //     headers: {
//   //       'pair': 'pay_usdt',
//   //       'fiat': 'ngn',
//   //       'interval': 0,
//   //     },
//   //   );

//   //   // Listen for messages from the WebSocket server
//   //   channel.stream.listen(
//   //     (message) {
//   //       print('Received message: $message');

//   //       Map<String, dynamic> data = json.decode(message);

//   //       setState(() {
//   //         cValue = data['data']['price'];

//   //         print('Price: $cValue');
//   //       });
//   //     },
//   //     onError: (error) {
//   //       print('Error occurred: $error');
//   //       // Handle errors here
//   //     },
//   //     onDone: () {
//   //       print('WebSocket connection closed');
//   //       // Handle WebSocket connection closed
//   //     },
//   //   );
//   // }

//   String currencySymbol = '';
//   String getCurrencySymbol(String? currency) {
//     if (currency != null && currencies.containsKey(currency)) {
//       return currencies[currency]!;
//     } else {
//       return ''; // Return empty string if currency not found
//     }
//   }

//   void _copyToClipboard(BuildContext context, String text) {
//     Clipboard.setData(ClipboardData(text: text));
//     Fluttertoast.showToast(
//       msg: "Vocher code Copied",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.TOP,
//       backgroundColor: Colors.grey,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//     // ScaffoldMessenger.of(context).showSnackBar(
//     //   SnackBar(
//     //     content: Text('Copied to clipboard'),
//     //   ),
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     String code = widget.voucher.code;
//     String firstThree = code.substring(0, 3);
//     String lastThree = code.substring(code.length - 3);
//     String formattedDiscount =
//         NumberFormat('#,##0').format(widget.voucher.discount);
//     String formattedDiscountwithdraw =
//         NumberFormat('#,##0').format(widget.voucher.discount - 6);
//     String formattedconvert = NumberFormat('#,##0')
//         .format(widget.voucher.discount * double.parse('${33.888 ?? 31.888}'));
//     NumberFormat('#,##0').format(widget.voucher.discount);
//     currencySymbol = getCurrencySymbol('${widget.voucher.voucherCurrency}');

//     return Padding(
//       padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(15),
//             decoration: ShapeDecoration(
//               shape: SwTicketBorder(
//                 radius: 8,
//                 fillColor: AppColor.primaryColor,
//                 borderColor: AppColor.primaryColor,
//                 borderWidth: 2,
//                 bottomLeft: false,
//                 bottomRight: true,
//                 topLeft: false,
//                 topRight: true,
//               ),
//             ),
//             child: Column(
//               children: [
//                 RichText(
//                     text: TextSpan(children: [
//                   TextSpan(
//                       text: '\$PAY ${formattedDiscount}',
//                       style: TextStyle(
//                           color: AppColor.white,
//                           fontSize: 11,
//                           fontWeight: FontWeight.w700)),
//                 ])),
//                 SizedBox(
//                   height: 3,
//                 ),
//                 Text(
//                   'NGN $formattedconvert',
//                   style: TextStyle(
//                     fontSize: 9,
//                     color: AppColor.white,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Flexible(
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
//               decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(8),
//                       bottomRight: Radius.circular(8)),
//                   border: Border(
//                       top: BorderSide(color: Color(0xffF3F4F6), width: 1),
//                       bottom: BorderSide(color: Color(0xffF3F4F6), width: 1),
//                       right: BorderSide(color: Color(0xffF3F4F6), width: 1))),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Center(
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       _copyToClipboard(context, code);
//                                     },
//                                     child: Text.rich(
//                                       TextSpan(
//                                         children: [
//                                           TextSpan(
//                                             text: 'Voucher code: ',
//                                           ),
//                                           TextSpan(
//                                             text: firstThree,
//                                           ),
//                                           TextSpan(
//                                             text: '***',
//                                           ),
//                                           TextSpan(
//                                             text: lastThree,
//                                           ),
//                                         ],
//                                         style: TextStyle(
//                                           fontSize: 10,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Flexible(
//                     child: GestureDetector(
//                       onTap: () {
//                         Use(context, formattedDiscountwithdraw);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: const BoxDecoration(
//                             color: Color(
//                               0xfff20732,
//                             ),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(15))),
//                         child: const Text(
//                           'Use voucher',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 9,
//                               fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Future<dynamic> Use(BuildContext context, String formattedDiscountwithdraw) {
//     late List<TextEditingController> _controllers;

//     _controllers = List.generate(
//       7,
//       (index) => TextEditingController(),
//     );
//     return showModalBottomSheet(
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(12),
//           topLeft: Radius.circular(12),
//         ),
//       ),
//       enableDrag: true,
//       context: context,
//       builder: (ctx) {
//         return GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//             setState(() {
//               isInputFocused = false;
//             });
//           },
//           child: Container(
//             child: GestureDetector(
//               onTap: () {
//                 FocusScope.of(context).unfocus();
//                 setState(() {
//                   isInputFocused = false;
//                 });
//               },
//               child: Container(
//                 child: Consumer<WalletProvider>(
//                   builder: (context, wallet, child) {
//                     return LayoutBuilder(
//                       builder:
//                           (BuildContext context, BoxConstraints constraints) {
//                         return SingleChildScrollView(
//                           padding: EdgeInsets.only(
//                             bottom:
//                                 MediaQuery.of(context).viewInsets.bottom + 10,
//                             // Adjusted padding to accommodate keyboard
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 17, vertical: 6),
//                               width: MediaQuery.of(context).size.width,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Center(
//                                     child: Image.asset(
//                                       'assets/images/contestvo.png',
//                                       height: 26.28,
//                                       width: 41.98,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 16,
//                                   ),
//                                   Center(
//                                     child: Text(
//                                       "You’re sending",
//                                       style: TextStyle(
//                                           color: Color.fromRGBO(
//                                             92,
//                                             92,
//                                             92,
//                                             1,
//                                           ),
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 16),
//                                     ),
//                                   ),
//                                   Center(
//                                     child: Text(
//                                       "${formattedDiscountwithdraw}.00",
//                                       style: TextStyle(
//                                         color: Color.fromRGBO(
//                                           107,
//                                           114,
//                                           128,
//                                           1,
//                                         ),
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 36,
//                                       ),
//                                     ),
//                                   ),
//                                   Center(
//                                     child: Text(
//                                       "pay token voucher",
//                                       style: TextStyle(
//                                         color: Color.fromRGBO(
//                                           133,
//                                           133,
//                                           133,
//                                           1,
//                                         ),
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: 10,
//                                       vertical: 10,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: Color.fromRGBO(
//                                         249,
//                                         250,
//                                         251,
//                                         1,
//                                       ),
//                                       borderRadius: BorderRadius.circular(
//                                         15,
//                                       ),
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(
//                                               'To 100 pay account:',
//                                             ),
//                                             SizedBox(
//                                               width: 8,
//                                             ),
//                                             Image.asset(
//                                               'assets/images/pay100.png',
//                                               height: 10.62,
//                                               width: 49.39,
//                                             ),
//                                           ],
//                                         ),
//                                         Divider(
//                                           color: Color.fromRGBO(
//                                             229,
//                                             231,
//                                             235,
//                                             1,
//                                           ),
//                                         ),
//                                         Row(
//                                           children: [
//                                             Image.asset(
//                                               'assets/images/thisman.png.png',
//                                               height: 30,
//                                               width: 30,
//                                             ),
//                                             SizedBox(
//                                               width: 8,
//                                             ),
//                                             Text(
//                                               'Oscar Raymond',
//                                               style: TextStyle(
//                                                 color: Color.fromRGBO(
//                                                   75,
//                                                   85,
//                                                   99,
//                                                   1,
//                                                 ),
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: 4,
//                                             ),
//                                             Image.asset(
//                                               'assets/images/line2.png',
//                                               height: 30,
//                                               width: 30,
//                                             ),
//                                             SizedBox(
//                                               width: 4,
//                                             ),
//                                             Text(
//                                               'Pay ID: P234GH6',
//                                               style: TextStyle(
//                                                 color: Color.fromRGBO(
//                                                   156,
//                                                   163,
//                                                   175,
//                                                   1,
//                                                 ),
//                                                 fontWeight: FontWeight.w400,
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 16,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Transaction Fee:',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w400,
//                                           color: Color.fromRGBO(
//                                             156,
//                                             163,
//                                             175,
//                                             1,
//                                           ),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       Text(
//                                         '6 \$Pay',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           color: Color.fromRGBO(
//                                             107,
//                                             114,
//                                             128,
//                                             1,
//                                           ),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 5, left: 5, right: 5),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(height: 20),
//                                         Text(
//                                           'Transaction Pin',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.grey[800],
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 8,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: List.generate(7, (index) {
//                                             if (index == 3) {
//                                               return Text(
//                                                 '-',
//                                                 style: TextStyle(
//                                                   fontSize: 36,
//                                                   fontWeight: FontWeight.w700,
//                                                   color:
//                                                       //  _controllers[6]
//                                                       //         .text
//                                                       //         .isNotEmpty
//                                                       //     ?
//                                                       Colors.red,
//                                                   // : Color
//                                                   //     .fromRGBO(
//                                                   //     235,
//                                                   //     235,
//                                                   //     235,
//                                                   //     1,
//                                                   //   ),
//                                                 ),
//                                               );
//                                             }
//                                             return Container(
//                                               height: 54,
//                                               width: 40,
//                                               margin: EdgeInsets.only(right: 8),
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(8),
//                                                 border: Border.all(
//                                                   color:
//                                                       // _controllers[6]
//                                                       //         .text
//                                                       //         .isNotEmpty
//                                                       //     ?
//                                                       Colors.red,
//                                                   // : Color.fromRGBO(
//                                                   //     235,
//                                                   //     235,
//                                                   //     235,
//                                                   //     1),
//                                                 ),
//                                               ),
//                                               alignment: Alignment.center,
//                                               child: TextField(
//                                                 textAlign: TextAlign.center,
//                                                 textAlignVertical:
//                                                     TextAlignVertical.center,
//                                                 style: TextStyle(
//                                                   fontSize: 32,
//                                                   fontWeight: FontWeight.w600,
//                                                   color:
//                                                       // _controllers[6]
//                                                       //         .text
//                                                       //         .isNotEmpty
//                                                       //     ?
//                                                       Colors.red,
//                                                   // : Color.fromRGBO(
//                                                   //     235,
//                                                   //     235,
//                                                   //     235,
//                                                   //     1),
//                                                 ),
//                                                 controller: _controllers[index],
//                                                 keyboardType:
//                                                     TextInputType.number,
//                                                 maxLength:
//                                                     1, // Limit input to one character
//                                                 onChanged: (value) {
//                                                   if (value.isNotEmpty &&
//                                                       index < 6) {
//                                                     // Move focus to the next box
//                                                     FocusScope.of(context)
//                                                         .nextFocus();
//                                                   } else if (value.isEmpty &&
//                                                       index > 0) {
//                                                     // Move focus to the previous box when deleting
//                                                     FocusScope.of(context)
//                                                         .previousFocus();
//                                                   }
//                                                 },
//                                                 decoration: InputDecoration(
//                                                   border: InputBorder.none,
//                                                   counterText: '',
//                                                 ),
//                                                 onTap: () async {},
//                                               ),
//                                             );
//                                           }),
//                                         ),
//                                         SizedBox(
//                                           height: 10,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Text.rich(
//                                     TextSpan(
//                                       children: [
//                                         TextSpan(
//                                           text:
//                                               'Enter your transaction pin to continue. ',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             color: Color.fromRGBO(
//                                                 133, 133, 133, 1),
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                         TextSpan(
//                                           text: 'Create transaction ID',
//                                           recognizer: TapGestureRecognizer()
//                                             ..onTap = () {
//                                               Navigator.pop(ctx);
//                                               _showSecondContainer(context);
//                                             },
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             color:
//                                                 Color.fromRGBO(242, 7, 50, 1),
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ],
//                                       style: TextStyle(
//                                         fontSize: 10,
//                                       ),
//                                     ),
//                                   ),

//                                   // Text.rich(
//                                   //   TextSpan(
//                                   //     children: [
//                                   //       TextSpan(
//                                   //         text:
//                                   //             'Enter your transaction pin to continue. ',
//                                   //         style: TextStyle(
//                                   //           fontWeight: FontWeight.w500,
//                                   //           color: Color.fromRGBO(
//                                   //             133,
//                                   //             133,
//                                   //             133,
//                                   //             1,
//                                   //           ),
//                                   //           fontSize: 14,
//                                   //         ),
//                                   //       ),
//                                   //       TextSpan(
//                                   //         text: 'Create transaction ID',
//                                   //         recognizer: TapGestureRecognizer()
//                                   //           ..onTap =
//                                   //               () => _showSecondContainer,
//                                   //         style: TextStyle(
//                                   //           fontWeight: FontWeight.w500,
//                                   //           color: Color.fromRGBO(
//                                   //             242,
//                                   //             7,
//                                   //             50,
//                                   //             1,
//                                   //           ),
//                                   //           fontSize: 14,
//                                   //         ),
//                                   //       ),
//                                   //     ],
//                                   //     style: TextStyle(
//                                   //       fontSize: 10,
//                                   //     ),
//                                   //   ),
//                                   // ),

//                                   SizedBox(
//                                     height: 50,
//                                   ),
//                                   customButton(
//                                     context,
//                                     onTap: () {
//                                       Navigator.pop(
//                                         ctx,
//                                       );
//                                       showDialog(
//                                         context: context,
//                                         builder: (context) {
//                                           return AlertDialog(
//                                             elevation: 0,
//                                             backgroundColor: Color.fromRGBO(
//                                               255,
//                                               255,
//                                               255,
//                                               1,
//                                             ),
//                                             title: Image.asset(
//                                               'assets/images/successIcon.png',
//                                               height: 48,
//                                               width: 48,
//                                             ),
//                                             content: Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: [
//                                                 Text(
//                                                   'Sent Successfully',
//                                                   style: TextStyle(
//                                                     color: Color.fromRGBO(
//                                                       71,
//                                                       71,
//                                                       71,
//                                                       1,
//                                                     ),
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.w700,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'You have successfully sent your voucher to your 100 pay account.',
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     color: Color.fromRGBO(
//                                                       92,
//                                                       92,
//                                                       92,
//                                                       1,
//                                                     ),
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w400,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             actions: [
//                                               customButton(
//                                                 context,
//                                                 onTap: () {
//                                                   // connected = true;
//                                                   Navigator.pop(context);
//                                                 },
//                                                 text: 'Done',
//                                                 bgColor: AppColor.primaryColor,
//                                                 textColor: Colors.white,
//                                               )
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     },
//                                     text: 'Proceed',
//                                     bgColor: Color.fromRGBO(
//                                       242,
//                                       7,
//                                       50,
//                                       1,
//                                     ),
//                                     textColor: Color.fromRGBO(
//                                       255,
//                                       255,
//                                       255,
//                                       1,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Future<dynamic> Connect1(BuildContext context) {
//     return showModalBottomSheet(
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(12),
//           topLeft: Radius.circular(12),
//         ),
//       ),
//       enableDrag: true,
//       context: context,
//       builder: (ctx) {
//         return Container(
//           child: Container(
//             child: Consumer<WalletProvider>(
//               builder: (context, wallet, child) {
//                 return LayoutBuilder(
//                   builder: (BuildContext context, BoxConstraints constraints) {
//                     return SingleChildScrollView(
//                       padding: EdgeInsets.only(
//                         bottom: MediaQuery.of(context).viewInsets.bottom + 20,
//                         // Adjusted padding to accommodate keyboard
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 17, vertical: 6),
//                           width: MediaQuery.of(context).size.width,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: 32,
//                               ),
//                               Center(
//                                 child: Image.asset(
//                                   'assets/images/contestvo.png',
//                                   height: 26.28,
//                                   width: 41.98,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 16,
//                               ),
//                               Center(
//                                 child: Text(
//                                   "Connect Your 100Pay account",
//                                   style: TextStyle(
//                                       color: Color.fromRGBO(
//                                         92,
//                                         92,
//                                         92,
//                                         1,
//                                       ),
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 16),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 5, left: 5, right: 5),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(height: 20),
//                                     Text(
//                                       'Pay ID ',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.grey[800],
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 8,
//                                     ),
//                                     TextFormField(
//                                       maxLength: 6,
//                                       // controller: amount,
//                                       keyboardType: TextInputType.number,
//                                       decoration: InputDecoration(
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             4,
//                                           ),
//                                           borderSide: BorderSide(
//                                               color: Colors.grey, width: 1),
//                                         ),
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             4,
//                                           ),
//                                           borderSide: BorderSide(
//                                               color: AppColor.gray9, width: 1),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             4,
//                                           ),
//                                           borderSide: BorderSide(
//                                               color: Colors.grey, width: 1),
//                                         ),
//                                         hintText: 'Enter pay ID',
//                                         hintStyle: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.grey[400],
//                                         ),
//                                         contentPadding:
//                                             const EdgeInsets.symmetric(
//                                                 vertical: 16, horizontal: 16),
//                                       ),
//                                     ),
//                                     SizedBox(height: 20),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 50,
//                               ),
//                               customButton(
//                                 context,
//                                 onTap: () {
//                                   Navigator.pop(ctx);
//                                   _showSecondContainer(context);
//                                 },
//                                 text: 'Connect account',
//                                 bgColor: Color.fromRGBO(
//                                   242,
//                                   7,
//                                   50,
//                                   1,
//                                 ),
//                                 textColor: Color.fromRGBO(
//                                   255,
//                                   255,
//                                   255,
//                                   1,
//                                 ),
//                               ),
//                               SizedBox(height: 20),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showSecondContainer(BuildContext context) {
//     late List<TextEditingController> _controllers;

//     _controllers = List.generate(
//       7,
//       (index) => TextEditingController(),
//     );

//     showModalBottomSheet(
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(12),
//           topLeft: Radius.circular(12),
//         ),
//       ),
//       enableDrag: true,
//       context: context,
//       builder: (verify) {
//         return Container(
//           child: Container(
//             child: LayoutBuilder(
//               builder: (BuildContext context, BoxConstraints constraints) {
//                 return SingleChildScrollView(
//                   padding: EdgeInsets.only(
//                     bottom: MediaQuery.of(context).viewInsets.bottom + 20,
//                     // Adjusted padding to accommodate keyboard
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 17,
//                         vertical: 6,
//                       ),
//                       width: MediaQuery.of(context).size.width,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 32,
//                           ),
//                           Center(
//                             child: Image.asset(
//                               'assets/images/padlock.png',
//                               height: 48,
//                               width: 48,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 16,
//                           ),
//                           Center(
//                             child: Text(
//                               "Create Transaction Pin",
//                               style: TextStyle(
//                                 color: Color.fromRGBO(
//                                   92,
//                                   92,
//                                   92,
//                                   1,
//                                 ),
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                               top: 5,
//                               left: 5,
//                               right: 5,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Text(
//                                   'Secure code ',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w700,
//                                     color: Color.fromRGBO(
//                                       71,
//                                       71,
//                                       71,
//                                       1,
//                                     ),
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 8,
//                                 ),
//                                 Text(
//                                   'Enter 6 digits code you received on your email to continue the process',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     color: Color.fromRGBO(
//                                       92,
//                                       92,
//                                       92,
//                                       1,
//                                     ),
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 48,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: List.generate(7, (index) {
//                                     if (index == 3) {
//                                       return Text(
//                                         '-',
//                                         style: TextStyle(
//                                           fontSize: 36,
//                                           fontWeight: FontWeight.w700,
//                                           color:
//                                               // _controllers[6].text.isNotEmpty
//                                               //     ?
//                                               Colors.red,
//                                           // : Color.fromRGBO(
//                                           //     235,
//                                           //     235,
//                                           //     235,
//                                           //     1,
//                                           // ),
//                                         ),
//                                       );
//                                     }
//                                     return Container(
//                                       height: 54,
//                                       width: 40,
//                                       margin: EdgeInsets.only(right: 8),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(
//                                           color:
//                                               // _controllers[6].text.isNotEmpty
//                                               //     ?
//                                               Colors.red,
//                                           // :
//                                           // Color.fromRGBO(
//                                           //     235, 235, 235, 1),
//                                         ),
//                                       ),
//                                       alignment: Alignment.center,
//                                       child: TextField(
//                                         textAlign: TextAlign.center,
//                                         textAlignVertical:
//                                             TextAlignVertical.center,
//                                         style: TextStyle(
//                                           fontSize: 32,
//                                           fontWeight: FontWeight.w600,
//                                           color:
//                                               // _controllers[6].text.isNotEmpty
//                                               //     ?
//                                               Colors.red,
//                                           // : Color.fromRGBO(
//                                           //     235, 235, 235, 1),
//                                         ),
//                                         controller: _controllers[index],
//                                         keyboardType: TextInputType.number,
//                                         maxLength:
//                                             1, // Limit input to one character
//                                         onChanged: (value) {
//                                           if (value.isNotEmpty && index < 6) {
//                                             // Move focus to the next box
//                                             FocusScope.of(context).nextFocus();
//                                           } else if (value.isEmpty &&
//                                               index > 0) {
//                                             // Move focus to the previous box when deleting
//                                             FocusScope.of(context)
//                                                 .previousFocus();
//                                           }
//                                         },
//                                         decoration: InputDecoration(
//                                           border: InputBorder.none,
//                                           counterText: '',
//                                         ),
//                                         onTap: () async {},
//                                       ),
//                                     );
//                                   }),
//                                 ),
//                                 SizedBox(
//                                   height: 8,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Text.rich(
//                             TextSpan(children: [
//                               TextSpan(
//                                 text: 'If you didn’t receive the code? ',
//                                 style: TextStyle(
//                                   color: Color.fromRGBO(133, 133, 133, 1),
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               TextSpan(
//                                 style: TextStyle(
//                                   color: AppColor.primaryColor,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16,
//                                 ),
//                                 text: 'Resend',
//                               )
//                             ]),
//                           ),
//                           SizedBox(
//                             height: 48,
//                           ),
//                           customButton(
//                             context,
//                             onTap: () {
//                               Navigator.pop(
//                                 verify,
//                               );
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     elevation: 0,
//                                     backgroundColor: Color.fromRGBO(
//                                       255,
//                                       255,
//                                       255,
//                                       1,
//                                     ),
//                                     title: Image.asset(
//                                       'assets/images/successIcon.png',
//                                       height: 48,
//                                       width: 48,
//                                     ),
//                                     content: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           'Created Successfully',
//                                           style: TextStyle(
//                                             color: Color.fromRGBO(
//                                               71,
//                                               71,
//                                               71,
//                                               1,
//                                             ),
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                         ),
//                                         Text(
//                                           'Your transaction pin has been created successfully',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             color: Color.fromRGBO(
//                                               92,
//                                               92,
//                                               92,
//                                               1,
//                                             ),
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w400,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     actions: [
//                                       customButton(
//                                         context,
//                                         onTap: () {
//                                           // connected = true;
//                                           Navigator.pop(context);
//                                         },
//                                         text: 'Done',
//                                         bgColor: AppColor.primaryColor,
//                                         textColor: Colors.white,
//                                       )
//                                     ],
//                                   );
//                                 },
//                               );
//                             },
//                             text: 'Verify',
//                             bgColor: AppColor.primaryColor,
//                             textColor: Color.fromRGBO(255, 255, 255, 1),
//                           ),
//                           SizedBox(height: 20),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );

//   }

//   // void _showSecondContainer(BuildContext context) {
//   //   showModalBottomSheet(
//   //     isScrollControlled: true,
//   //     backgroundColor: Colors.white,
//   //     shape: const RoundedRectangleBorder(
//   //       borderRadius: BorderRadius.only(
//   //         topRight: Radius.circular(12),
//   //         topLeft: Radius.circular(12),
//   //       ),
//   //     ),
//   //     enableDrag: true,
//   //     context: context,
//   //     builder: (ctx) {
//   //       return Container(
//   //         child: Container(
//   //           child: Consumer<WalletProvider>(
//   //             builder: (context, wallet, child) {
//   //               return LayoutBuilder(
//   //                 builder: (BuildContext context, BoxConstraints constraints) {
//   //                   return SingleChildScrollView(
//   //                     padding: EdgeInsets.only(
//   //                       bottom: MediaQuery.of(context).viewInsets.bottom + 20,
//   //                       // Adjusted padding to accommodate keyboard
//   //                     ),
//   //                     child: Padding(
//   //                       padding: const EdgeInsets.all(8.0),
//   //                       child: Container(
//   //                         padding: const EdgeInsets.symmetric(
//   //                             horizontal: 17, vertical: 6),
//   //                         width: MediaQuery.of(context).size.width,
//   //                         child: Column(
//   //                           crossAxisAlignment: CrossAxisAlignment.start,
//   //                           children: [
//   //                             SizedBox(
//   //                               height: 32,
//   //                             ),
//   //                             Center(
//   //                               child: Image.asset(
//   //                                 'assets/images/pay100.png',
//   //                                 height: 16,
//   //                                 width: 74.39,
//   //                               ),
//   //                             ),
//   //                             SizedBox(
//   //                               height: 16,
//   //                             ),
//   //                             Center(
//   //                               child: Text(
//   //                                 "Connect Your 100Pay account",
//   //                                 style: TextStyle(
//   //                                     color: Color.fromRGBO(
//   //                                       92,
//   //                                       92,
//   //                                       92,
//   //                                       1,
//   //                                     ),
//   //                                     fontWeight: FontWeight.w500,
//   //                                     fontSize: 16),
//   //                               ),
//   //                             ),
//   //                             Padding(
//   //                               padding: const EdgeInsets.only(
//   //                                   top: 5, left: 5, right: 5),
//   //                               child: Column(
//   //                                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                                 children: [
//   //                                   SizedBox(
//   //                                     height: 20,
//   //                                   ),
//   //                                   Text(
//   //                                     'Secure code ',
//   //                                     style: TextStyle(
//   //                                       fontWeight: FontWeight.w700,
//   //                                       color: Color.fromRGBO(
//   //                                         71,
//   //                                         71,
//   //                                         71,
//   //                                         1,
//   //                                       ),
//   //                                       fontSize: 20,
//   //                                     ),
//   //                                   ),
//   //                                   SizedBox(
//   //                                     height: 8,
//   //                                   ),
//   //                                   Text(
//   //                                     'Enter 6 digits code you received on your email to continue the process',
//   //                                     style: TextStyle(
//   //                                       fontWeight: FontWeight.w400,
//   //                                       color: Color.fromRGBO(
//   //                                         92,
//   //                                         92,
//   //                                         92,
//   //                                         1,
//   //                                       ),
//   //                                       fontSize: 16,
//   //                                     ),
//   //                                   ),
//   //                                   SizedBox(
//   //                                     height: 48,
//   //                                   ),
//   //                                   Row(
//   //                                     mainAxisAlignment:
//   //                                         MainAxisAlignment.center,
//   //                                     children: List.generate(7, (index) {
//   //                                       if (index == 3) {
//   //                                         return Text(
//   //                                           '-',
//   //                                           style: TextStyle(
//   //                                             fontSize: 36,
//   //                                             fontWeight: FontWeight.w700,
//   //                                             color: _controllers[6]
//   //                                                     .text
//   //                                                     .isNotEmpty
//   //                                                 ? Colors.red
//   //                                                 : Color.fromRGBO(
//   //                                                     235,
//   //                                                     235,
//   //                                                     235,
//   //                                                     1,
//   //                                                   ),
//   //                                           ),
//   //                                         );
//   //                                       }
//   //                                       return Container(
//   //                                         height: 54,
//   //                                         width: 40,
//   //                                         margin: EdgeInsets.only(right: 8),
//   //                                         decoration: BoxDecoration(
//   //                                           borderRadius:
//   //                                               BorderRadius.circular(8),
//   //                                           border: Border.all(
//   //                                             color: _controllers[6]
//   //                                                     .text
//   //                                                     .isNotEmpty
//   //                                                 ? Colors.red
//   //                                                 : Color.fromRGBO(
//   //                                                     235, 235, 235, 1),
//   //                                           ),
//   //                                         ),
//   //                                         alignment: Alignment.center,
//   //                                         child: TextField(
//   //                                           textAlign: TextAlign.center,
//   //                                           textAlignVertical:
//   //                                               TextAlignVertical.center,
//   //                                           style: TextStyle(
//   //                                             fontSize: 32,
//   //                                             fontWeight: FontWeight.w600,
//   //                                             color: _controllers[6]
//   //                                                     .text
//   //                                                     .isNotEmpty
//   //                                                 ? Colors.red
//   //                                                 : Color.fromRGBO(
//   //                                                     235,
//   //                                                     235,
//   //                                                     235,
//   //                                                     1,
//   //                                                   ),
//   //                                           ),
//   //                                           controller: _controllers[index],
//   //                                           keyboardType: TextInputType.number,
//   //                                           // textAlign: TextAlign.center,
//   //                                           maxLength:
//   //                                               1, // Limit input to one character
//   //                                           onChanged: (value) {
//   //                                             if (value.isNotEmpty &&
//   //                                                 index < 6) {
//   //                                               // Move focus to the next box
//   //                                               FocusScope.of(context)
//   //                                                   .nextFocus();
//   //                                             } else if (value.isEmpty &&
//   //                                                 index > 0) {
//   //                                               // Move focus to the previous box when deleting
//   //                                               FocusScope.of(context)
//   //                                                   .previousFocus();
//   //                                             }
//   //                                             setState(() {});
//   //                                           },
//   //                                           decoration: InputDecoration(
//   //                                             border: InputBorder.none,
//   //                                             counterText: '',
//   //                                           ),
//   //                                           // Handle pasting
//   //                                           onTap: () async {},
//   //                                         ),
//   //                                       );
//   //                                     }),
//   //                                   ),
//   //                                   SizedBox(
//   //                                     height: 8,
//   //                                   ),
//   //                                 ],
//   //                               ),
//   //                             ),
//   //                             Text.rich(TextSpan(children: [
//   //                               TextSpan(
//   //                                 text: 'If you didn’t receive the code? ',
//   //                                 style: TextStyle(
//   //                                   color: Color.fromRGBO(
//   //                                     133,
//   //                                     133,
//   //                                     133,
//   //                                     1,
//   //                                   ),
//   //                                   fontWeight: FontWeight.w400,
//   //                                   fontSize: 16,
//   //                                 ),
//   //                               ),
//   //                               TextSpan(
//   //                                   style: TextStyle(
//   //                                     color: AppColor.primaryColor,
//   //                                     fontWeight: FontWeight.w400,
//   //                                     fontSize: 16,
//   //                                   ),
//   //                                   text: 'Resend')
//   //                             ])),
//   //                             SizedBox(
//   //                               height: 48,
//   //                             ),
//   //                             customButton(context,
//   //                                 onTap: () {},
//   //                                 text: 'Verify',
//   //                                 bgColor:
//   //                                     // _controllers[6].text.isNotEmpty
//   //                                     // ?
//   //                                     AppColor.primaryColor,
//   //                                 // : Color.fromRGBO(
//   //                                 //     165,
//   //                                 //     176,
//   //                                 //     193,
//   //                                 //     1,
//   //                                 //   ),
//   //                                 textColor:
//   //                                     // _controllers[6].text.isNotEmpty
//   //                                     // ?
//   //                                     Color.fromRGBO(
//   //                                   255,
//   //                                   255,
//   //                                   255,
//   //                                   1,
//   //                                 )
//   //                                 // :
//   //                                 // Colors.black,
//   //                                 ),
//   //                             SizedBox(height: 20),
//   //                           ],
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   );
//   //                 },
//   //               );
//   //             },
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
// }

// // // import 'dart:convert';

// import 'package:contest_app/src/constants/appcolors.dart';
// import 'package:contest_app/src/providers/voucher.dart';
// import 'package:contest_app/src/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:web_socket_channel/io.dart';

// class VoucherScreen extends StatefulWidget {
//   @override
//   State<VoucherScreen> createState() => _VoucherScreenState();
// }

// class _VoucherScreenState extends State<VoucherScreen> {
//   late IOWebSocketChannel channel;
//   double? cValue;
//   bool isInputFocused = false;
//   // late List<TextEditingController> _controllers;
//   @override
//   void initState() {
//     // _controllers = List.generate(
//     //   7,
//     //   (index) => TextEditingController(),
//     // );
//     super.initState();
//     connectToWebSocket();
//   }

//   @override
//   void dispose() {
//     // for (var controller in _controllers) {
//     //   controller.dispose();
//     // }
//     // Close WebSocket connection when the widget is disposed
//     channel.sink.close();
//     super.dispose();
//   }

//   void connectToWebSocket() {
//     // Establish WebSocket connection
//     channel = IOWebSocketChannel.connect(
//       'ws://jfxrates.com/websocket/asset-price/',
//       headers: {
//         'pair': 'pay_usdt',
//         'fiat': 'ngn',
//         'interval': 0,
//       },
//     );

//     // Listen for messages from the WebSocket server
//     channel.stream.listen(
//       (message) {
//         print('Received message: $message');

//         Map<String, dynamic> data = json.decode(message);

//         setState(() {
//           cValue = data['data']['price'];

//           print('Price: $cValue');
//         });
//       },
//       onError: (error) {
//         print('Error occurred: $error');
//         // Handle errors here
//       },
//       onDone: () {
//         print('WebSocket connection closed');
//         // Handle WebSocket connection closed
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Vouchers'),
//       ),
//       body: Center(
//         child: Consumer<VoucherProvider>(
//           builder: (context, provider, _) {
//             if (provider.vouchers.isEmpty) {
//               return CircularProgressIndicator();
//             } else {
//               return ListView.builder(
//                 itemCount: provider.vouchers.length,
//                 itemBuilder: (context, index) {
//                   final voucher = provider.vouchers[index];
//                   String code = voucher.code;
//                   String firstThree = code.substring(0, 3);
//                   String lastThree = code.substring(code.length - 3);
//                   String formattedDiscount =
//                       NumberFormat('#,##0').format(voucher.discount);
//                   String formattedDiscountwithdraw =
//                       NumberFormat('#,##0').format(voucher.discount - 6);
//                   String formattedconvert = NumberFormat('#,##0').format(
//                       voucher.discount * double.parse('${cValue ?? 31.888}'));
//                   NumberFormat('#,##0').format(voucher.discount);
//                   return Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(15),
//                         decoration: ShapeDecoration(
//                           shape: SwTicketBorder(
//                             radius: 8,
//                             fillColor: AppColor.primaryColor,
//                             borderColor: AppColor.primaryColor,
//                             borderWidth: 2,
//                             bottomLeft: false,
//                             bottomRight: true,
//                             topLeft: false,
//                             topRight: true,
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             RichText(
//                                 text: TextSpan(children: [
//                               TextSpan(
//                                   text: '\$PAY ${formattedDiscount}',
//                                   style: TextStyle(
//                                       color: AppColor.white,
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w700)),
//                             ])),
//                             SizedBox(
//                               height: 3,
//                             ),
//                             Text(
//                               'NGN ${formattedDiscount}',
//                               style: TextStyle(
//                                 fontSize: 9,
//                                 color: AppColor.white,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Flexible(
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 4, horizontal: 4),
//                           decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(8),
//                                   bottomRight: Radius.circular(8)),
//                               border: Border(
//                                   top: BorderSide(
//                                       color: Color(0xffF3F4F6), width: 1),
//                                   bottom: BorderSide(
//                                       color: Color(0xffF3F4F6), width: 1),
//                                   right: BorderSide(
//                                       color: Color(0xffF3F4F6), width: 1))),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Center(
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   // _copyToClipboard(
//                                                   //     context, code);
//                                                 },
//                                                 child: Text.rich(
//                                                   TextSpan(
//                                                     children: [
//                                                       TextSpan(
//                                                         text: 'Voucher code: ',
//                                                       ),
//                                                       TextSpan(
//                                                         text: firstThree,
//                                                       ),
//                                                       TextSpan(
//                                                         text: '***',
//                                                       ),
//                                                       TextSpan(
//                                                         text: lastThree,
//                                                       ),
//                                                     ],
//                                                     style: TextStyle(
//                                                       fontSize: 10,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Flexible(
//                                 child: GestureDetector(
//                                   onTap: () {},
//                                   child: Container(
//                                     padding: const EdgeInsets.all(8),
//                                     decoration: const BoxDecoration(
//                                         color: Color(
//                                           0xfff20732,
//                                         ),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(15))),
//                                     child: const Text(
//                                       'Use voucher',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 9,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   );

//                   // ListTile(
//                   //   title: Text('Discount: ${voucher.discount.toString()}'),
//                   //   subtitle: Text('Code: ${voucher.code}'),
//                   //   // Add more fields as needed
//                   // );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
