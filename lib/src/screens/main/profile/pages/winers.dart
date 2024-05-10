// // import 'package:contest_app/src/export/export.dart';
// // import 'package:contest_app/src/providers/profile.provider.dart';
// // import 'package:contest_app/src/src.dart';
// // import 'package:provider/provider.dart';

// // class Winners extends StatelessWidget {
// //   const Winners({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer<ProfileProvider>(builder: (context, provider, child) {
// //       return Scaffold(
// appBar: AppBar(
//   title: Text('Contests won'),
//   actions: [
//     Padding(
//       padding: const EdgeInsets.only(right: 15.0),
//       child: ImageIcon(AssetImage('assets/images/Search.png')),
//     )
//   ],
// ),
// //         body: SafeArea(
// //           child: FutureBuilder(
// //               future: provider.getUsersWonContests(),
// //               builder: (context, snapshot) {
// //                 if (snapshot.connectionState == ConnectionState.waiting) {
// //                   return Center(
// //                     child: CircularProgressIndicator(),
// //                   );
// //                 }
// //                 // else if (snapshot.data!.isEmpty) {
// //                 //   return Center(
// //                 //     child: Text(provider.responseMessage),
// //                 //   );
// //                 // }
// //                 else if (snapshot.data == null) {
// //                   return Center(
// //                     child: Text("No data"),
// //                   );
// //                 }
// //                 return ListView.builder(
// //                   itemCount: snapshot.data!.length,
// //                   itemBuilder: (context, index) {
// //                     return MyWidget(wonImage: "wonImage", label: "label");
// //                   },
// //                 );
// //               }),
// //         ),
// //       );
// //     });
// //   }
// // }

// import 'package:contest_app/src/providers/won.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // import 'contest_provider.dart';
// // import 'contest_modal.dart';

// class ContestScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contest Screen'),
//       ),
//       body: FutureBuilder(
//           future: Provider.of<ContestProvider>(context, listen: false)
//               .fetchContestData(),
//           builder: (ctx, snapshot) {
// // snapshot.connectionState == ConnectionState.waiting
// //                 ? Center(child: CircularProgressIndicator())
// //                 : snapshot.error != null
// //                     ? Center(child: Text('An error occurred!'))
// //                     : ContestDetails(),

//             if (snapshot.hasData) {
//               return ContestDetails();
//             }
//             return Center(child: CircularProgressIndicator());
//           }),
//     );
//   }
// }

// class ContestDetails extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final contestData = Provider.of<ContestProvider>(context).contestData!;

//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Product Name: ${contestData.productName}'),
//           Text('Video URL: ${contestData.videoURL}'),
//           Text('Currency: ${contestData.currency}'),
//           // Add more details as needed
//         ],
//       ),
//     );
//   }
// }

import 'package:contest_app/src/constants/currencies.dart';
import 'package:contest_app/src/models/wonmodal.dart';
import 'package:contest_app/src/providers/won.dart';
import 'package:contest_app/src/src.dart';
import 'package:contest_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// import 'contest_provider.dart';
// import 'contest_modal.dart';

class ContestScreen extends StatefulWidget {
  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {
  @override
  void initState() {
    super.initState();
    getContest();
  }

  Future<void> getContest() async {
    await Provider.of<ContestProvider>(context, listen: false)
        .fetchContestData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      color: Colors.white,
      backgroundColor: Colors.red,
      onRefresh: getContest,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Contests won'),
        ),
        body: Consumer<ContestProvider>(
          builder: (context, value, child) {
            var data = value.contests;
            if (value.isLoading) {
              return Center(
                  child: SpinKitFadingCircle(
                color: Colors.red,
                size: 50,
              ));
            } else if (value.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ContestList(),

                //  FutureBuilder(
                //   future: Provider.of<ContestProvider>(context, listen: false)
                //       .fetchContestData(),
                //   builder: (ctx, snapshot) =>
                //       snapshot.connectionState == ConnectionState.waiting
                //           ? Center(child: CircularProgressIndicator())
                //           : snapshot.error != null
                //               ? Center(child: Text('An error occurred!'))
                //               : ContestList(),
                // ),
              );
            } else {
              return Center(child: Text('You have not won any contests.'));
            }
            // return
          },
          // child: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24),
          //   child: ContestList(),
          //   You have not won any contests.
          //   //  FutureBuilder(
          //   //   future: Provider.of<ContestProvider>(context, listen: false)
          //   //       .fetchContestData(),
          //   //   builder: (ctx, snapshot) =>
          //   //       snapshot.connectionState == ConnectionState.waiting
          //   //           ? Center(child: CircularProgressIndicator())
          //   //           : snapshot.error != null
          //   //               ? Center(child: Text('An error occurred!'))
          //   //               : ContestList(),
          //   // ),
          // ),
        ),
      ),
    );
  }
}

class ContestList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ContestModal> contests =
        Provider.of<ContestProvider>(context).contests;

    return ListView.builder(
      itemCount: contests.length,
      itemBuilder: (ctx, index) => ContestItem(contests[index]),
    );
  }
}

class ContestItem extends StatefulWidget {
  final ContestModal contest;

  ContestItem(this.contest);

  @override
  State<ContestItem> createState() => _ContestItemState();
}

class _ContestItemState extends State<ContestItem> {
  String currencySymbol = '';
  String getCurrencySymbol(String? currency) {
    if (currency != null && currencies.containsKey(currency)) {
      return currencies[currency]!;
    } else {
      return ''; // Return empty string if currency not found
    }
  }

  @override
  Widget build(BuildContext context) {
    currencySymbol = getCurrencySymbol(widget.contest.currency);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(bottom: 10),
      // elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   width: 123,
            //   height: 79,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child:
            Expanded(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // Adjust the radius as needed
                child: Image.network(
                  '${widget.contest.videoURL}',
                  fit: BoxFit.cover,
                  height: 85,
                ),
              ),
            ),

            // ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     CircleAvatar(
                  //       radius: 10,
                  //       backgroundImage: AssetImage(brandImage),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     Text(
                  //       labelName,
                  //       // style: PageService.bigHeaderStylebold2, // Style not provided, replace with your style
                  //     )
                  //   ],
                  // ),
                  const SizedBox(height: 6),

                  Text(
                    widget.contest.productName,
                    style: TextStyle(
                        color: Color.fromRGBO(92, 92, 92, 1),
                        fontSize: 16,
                        // letterSpacing: 1,
                        fontFamily: 'SpaceGrotesk',
                        fontWeight: FontWeight.w700),
                    // style: PageService.bigHeaderStyle2, // Style not provided, replace with your style
                  ),

                  const SizedBox(height: 2),
                  Text(
                    DateFormat.yMMMMd()
                        .format(DateTime.parse(widget.contest.startTime)),
                    style: TextStyle(
                        color: Color.fromRGBO(133, 133, 133, 1),
                        fontSize: 12,
                        // letterSpacing: 1,
                        fontFamily: 'SpaceGrotesk',
                        fontWeight: FontWeight.w500),
                    // style: PageService.bigHeaderStyle2, // Style not provided, replace with your style
                  ),
                  // Text.rich(TextSpan(
                  //   children: [
                  //     TextSpan(
                  //         text: 'Time remaining: ',
                  //         style: PageService.bigHeaderStylebold2
                  //         // style: PageService.bigHeaderStylebold2, // Style not provided, replace with your style
                  //         ),
                  //     TextSpan(
                  //         text: contest.productName,
                  //         style: PageService.bigHeaderStyle2
                  //         // style: PageService.bigHeaderStyle2, // Style not provided, replace with your style
                  //         ),
                  //   ],
                  // )),
                  const SizedBox(height: 3),

                  Text(
                    widget.contest.productCode,
                    style: TextStyle(
                        color: Color.fromRGBO(133, 133, 133, 1),
                        fontSize: 12,
                        // letterSpacing: 1,
                        fontFamily: 'SpaceGrotesk',
                        fontWeight: FontWeight.w500),
                    // style: PageService.bigHeaderStyle2, // Style not provided, replace with your style
                  ),
                  // Text(
                  //   widget.contest.category,
                  //   style: TextStyle(
                  //       color: Color.fromRGBO(133, 133, 133, 1),
                  //       fontSize: 18,
                  //       letterSpacing: 1,
                  //       fontFamily: 'SpaceGrotesk',
                  //       fontWeight: FontWeight.w500),
                  //   // style: PageService.bigHeaderStyle2, // Style not provided, replace with your style
                  // ),

                  // const SizedBox(height: 3),
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: GestureDetector(
                  //     onTap: () {},
                  //     child: Text(
                  //       joinClosed,
                  //       style: TextStyle(
                  //         color: myColor,
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Text(
              '${currencySymbol}${double.parse((widget.contest.amount).toStringAsFixed(2))}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(242, 7, 50, 1),
                  fontSize: 16,
                  letterSpacing: 1,
                  fontFamily: 'SpaceGrotesk',
                  fontWeight: FontWeight.w700
                  // style: PageService.bigHeaderStyle2, // Style not provided, replace with your style

                  ),
            )
          ],
        ),
      ),
    );

    // ListTile(
    //   title: Text(contest.productName),
    //   subtitle: Text('Amount: ${contest.amount} ${contest.currency}'),
    //   onTap: () {
    //     // Handle tap on the contest item
    //   },
    // );
  }
}
