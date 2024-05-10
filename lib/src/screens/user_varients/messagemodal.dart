// import 'package:contest_app/screens/user_varients/message.dart';
// import 'package:contest_app/screens/user_varients/messageprovider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class YourWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<User> messages = Provider.of<MessageProvider>(context).messages;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: messages.map((message) {
//         return Container(
//             padding: EdgeInsets.symmetric(horizontal: 36, vertical: 40),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 130,
//                   child: Stack(
//                     // fit: StackFit
//                     //     .expand, // Make the Stack fill the entire container
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             style: BorderStyle.solid,
//                             color: Color.fromRGBO(
//                                 253, 230, 138, 1), // Border color
//                             width: 5.222, // Border width
//                           ),
//                         ),
//                         child: CircleAvatar(
//                           backgroundColor: Colors.white,
//                           radius: 50,
//                           backgroundImage: AssetImage(
//                               // message.profilePhoto
//                               'assets/images/sampleicon.png'),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: -30,
//                         left: 0,
//                         right: 0,
//                         child: Image.asset(
//                           'assets/images/stack.png',
//                           // Icons.favorite,
//                           // color: Colors.red,
//                           // size: 24,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Text(
//                   // message.username,
//                   'Chrisdon',
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontFamily: 'SpaceGrotesk',
//                       color: Color.fromRGBO(21, 21, 45, 1),
//                       fontWeight: FontWeight.w700),
//                 ),
//                 Text(
//                   _timerExpired ? 'won $product' : ' Winning this product in',
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontFamily: 'SpaceGrotesk',
//                       color: Color.fromRGBO(21, 21, 45, 1),
//                       fontWeight: FontWeight.w400),
//                 ),
//                 SizedBox(
//                   height: 24,
//                 ),
//                 Visibility(
//                   visible: !_timerExpired,
//                   child: buildTimer(),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     if (_timerExpired || tapCounter == 0) {
//                       return;
//                     }
//                     _timerExpired
//                         ? print('Won')
//                         : seconds <= 0
//                             ? null
//                             : _sendMessage();

//                     print(isConnected);
//                     // startTimer();
//                     // _startTimer();
//                     // setState(() {
//                     //   if (seconds <= 0 &&
//                     //       isConnected == false) {
//                     //     return;
//                     //   } else {
//                     //     tapCounter--;
//                     //   }

//                     //   if (tapCounter == 0) {
//                     //     // Disable the button when the counter reaches zero
//                     //     tapCounter =
//                     //         0; // Ensure tapCounter does not go negative
//                     //   }
//                     // });
//                     if (tapCounter == 0) {
//                       // Perform any action when the counter reaches zero
//                       print('Button disabled');
//                     }
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     width: MediaQuery.of(context).size.width,
//                     padding: const EdgeInsets.symmetric(vertical: 13),
//                     decoration: BoxDecoration(
//                       color: !canJoinContest || tapCounter == 0
//                           ? _timerExpired
//                               ? AppColor.primaryColor
//                               : Color(0xffA5B0C1)
//                           : AppColor.primaryColor,
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     child: _timerExpired
//                         ? Text(
//                             'View Voucher',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontFamily: 'SpaceGrotesk',
//                                 color: Color.fromRGBO(255, 255, 255, 1),
//                                 fontWeight: FontWeight.w700),
//                           )
//                         : Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Tap to win",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: AppColor.white,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 8,
//                                 ),
//                                 child:
//                                     Image.asset('assets/images/Littlecup.png'),
//                               )
//                             ],
//                           ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: !_timerExpired,
//                   child: SizedBox(
//                     height: 12,
//                   ),
//                 ),
//                 Visibility(
//                     visible: !_timerExpired,
//                     child: Text(
//                       '$tapCounter taps remaining!',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Color.fromRGBO(92, 92, 92, 1),
//                         fontFamily: 'SpaceGrotesk',
//                         fontWeight: FontWeight.w400,
//                       ),
//                     )),
//                 Visibility(
//                   visible: _timerExpired,
//                   child: SizedBox(
//                     height: 12,
//                   ),
//                 ),
//                 Visibility(
//                     visible: _timerExpired,
//                     child: Text(
//                       'Contest ended',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: AppColor.red,
//                         fontFamily: 'SpaceGrotesk',
//                         fontWeight: FontWeight.w500,
//                       ),
//                     )),
//                 Visibility(
//                   visible: _timerExpired,
//                   child: SizedBox(
//                     height: 35,
//                   ),
//                 ),
//                 Visibility(
//                     visible: _timerExpired,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Share',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Color.fromRGBO(21, 21, 45, 1),
//                             fontFamily: 'SpaceGrotesk',
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 8,
//                         ),
//                         Image.asset('assets/images/Share1.png')
//                       ],
//                     )),
//                 Visibility(
//                   visible: _timerExpired,
//                   child: ConfettiWidget(
//                     confettiController: _confettiController,
//                     blastDirectionality: BlastDirectionality.explosive,
//                     numberOfParticles: 20,
//                     gravity: 0.1,
//                     emissionFrequency: 0.05,
//                     maxBlastForce: 100,
//                     minBlastForce: 80,
//                     shouldLoop: false,
//                     colors: const [
//                       Colors.green,
//                       Colors.blue,
//                       Colors.pink,
//                       Colors.orange,
//                       Colors.purple,
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Color.fromRGBO(235, 235, 235, 1),
//                 ),
//                 color: Color.fromRGBO(251, 251, 251, 1),
//                 borderRadius: BorderRadius.circular(20)));

//         // Padding(
//         //   padding: const EdgeInsets.symmetric(vertical: 8.0),
//         //   child: Row(
//         //     crossAxisAlignment: CrossAxisAlignment.start,
//         //     children: [
//         //       CircleAvatar(
//         //         backgroundImage: NetworkImage(message.profilePhoto),
//         //       ),
//         //       SizedBox(width: 8.0),
//         //       Expanded(
//         //         child: Column(
//         //           crossAxisAlignment: CrossAxisAlignment.start,
//         //           children: [
//         //             Text(
//         //               message.username,
//         //               style: TextStyle(fontWeight: FontWeight.bold),
//         //             ),
//         //             SizedBox(height: 4.0),
//         //             Text(message.message),
//         //           ],
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // );
//       }).toList(),
//     );
//   }
// }
