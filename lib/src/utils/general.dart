import 'package:contest_app/src/src.dart';
import 'package:flutter/cupertino.dart';

import '../src/hundred_pay.dart';

// import 'package:hundredpay/hundredpay.dart';

int _counter = 0;
// topUpModalBottomSheet(topUpContext) {
//   final textInput = TextEditingController();
//   final description = TextEditingController();
//   final amount = TextEditingController();
//   showModalBottomSheet(
//     isScrollControlled: true,
//     backgroundColor: Colors.white,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topRight: Radius.circular(
//           12,
//         ),
//         topLeft: Radius.circular(12),
//       ),
//     ),
//     enableDrag: true,
//     context: topUpContext,
//     builder: (ctx) {
//       return Consumer<WalletProvider>(builder: (context, wallet, child) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
//             width: MediaQuery.of(context).size.width,
//             child: ListView(
//               shrinkWrap: true,
//               physics: AlwaysScrollableScrollPhysics(),
//               // mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Icon(
//                         Icons.arrow_back,
//                         color: Color(0xff262F56),
//                       ),
//                     ),
//                     const Spacer(),
//                     const Center(
//                         child: Text(
//                       "Fund wallet",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//                     )),
//                     const Spacer(),
//                   ],
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(top: 40, left: 40, right: 40),
//                   child: Column(
//                     children: [
//                       PageService.textSpace,
//                       Container(
//                           alignment: Alignment.centerLeft,
//                           margin: const EdgeInsets.only(bottom: 10),
//                           child: Text('Amount',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   color: AppColor.gray8,
//                                   fontSize: 14))),
//                       TextFormField(
//                         controller: amount,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           // prefix: Image.asset('assets/images/naira.png'),
//                           border: InputBorder.none,
//                           isDense: true,
//                           hintText: 'Enter amount',
//                           hintStyle: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: AppColor.gray4),
//                           contentPadding: const EdgeInsets.only(
//                               top: 15, bottom: 10, left: 10),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide:
//                                 BorderSide(color: AppColor.gray2, width: 1),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide:
//                                 BorderSide(color: AppColor.gray2, width: 1),
//                           ),
//                         ),
//                       ),
//                       PageService.textSpacexxL,
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         if (
//                             amount.text.isNotEmpty) {
//                           Navigator.pop(context);
//                           wallet.fundWallet(
//                             amount: amount.text,
//                             context: topUpContext,
//                           );
//                         } else {
//                           error(context, message: "All fields are required");
//                         }
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 40, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: AppColor.primaryColor,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(
//                           "Continue",
//                           style: TextStyle(
//                               color: AppColor.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 40, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: AppColor.gray1,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(
//                           "Cancel",
//                           style: TextStyle(
//                               color: AppColor.gray9,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 PageService.textSpacexxL,
//                 PageService.textSpacexxL,
//               ],
//             ),
//           ),
//         );
//       });
//     },
//   );
// }

void topUpModalBottomSheet(BuildContext topUpContext) {
  final textInput = TextEditingController();
  final description = TextEditingController();
  final amount = TextEditingController();

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
    context: topUpContext,
    builder: (ctx) {
      return Builder(
        builder: (BuildContext context) {
          return Consumer<WalletProvider>(
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
                            horizontal: 17, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Color(0xff262F56),
                                  ),
                                ),
                                const Spacer(),
                                const Center(
                                  child: Text(
                                    "Fund wallet",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    'Amount',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[800],
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: amount,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: AppColor.gray9, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1),
                                      ),
                                      hintText: 'Enter amount',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[400],
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (amount.text.isNotEmpty) {
                                      // HundredPay.makePayment(
                                      //     customerEmail:
                                      //         'gideongabriel557@gmail.com',
                                      //     customerPhoneNumber: '09034297703',
                                      //     customerName: 'Gideon\'s Business',
                                      //     customerUserId: '123',
                                      //     amount: amount.text,
                                      //     userId: '1234',
                                      //     refId: '3472',
                                      //     description: 'description',
                                      //     apiKey:
                                      //         'LIVE;PK;eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHBJZCI6IjY1OTlhNGY0NTU2MDMyMDAyYjJiNTFjZSIsInVzZXJJZCI6IjY1OTlhNGY0NTU2MDMyMDAyYjJiNTFjOSIsImlhdCI6MTcwNDU2ODA1Mn0.s4Cb2vUgyTeYhseZtMkqAlt8TE4nu2an_PTOA8ZSlwE',
                                      //     currency: 'NGN',
                                      //     country: 'NG',
                                      //     chargeSource: 'charge',
                                      //     callBackUrl: 'api',
                                      //     onError: (error) {},
                                      //     context: context);

                                      // Navigator.pop(context);
                                      HundredPay.makePayment(
                                          amount: amount.text,
                                          onError: (error) {},
                                          context: context);
                                      // wallet
                                      //     .fundWallet(
                                      //   amount: amount.text,
                                      //   context: topUpContext,
                                      // )
                                      //     .then((value) {
                                      //   return showModalBottomSheet(
                                      //     context: context,
                                      //     builder: (context) {
                                      //       if (wallet.isloading) {
                                      //         return CircularProgressIndicator();
                                      //       } else {
                                      //         return Text(wallet.res);
                                      //       }
                                      //     },
                                      //   );
                                      // });
                                    } else {
                                      error(context,
                                          message: "All fields are required");
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Continue",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppColor.gray1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: AppColor.gray9,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
          );
        },
      );
    },
  );
}

checkoutModalBottomSheet(context) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              12,
            ),
            topLeft: Radius.circular(12))),
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xff262F56),
                    ),
                  ),
                  const Spacer(),
                  const Center(
                      child: Text(
                    "Fund wallet",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  )),
                  const Spacer(),
                ],
              ),
              // ListTile(leading: ),
              PageService.textSpaceL,
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text('',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.gray8,
                          fontSize: 14))),
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: '0.00',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.gray4),
                  contentPadding:
                      const EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColor.gray2, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColor.gray2, width: 1),
                  ),
                ),
              ),
              PageService.textSpacexxL,
              PageService.textSpacexxL,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColor.gray1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: AppColor.gray9,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              PageService.textSpacexxL,
              PageService.textSpacexxL,
            ],
          ),
        ),
      );
    },
  );
}

campaignEndedDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Rating Like 1.png'),
              Text(
                textAlign: TextAlign.center,
                'Caimpaign ended',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 30),
                child: Text(
                  'You have been rewarded with a voucher.',
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xfff20732),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 60,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      'View Vouchers',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

congratulationDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      title: Image.asset('assets/images/congratulationpopup.png'),
      // content: const Text(
      //   textAlign: TextAlign.center,
      //   'Congratulations!',
      //   style: TextStyle(fontSize: 15),
      // ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                textAlign: TextAlign.center,
                'Congratulations!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 30),
                child: Text('You won the product'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xfff20732),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 60,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Proceed to claim',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

joinContestDialog(BuildContext context, int tapCounts, String contestId) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: const Text(
        textAlign: TextAlign.center,
        'Join Contest',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      content: Text(
        textAlign: TextAlign.center,
        'You have a total of $tapCounts clicks, each lasts 10 seconds and the last to click wins the product.',
        style: TextStyle(fontSize: 15),
      ),
      actions: [
        Consumer<HomeProvider>(builder: (context, homeProvider, child) {
          return customButton(
            context,
            onTap: () {
              homeProvider.joinContest(
                tapCount: tapCounts.toString(),
                contestId: contestId,
              );
            },
            text: "Start",
            bgColor: AppColor.primaryColor,
          );
        })
      ],
    ),
  );
}

topupDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
          const Text(
            textAlign: TextAlign.center,
            'Top Up',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                topUpModalBottomSheet(context);
              },
              icon: const Icon(
                CupertinoIcons.xmark,
                size: 16,
                weight: 15,
              ))
        ],
      ),
      content: const Text(
        textAlign: TextAlign.center,
        'You have Insufficient balance. Fund your wallet to keep the fun going!',
        style: TextStyle(fontSize: 15),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  topUpModalBottomSheet(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xfff20732),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 60,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Fund Wallet',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

topUp(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 52),
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: const Text(
        textAlign: TextAlign.center,
        'Join Contest',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            'Purchase taps to gain access to participate in the contest.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              textAlign: TextAlign.left,
              'Number of taps',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextFormField(
            controller: TextEditingController(text: _counter.toString()),
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Min of 2',
              hintStyle: TextStyle(color: Color(0xff858585)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffF3F3FD),
                  width: 2,
                  // strokeAlign: BorderSide.strokeAlignOutside,
                  style: BorderStyle.solid,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffF3F3FD),
                  width: 2,
                  // strokeAlign: BorderSide.strokeAlignOutside,
                  style: BorderStyle.solid,
                ),
              ),
              suffixIcon: Top(
                counter: _counter,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
      actions: [
        customButton(context,
            onTap: () {}, text: "Start", bgColor: AppColor.primaryColor)
      ],
    ),
  );
}

List<String> interestList = [
  "Electronics",
  "Phones & Tablets",
  "Fashion",
  "Appliances",
  "Home & Office",
  "Gaming",
  "Musical Instruments",
  "Sporting",
];
bool validateEmail(String email) {
  // Regular expression pattern to match an email address
  String pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(email);
}

var fieldDecoration = CPPFDecoration(
  labelPosition: LabelPosition.top,
  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  hintStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  suffixColor: AppColor.black,
  // innerColor: AppColor.filledColor,
  filled: true,
  suffixIcon: Icons.arrow_drop_down,
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColor.gray2, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColor.gray2, width: 2),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppColor.gray2, width: 2),
  ),
);
final bottomSheetDecoration = CPPBSHDecoration(
  closeColor: AppColor.gray9,
  itemDecoration: BoxDecoration(
    color: Colors.grey.withOpacity(0.03),
    borderRadius: BorderRadius.circular(8),
  ),
  itemsPadding: const EdgeInsets.all(8),
  itemsSpace: const EdgeInsets.symmetric(vertical: 4),
  itemTextStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  shape: RoundedRectangleBorder(
    side: BorderSide(color: Colors.grey.withOpacity(0.1)),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  ),
);
final searchDecoration = CPPSFDecoration(
  height: 45,
  padding: const EdgeInsets.symmetric(
    vertical: 2,
    horizontal: 10,
  ),
  filled: true,

  margin: const EdgeInsets.symmetric(vertical: 8),
  hintStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w400,
  ),
  searchIconColor: Colors.white,
  textStyle: const TextStyle(color: Colors.white, fontSize: 12),
  // innerColor: Colors.deepOrangeAccent,
  innerColor: AppColor.primaryColor,
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10),
  ),
);

String getAcronym(String fullname) {
  try {
    var split = fullname.trim().split(' ');
    if (split.length > 1) {
      var splitString = '';
      for (var item in split) {
        if (item.trim().isNotEmpty) {
          if (splitString.length == 2) {
            return splitString;
          }
          splitString += item[0][0];
        }
      }
      return splitString.toUpperCase();
    } else {
      return 'ML';
    }
  } on Exception catch (e) {
    // TODO
    return "ML";
  }
}

class ImageHelper {
  static Widget getImage(String uri,
      {double height = 0,
      double width = 0,
      BoxFit boxFit = BoxFit.cover,
      String? placeholderImage,
      FontWeight placeholderWeight = FontWeight.bold,
      Color placeholderColor = primaryColor,
      Color placeholderBackgroundColor = placeholderBackground,
      double fontSize = 15,
      bool isCircular = true}) {
    placeholderImage ??= "...";

    if (uri.isNotEmpty) {
      final image = CachedNetworkImage(
        alignment: Alignment.center,
        fadeInDuration: const Duration(milliseconds: 0),
        placeholderFadeInDuration: const Duration(milliseconds: 0),
        fadeOutDuration: const Duration(milliseconds: 0),
        fit: boxFit,
        height: height,
        width: width,
        imageUrl: uri,
        placeholder: (c, u) => placeHolderWidget(placeholderImage,
            placeholderWeight: placeholderWeight,
            placeholderColor: placeholderColor,
            fontSize: fontSize,
            isCircular: isCircular,
            width: width,
            height: height,
            placeholderBackgroundColor: placeholderBackgroundColor),
        errorWidget: (context, url, error) => placeHolderWidget(
            placeholderImage,
            placeholderWeight: placeholderWeight,
            placeholderColor: placeholderColor,
            fontSize: fontSize,
            isCircular: isCircular,
            width: width,
            height: height,
            placeholderBackgroundColor: placeholderBackgroundColor),
      );
      return image;
    } else {
      return placeHolderWidget(placeholderImage,
          placeholderWeight: placeholderWeight,
          placeholderColor: placeholderColor,
          width: width,
          height: height,
          fontSize: fontSize,
          isCircular: isCircular,
          placeholderBackgroundColor: placeholderBackgroundColor);
    }
  }

  static Widget placeHolderWidget(String? placeholderImage,
      {FontWeight placeholderWeight = FontWeight.bold,
      Color placeholderColor = primaryColor,
      double fontSize = 13,
      Color placeholderBackgroundColor = placeholderBackground,
      bool isCircular = true,
      double width = 0,
      double height = 0}) {
    if (isCircular) {
      return CircleAvatar(
        backgroundColor: placeholderBackgroundColor,
        radius: width * 0.5,
        child: Text(
          placeholderImage!,
          style: TextStyle(
              color: placeholderColor,
              fontWeight: placeholderWeight,
              fontSize: fontSize),
        ),
      );
    } else {
      return Container(
        height: height,
        color: placeholderBackgroundColor,
        alignment: Alignment.center,
        child: Text(
          placeholderImage!,
          style: TextStyle(
              color: placeholderColor,
              fontWeight: placeholderWeight,
              fontSize: fontSize),
        ),
      );
    }
  }

  static String getImageLocation(String imageName, String folderName) {
    return 'https://firebasestorage.googleapis.com/v0/b/bookseven-test.appspot.com/o/$folderName%2F$imageName?alt=media&token=1f9c66a8-0d39-4b55-8017-3b931c7b8c8c';
  }
}
