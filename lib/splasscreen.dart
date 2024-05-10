// import 'package:contest_app/export/export.dart';
// import 'package:contest_app/proivders/database_provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     ApiCall api = ApiCall();
//     api.request();
//     navigate();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColor.primaryColor,
//       ),
//       backgroundColor: AppColor.primaryColor,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset(
//                               'assets/images/contest.png',
//                             ),
//                             PageService.textSpaceL,
//                             Text(
//                               "Play & Win",
//                               style: TextStyle(
//                                   fontSize: 38,
//                                   fontWeight: FontWeight.w500,
//                                   color: AppColor.white),
//                             ),
//                             PageService.textSpace,
//                             Text(
//                               "Making black friday an experience.",
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                   color: AppColor.ghostWhite),
//                             ),
//                             PageService.textSpaceL,
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                           child: Image.asset(
//                         "assets/images/100pay.png",
//                       ))
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           nextPage(context, page: const SignUp());
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 30, vertical: 10),
//                           decoration: BoxDecoration(
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(50)),
//                               border: Border.all(color: AppColor.white)),
//                           child: Text(
//                             "GET STARTED",
//                             style: TextStyle(
//                                 color: AppColor.white,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 12),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 40,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           PageService().showSnackBar(context, 'Coming soon');
//                         },
//                         child: Text(
//                           "LEARN MORE",
//                           style: TextStyle(
//                               color: AppColor.white,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//           const Align(
//             alignment: Alignment.bottomRight,
//             child: Row(
//               children: [
//                 Spacer(),
//                 Expanded(
//                   child: Image(
//                     image: AssetImage('assets/images/lady.png'),
//                     width: 270,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   void navigate() {
//     Future.delayed(const Duration(seconds: 2), () {
//       DatabaseProvider().getToken().then((token) {
//         if (token != "") {
//           nextPageAndRemovePrevious(context, page:  MainActivityPage());
//         } else {
//           nextPageAndRemovePrevious(context, page: const WelcomeBack());
//         }
//       });
//     });
//   }
// }
