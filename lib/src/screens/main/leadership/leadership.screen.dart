import 'package:contest_app/src/export/export.dart';
import 'package:contest_app/src/screens/main/leadership/component/alltime.screen.dart';
import 'package:contest_app/src/screens/main/leadership/component/ranked.dart';
import 'package:contest_app/src/screens/main/leadership/component/today.screen.dart';
import 'package:contest_app/src/screens/main/leadership/component/week.screen.dart';
import 'package:contest_app/src/src.dart';
import 'package:contest_app/src/utils/leadership.profile.dart';

class LeadershipScreen extends StatefulWidget {
  const LeadershipScreen({super.key});

  @override
  State<LeadershipScreen> createState() => _LeadershipScreenState();
}

class _LeadershipScreenState extends State<LeadershipScreen> {
  int selectedOption = 0;
  Future<void> homepage() async {
    await Provider.of<LeaderboardProvider>(context, listen: false)
        .fetchLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaderboardProvider>(builder: (context, provider, _) {
      var leadership = provider.leaderboard;

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Leadership',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body:
            // Center(
            //   child: Image.asset('assets/images/comingsoon.png'),
            // )
            RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          color: Colors.white,
          backgroundColor: Colors.red,
          onRefresh: homepage,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 54),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOption = 0;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: selectedOption == 0
                                      ? null
                                      : Border.all(
                                          color:
                                              Color.fromRGBO(235, 235, 235, 1),
                                        ), // Show border if selectedOption is not 0
                                  color: selectedOption == 0
                                      ? AppColor.primaryColor
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  "Today",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: selectedOption == 0
                                        ? Color.fromRGBO(255, 255, 255, 1)
                                        : Color.fromRGBO(71, 71, 71, 1),
                                    fontFamily: 'SpaceGrotesk',
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOption = 1;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: selectedOption == 1
                                      ? null
                                      : Border.all(
                                          color:
                                              Color.fromRGBO(235, 235, 235, 1),
                                        ), // Show border if selectedOption is not 1
                                  color: selectedOption == 1
                                      ? AppColor.primaryColor
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  "Week",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: selectedOption == 1
                                        ? Color.fromRGBO(255, 255, 255, 1)
                                        : Color.fromRGBO(71, 71, 71, 1),
                                    fontFamily: 'SpaceGrotesk',
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedOption = 2;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: selectedOption == 2
                                      ? null
                                      : Border.all(
                                          color:
                                              Color.fromRGBO(235, 235, 235, 1),
                                        ), // Show border if selectedOption is not 1
                                  color: selectedOption == 2
                                      ? AppColor.primaryColor
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  "All time",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: selectedOption == 2
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'SpaceGrotesk',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      PageService.textSpacexxL,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 21),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Expanded(
                      //         child: Stack(
                      //           alignment: Alignment.bottomCenter,
                      //           children: [
                      //             CircleAvatar(
                      //               radius: 68,
                      //               backgroundColor: Colors.white,
                      //               child: CircleAvatar(
                      //                 radius: 43,
                      //                 backgroundColor: const Color(0xfff3f4f6),
                      //                 child: CircleAvatar(
                      //                     backgroundColor:
                      //                         const Color(0xffE5E7EB),
                      //                     radius: 38,
                      //                     child: ClipOval(
                      //                       child: Image.asset(
                      //                         'assets/images/boyface.png',
                      //                         fit: BoxFit.cover,
                      //                         height: 100,
                      //                       ),
                      //                     )),
                      //               ),
                      //             ),
                      //             Positioned(
                      //               top: 90,
                      //               child: CircleAvatar(
                      //                 backgroundColor: Color.fromRGBO(
                      //                   214,
                      //                   214,
                      //                   214,
                      //                   1,
                      //                 ),
                      //                 radius: 13,
                      //                 child: Image.asset(
                      //                   'assets/images/Fame2.png',
                      //                 ),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         width: 25,
                      //       ),
                      //       Expanded(
                      //         child: Stack(
                      //           alignment: Alignment.bottomCenter,
                      //           children: [
                      //             ProfilePicture(),
                      //             Positioned(
                      //               top: 100,
                      //               child: CircleAvatar(
                      //                 radius: 16,
                      //                 backgroundColor: const Color(0xfffbbf24),
                      //                 child:
                      //                     Image.asset('assets/images/Frame1.png'),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         width: 25,
                      //       ),
                      //       Expanded(
                      //         child: Stack(
                      //           alignment: Alignment.bottomCenter,
                      //           children: [
                      //             CircleAvatar(
                      //               radius: 68,
                      //               backgroundColor: Colors.white,
                      //               child: CircleAvatar(
                      //                 radius: 43,
                      //                 backgroundColor: const Color(0xff96d4f6),
                      //                 child: CircleAvatar(
                      //                     backgroundColor:
                      //                         const Color(0xffE5E7EB),
                      //                     radius: 38,
                      //                     child: ClipOval(
                      //                       child: Image.asset(
                      //                         'assets/images/boyface.png',
                      //                         fit: BoxFit.cover,
                      //                         height: 100,
                      //                       ),
                      //                     )),
                      //               ),
                      //             ),
                      //             Positioned(
                      //               top: 100,
                      //               child: CircleAvatar(
                      //                 backgroundColor: const Color(0xff0097ec),
                      //                 radius: 13,
                      //                 child: Image.asset(
                      //                   'assets/images/Frame3.png',
                      //                 ),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),

                      LeadershipRanked(),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
              [
                TodayScreen(),
                WeekScreen(),
                AllTimeScreen(),
              ][selectedOption],
            ],
          ),
        ),
      );
    });
  }
}
