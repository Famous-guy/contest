// import 'package:contest_app/src/src.dart';
// import 'package:flutter/material.dart';

// class LeadershipRanked extends StatelessWidget {
//   const LeadershipRanked({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<LeaderboardProvider>(builder: (context, ranked, _) {
//       var leadership = ranked.leaderboard;
//       final index = leadership.length;
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 21),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // for (int index = 0; index < leadership.length; index++)
//             Expanded(
//               child: Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   CircleAvatar(
//                     radius: 68,
//                     backgroundColor: Colors.white,
//                     child: CircleAvatar(
//                       radius: 43,
//                       backgroundColor: const Color(0xfff3f4f6),
//                       child: CircleAvatar(
//                           backgroundColor: const Color(0xffE5E7EB),
//                           radius: 38,
//                           child: ClipOval(
//                             child: Image.network(
//                               index == 1
//                                   ? 'https://robohash.org/${leadership[1].userDetails?.username}.png?size=100x100&set=set1'
//                                   : 'https://robohash.org/default.png?size=100x100&set=set1',
//                               fit: BoxFit.cover,
//                               height: 100,
//                             ),
//                           )),
//                     ),
//                   ),
//                   Positioned(
//                     top: 90,
//                     child: CircleAvatar(
//                       backgroundColor: Color.fromRGBO(
//                         214,
//                         214,
//                         214,
//                         1,
//                       ),
//                       radius: 13,
//                       child: Image.asset(
//                         'assets/images/Fame2.png',
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 25,
//             ),
//             Expanded(
//               child: Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   // for (int index = 0; index < leadership.length; index++)
//                   CircleAvatar(
//                     radius: 68,
//                     backgroundColor: const Color(0xfffae388),
//                     child: CircleAvatar(
//                       radius: 55,
//                       backgroundColor: const Color(0xfffae388),
//                       child: CircleAvatar(
//                         backgroundColor: const Color(0xffE5E7EB),
//                         radius: 50,
//                         child: ClipOval(
//                           child: Image.network(
//                             index == 0
//                                 ? 'https://robohash.org/${leadership[0].userDetails?.username}.png?size=100x100&set=set1'
//                                 : 'https://robohash.org/default.png?size=100x100&set=set1',
//                             fit: BoxFit.cover,
//                             height: 100,
//                           ),
//                           // Image.asset(
//                           //   'assets/images/boyface.png',
//                           //   fit: BoxFit.cover,
//                           //   height: 100,
//                           // ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 100,
//                     child: CircleAvatar(
//                       radius: 16,
//                       backgroundColor: const Color(0xfffbbf24),
//                       child: Image.asset('assets/images/Frame1.png'),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 25,
//             ),
//             Expanded(
//               child: Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   // for (int index = 0; index < leadership.length; index++)
//                   CircleAvatar(
//                     radius: 68,
//                     backgroundColor: Colors.white,
//                     child: CircleAvatar(
//                       radius: 43,
//                       backgroundColor: const Color(0xff96d4f6),
//                       child: CircleAvatar(
//                           backgroundColor: const Color(0xffE5E7EB),
//                           radius: 38,
//                           child: ClipOval(
//                             child: Image.network(
//                               index == 2
//                                   ? 'https://robohash.org/${leadership[2].userDetails?.username}.png?size=100x100&set=set1'
//                                   : 'https://robohash.org/default.png?size=100x100&set=set1',
//                               fit: BoxFit.cover,
//                               height: 100,
//                             ),
//                             // Image.asset(
//                             //   'assets/images/boyface.png',
//                             //   fit: BoxFit.cover,
//                             //   height: 100,
//                             // ),
//                           )),
//                     ),
//                   ),
//                   Positioned(
//                     top: 100,
//                     child: CircleAvatar(
//                       backgroundColor: const Color(0xff0097ec),
//                       radius: 13,
//                       child: Image.asset(
//                         'assets/images/Frame3.png',
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       );
//     });
//   }
// }

import 'package:contest_app/src/src.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contest_app/src/providers/leadership.provider.dart';

class LeadershipRanked extends StatelessWidget {
  const LeadershipRanked({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaderboardProvider>(
      builder: (context, ranked, _) {
        var leadership = ranked.leaderboard;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildAvatar(1, leadership),
              buildAvatar(0, leadership),
              buildAvatar(2, leadership),
            ],
          ),
        );
      },
    );
  }

  Widget buildAvatar(int index, List<LeaderboardEntry> leadership) {
    if (index >= leadership.length) {
      // Return an empty container if the index is out of bounds
      return Container();
    }

    final UserDetails? userDetails = leadership[index].userDetails;
    final String username = userDetails?.username ?? 'default';
    final String imageUrl =
        'https://robohash.org/$username.png?size=100x100&set=set1';
    final bool isMiddle = index == 0;
    final bool second = index == 2;

    return Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CircleAvatar(
            radius: isMiddle ? 68 : 55, // Adjust radius for middle avatar
            backgroundColor: isMiddle ? const Color(0xfffae388) : Colors.white,
            child: CircleAvatar(
              radius: isMiddle ? 55 : 43, // Adjust radius for middle avatar
              backgroundColor: isMiddle
                  ? const Color(0xfffae388)
                  : second
                      ? Color.fromRGBO(150, 212, 246, 1)
                      : Color.fromRGBO(243, 244, 246, 1),
              child: CircleAvatar(
                backgroundColor: const Color(0xffE5E7EB),
                radius: isMiddle ? 50 : 38, // Adjust radius for middle avatar
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    height: 100,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: isMiddle ? 105 : 80, // Adjust position for middle avatar
            child: CircleAvatar(
              radius: isMiddle ? 16 : 13, // Adjust radius for middle avatar
              backgroundColor: isMiddle
                  ? const Color(0xfffbbf24)
                  : second
                      ? Color.fromRGBO(150, 212, 246, 0.5)
                      : Color.fromRGBO(235, 235, 235, 1),
              child: isMiddle
                  ? Image.asset('assets/images/Frame1.png')
                  : second
                      ? Image.asset('assets/images/Frame3.png')
                      : Image.asset('assets/images/Fame2.png'),
            ),
          )
        ],
      ),
    );
  }
}
