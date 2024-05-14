import 'package:contest_app/src/screens/user_varients/product_details.dart';
import 'package:contest_app/src/src.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  String currencySymbol = '';
  String _formatDuration(Duration duration) {
    return DateFormat('mm:ss')
        .format(DateTime(0, 1, 1, 0, 0, duration.inSeconds));
  }

  int endTime = DateTime.now().millisecondsSinceEpoch;
  late Timer _timer;
  late Duration _duration;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getContest();
  }
  // String formatTimeRemaining(DateTime startTime) {
  //   Duration remainingTime = startTime.difference(DateTime.now());

  //   int days = remainingTime.inDays;
  //   int hours = remainingTime.inHours.remainder(24);
  //   int minutes = remainingTime.inMinutes.remainder(60);
  //   int seconds = remainingTime.inSeconds.remainder(60);

  //   if (days > 0) {
  //     return '$days days';
  //   } else if (hours > 0) {
  //     return '${hours}h ${minutes}m';
  //   } else if (minutes > 0) {
  //     return '${minutes}m ${seconds}s';
  //   } else {
  //     return '${seconds}s';
  //   }
  // }

  String formatTimeRemaining(DateTime startTime) {
    Duration remainingTime = startTime.difference(DateTime.now());

    int days = remainingTime.inDays;
    int hours = remainingTime.inHours.remainder(24);
    int minutes = remainingTime.inMinutes.remainder(60);
    int seconds = remainingTime.inSeconds.remainder(60);

    if (days > 0) {
      return '${days}: ${hours}: ${minutes}: ${seconds}';
    } else if (hours > 0) {
      return '${days}: ${hours}: ${minutes}: ${seconds}';
    } else if (minutes > 0) {
      return '${days}: ${hours}: ${minutes}: ${seconds}';
    } else if (seconds <= 0) {
      return '${0}: ${0}: ${0}: ${0}';
    } else {
      return '';
    }
  }

  void _updateTimer(Timer timer) {
    if (_duration.inSeconds > 0) {
      setState(() {
        _duration -= Duration(seconds: 1);
      });
    } else {
      timer.cancel();

      // setState(() {
      // canJoinContest = true;
      // });
      // Handle countdown end event
    }
  }

  String getCurrencySymbol(String? currency) {
    if (currency != null && currencies.containsKey(currency)) {
      return currencies[currency]!;
    } else {
      return ''; // Return empty string if currency not found
    }
  }

  Future<void> getContest() async {
    await Provider.of<HomeProvider>(context, listen: false)
        .fetchSupportedContests();
    await Provider.of<HomeProvider>(context, listen: false).getPastContests();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 600, // Adjust the max width as needed
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: AppColor.black,
              ),
              centerTitle: true,
              title: Text('Supported Contests'),
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.only(right: 15.0),
              //     child: ImageIcon(AssetImage('assets/images/Search.png')),
              //   )
              // ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(48.0), // Adjust as needed
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: Container(
                    color: Colors.white, // Set background color of TabBar
                    child: TabBar(
                      indicatorColor: Colors.red,
                      labelColor: Colors.red,
                      unselectedLabelColor: Colors
                          .grey, // Add this line to customize unselected label color
                      tabs: <Widget>[
                        Tab(
                          text: 'Upcoming Contests',
                        ),
                        Tab(
                          text: 'Past Contests',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: TabBarView(
                children: [
                  RefreshIndicator(
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    color: Colors.white,
                    backgroundColor: Colors.red,
                    onRefresh: getContest,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Consumer<HomeProvider>(
                          builder: (context, homeProvider, child) {
                        var supported = homeProvider.support;
                        if (homeProvider.iLoading) {
                          return Center(
                              child: SpinKitFadingCircle(
                            color: Colors.red,
                            size: 50,
                          ));
                        } else
                        //  if (homeProvider.hasData)
                        {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: supported.length,
                            itemBuilder: (context, index) {
                              // final Contests product =
                              //     homeProvider.contests[index];
                              var data = supported[index];
                              // _duration = DateTime.parse(data['startTime'])
                              //     .difference(DateTime.now());
                              // _timer = Timer.periodic(
                              //     Duration(seconds: 1), _updateTimer);
                              // endTime = DateTime.parse(data['startTime'])
                              //     .millisecondsSinceEpoch;
                              currencySymbol =
                                  getCurrencySymbol(data['currency']);
                              return GestureDetector(
                                onTap: () {
                                  nextPage1(
                                    context,
                                    page: ProductDetailsScreen(
                                      image: data['videoURL'],
                                      currency: '${currencySymbol}',
                                      amount: data['amount'],
                                      productName: data['productName'],
                                      productId: data['productCode'],
                                      contestId: data['contestId'],
                                      tapCount: data['supporters'].length,
                                      targetTime: DateTime.parse(
                                        data['startTime'].toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  child: SearchFeatures(
                                    myColor: data['completed']
                                        ? Colors.orange
                                        : Colors.red,
                                    joinClosed: data['completed'] == false
                                        ? 'Join Contest'
                                        : 'Close Contest',
                                    category: data['category'],
                                    // labelName: 'Jumia Nigeria',
                                    // brandImage: 'assets/images/jumialogo.png',
                                    image: '${data['videoURL']}',
                                    userProfiles: [],
                                    date: DateFormat.yMMMMd().format(
                                        DateTime.parse(data['startTime'])),
                                    productName: data['productName'],
                                    amount: data['amount'],
                                    currency: currencySymbol,
                                    // time: formatTimeRemaining(
                                    //     DateTime.parse(data['startTime'])),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        // else {
                        //   return Center(
                        //     child: Text('${homeProvider.responseText}'),
                        //   );
                        // }
                        // return

                        //  FutureBuilder(
                        //   future: homeProvider.fetchSupportedContests(),
                        //   builder: (context, snapshot) {
                        //     // if (snapshot.connectionState == ConnectionState.waiting) {
                        //     //   return Center(
                        //     //       child: SpinKitFadingCircle(
                        //     //     color: Colors.red,
                        //     //     size: 50,
                        //     //   ));
                        //     // } else if (snapshot.hasError) {
                        //     //   return Center(
                        //     //     child: Text(
                        //     //         "An error occurred when trying to retrive your upcoming supported contest from the server"),
                        //     //   );
                        //     // } else if (snapshot.data!.isEmpty) {
                        //     //   return Center(
                        //     //     child: Text(homeProvider.responseText),
                        //     //   );
                        //     // } else {
                        //     //   return ListView.builder(
                        //     //     shrinkWrap: true,
                        //     //     itemCount: homeProvider.data.length,
                        //     //     itemBuilder: (context, index) {
                        //     //       // final Contests product =
                        //     //       //     homeProvider.contests[index];
                        //     //       var data = homeProvider.data[index];
                        //     //       // _duration = DateTime.parse(data['startTime'])
                        //     //       //     .difference(DateTime.now());
                        //     //       // _timer = Timer.periodic(
                        //     //       //     Duration(seconds: 1), _updateTimer);
                        //     //       // endTime = DateTime.parse(data['startTime'])
                        //     //       //     .millisecondsSinceEpoch;
                        //     //       currencySymbol = getCurrencySymbol(data['currency']);
                        //     //       return GestureDetector(
                        //     //         onTap: () {
                        //     //           nextPage1(
                        //     //             context,
                        //     //             page: ProductDetailsScreen(
                        //     //               currency: '$currencySymbol',
                        //     //               amount: data['amount'],
                        //     //               productName: data['productName'],
                        //     //               productId: data['productCode'],
                        //     //               contestId: data['contestId'],
                        //     //               tapCount: data['supporters'].length,
                        //     //               targetTime: DateTime.parse(
                        //     //                 data['startTime'].toString(),
                        //     //               ),
                        //     //             ),
                        //     //           );
                        //     //         },
                        //     //         child: Container(
                        //     //           child: SearchFeatures(
                        //     //             myColor: data['completed']
                        //     //                 ? Colors.orange
                        //     //                 : Colors.red,
                        //     //             joinClosed: data['completed'] == false
                        //     //                 ? 'Join Contest'
                        //     //                 : 'Close Contest',
                        //     //             category: data['category'],
                        //     //             // labelName: 'Jumia Nigeria',
                        //     //             // brandImage: 'assets/images/jumialogo.png',
                        //     //             image: 'assets/images/producticon.png',
                        //     //             userProfiles: [],
                        //     //             date: DateFormat.yMMMMd()
                        //     //                 .add_jm()
                        //     //                 .format(DateTime.parse(data['startTime'])),
                        //     //             productName: data['productName'],
                        //     //             time: formatTimeRemaining(
                        //     //                 DateTime.parse(data['startTime'])),
                        //     //           ),
                        //     //         ),
                        //     //       );
                        //     //     },
                        //     //   );

                        //     //   // return ListView.builder(
                        //     //   //   itemCount: snapshot.data!.length,
                        //     //   //   itemBuilder: (context, index) {
                        //     //   //     return VoucherWidget(voucher: snapshot.data![index]);
                        //     //   //   },
                        //     //   // );
                        //     // }
                        //     if (snapshot.hasData) {
                        //       return ListView.builder(
                        //         shrinkWrap: true,
                        //         itemCount: homeProvider.data.length,
                        //         itemBuilder: (context, index) {
                        //           // final Contests product =
                        //           //     homeProvider.contests[index];
                        //           var data = homeProvider.data[index];
                        //           // _duration = DateTime.parse(data['startTime'])
                        //           //     .difference(DateTime.now());
                        //           // _timer = Timer.periodic(
                        //           //     Duration(seconds: 1), _updateTimer);
                        //           // endTime = DateTime.parse(data['startTime'])
                        //           //     .millisecondsSinceEpoch;
                        //           currencySymbol =
                        //               getCurrencySymbol(data['currency']);
                        //           return GestureDetector(
                        //             onTap: () {
                        //               nextPage1(
                        //                 context,
                        //                 page: ProductDetailsScreen(
                        //                   currency: '$currencySymbol',
                        //                   amount: data['amount'],
                        //                   productName: data['productName'],
                        //                   productId: data['productCode'],
                        //                   contestId: data['contestId'],
                        //                   tapCount: data['supporters'].length,
                        //                   targetTime: DateTime.parse(
                        //                     data['startTime'].toString(),
                        //                   ),
                        //                 ),
                        //               );
                        //             },
                        //             child: Container(
                        //               child: SearchFeatures(
                        //                 myColor: data['completed']
                        //                     ? Colors.orange
                        //                     : Colors.red,
                        //                 joinClosed: data['completed'] == false
                        //                     ? 'Join Contest'
                        //                     : 'Close Contest',
                        //                 category: data['category'],
                        //                 // labelName: 'Jumia Nigeria',
                        //                 // brandImage: 'assets/images/jumialogo.png',
                        //                 image: 'assets/images/producticon.png',
                        //                 userProfiles: [],
                        //                 date: DateFormat.yMMMMd().format(
                        //                     DateTime.parse(data['startTime'])),
                        //                 productName: data['productName'],
                        //                 amount: data['amount'],
                        //                 currency: currencySymbol,
                        //                 // time: formatTimeRemaining(
                        //                 //     DateTime.parse(data['startTime'])),
                        //               ),
                        //             ),
                        //           );
                        //         },
                        //       );
                        //     }
                        //     // else if (!snapshot.hasData) {
                        //     //   return Center(
                        //     //       child: Text('${homeProvider.responseText}'));
                        //     // }
                        //     else if (snapshot.hasError) {
                        //       return Center(
                        //           child: Text('${homeProvider.responseText}'
                        //               // 'An error occurred when trying to retrive your upcoming supported contest from the server'
                        //               ));
                        //     } else {
                        //       return Center(
                        //           child: SpinKitFadingCircle(
                        //         color: Colors.red,
                        //         size: 50,
                        //       ));
                        //     }
                        //   },
                        // );
                      }),
                    ),
                  ),
                  RefreshIndicator(
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    color: Colors.white,
                    backgroundColor: Colors.red,
                    onRefresh: getContest,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Consumer<HomeProvider>(
                          builder: (context, home, child) {
                        var past = home.pastContests;
                        if (home.isLoading) {
                          return Center(
                              child: SpinKitFadingCircle(
                            color: Colors.red,
                            size: 50,
                          ));
                        } else if (home.hasData) {
                          return ListView.builder(
                              itemCount: past.length,
                              itemBuilder: (context, index) {
                                var data = past[index];
                                currencySymbol =
                                    getCurrencySymbol(data['currency']);
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade100),
                                      borderRadius: BorderRadius.circular(15)),
                                  margin: EdgeInsets.only(bottom: 10),
                                  // elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          clipBehavior: Clip.hardEdge,
                                          width: 123,
                                          height: 123,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Image.network(
                                            '${data['videoURL']}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                              Text.rich(TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Product: ',
                                                      style: PageService
                                                          .bigHeaderStylebold2
                                                      // style: PageService.bigHeaderStylebold2, // Style not provided, replace with your style
                                                      ),
                                                  TextSpan(
                                                      text: data['productName'],
                                                      style: PageService
                                                          .bigHeaderStyle2
                                                      // style: PageService.bigHeaderStyle2, // Style not provided, replace with your style
                                                      ),
                                                ],
                                              )),
                                              const SizedBox(height: 2),
                                              Text.rich(TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Date: ',
                                                      style: PageService
                                                          .bigHeaderStylebold2
                                                      // style: PageService.bigHeaderStylebold2, // Style not provided, replace with your style
                                                      ),
                                                  TextSpan(
                                                      text: DateFormat.yMMMMd()
                                                          .format(DateTime
                                                              .parse(data[
                                                                  'startTime'])),
                                                      style: PageService
                                                          .bigHeaderStyle2
                                                      // style: PageService.bigHeaderStyle2, // Style not provided, replace with your style
                                                      ),
                                                ],
                                              )),

                                              const SizedBox(height: 3),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'category: ',
                                                      style: PageService
                                                          .bigHeaderStylebold2,
                                                    ),
                                                    TextSpan(
                                                      text: data['category'],
                                                      style: PageService
                                                          .bigHeaderStyle2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'amount: ',
                                                      style: PageService
                                                          .bigHeaderStylebold2,
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          '${currencySymbol} ${double.parse((data['amount']).toStringAsFixed(2))}',
                                                      style: PageService
                                                          .bigHeaderStyle2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 3),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Text(
                                                    'Closed Contest',
                                                    style: TextStyle(
                                                      color: Colors.orange,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Center(
                            child: Text('no past contest'),
                          );
                        }

                        // FutureBuilder(
                        //     future: home.getPastContests(),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasError) {
                        //         return Center(
                        //           child: Text(home.responseText),
                        //         );
                        //       } else if (snapshot.hasData) {
                        //         return ListView.builder(
                        //             itemCount: home.pastContests.length,
                        //             itemBuilder: (context, index) {
                        //               var data = home.data[index];
                        //               currencySymbol =
                        //                   getCurrencySymbol(data['currency']);
                        //               return Container(
                        //                 decoration: BoxDecoration(
                        //                     border: Border.all(
                        //                         color: Colors.grey.shade100),
                        //                     borderRadius: BorderRadius.circular(15)),
                        //                 margin: EdgeInsets.only(bottom: 10),
                        //                 // elevation: 0,
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(8.0),
                        //                   child: Row(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: [
                        //                       Container(
                        //                         width: 123,
                        //                         height: 123,
                        //                         decoration: BoxDecoration(
                        //                           borderRadius:
                        //                               BorderRadius.circular(12),
                        //                         ),
                        //                         child: Image.asset(
                        //                           'assets/images/producticon.png',
                        //                           fit: BoxFit.cover,
                        //                         ),
                        //                       ),
                        //                       const SizedBox(width: 10),
                        //                       Expanded(
                        //                         child: Column(
                        //                           crossAxisAlignment:
                        //                               CrossAxisAlignment.start,
                        //                           children: [
                        //                             // Row(
                        //                             //   children: [
                        //                             //     CircleAvatar(
                        //                             //       radius: 10,
                        //                             //       backgroundImage: AssetImage(brandImage),
                        //                             //     ),
                        //                             //     const SizedBox(width: 10),
                        //                             //     Text(
                        //                             //       labelName,
                        //                             //       // style: PageService.bigHeaderStylebold2, // Style not provided, replace with your style
                        //                             //     )
                        //                             //   ],
                        //                             // ),
                        //                             const SizedBox(height: 6),
                        //                             Text.rich(TextSpan(
                        //                               children: [
                        //                                 TextSpan(
                        //                                     text: 'Product: ',
                        //                                     style: PageService
                        //                                         .bigHeaderStylebold2
                        //                                     // style: PageService.bigHeaderStylebold2, // Style not provided, replace with your style
                        //                                     ),
                        //                                 TextSpan(
                        //                                     text: data['productName'],
                        //                                     style: PageService
                        //                                         .bigHeaderStyle2
                        //                                     // style: PageService.bigHeaderStyle2, // Style not provided, replace with your style
                        //                                     ),
                        //                               ],
                        //                             )),
                        //                             const SizedBox(height: 2),
                        //                             Text.rich(TextSpan(
                        //                               children: [
                        //                                 TextSpan(
                        //                                     text: 'Date: ',
                        //                                     style: PageService
                        //                                         .bigHeaderStylebold2
                        //                                     // style: PageService.bigHeaderStylebold2, // Style not provided, replace with your style
                        //                                     ),
                        //                                 TextSpan(
                        //                                     text: DateFormat.yMMMMd()
                        //                                         .format(DateTime
                        //                                             .parse(data[
                        //                                                 'startTime'])),
                        //                                     style: PageService
                        //                                         .bigHeaderStyle2
                        //                                     // style: PageService.bigHeaderStyle2, // Style not provided, replace with your style
                        //                                     ),
                        //                               ],
                        //                             )),

                        //                             const SizedBox(height: 3),
                        //                             Text.rich(
                        //                               TextSpan(
                        //                                 children: [
                        //                                   TextSpan(
                        //                                     text: 'category: ',
                        //                                     style: PageService
                        //                                         .bigHeaderStylebold2,
                        //                                   ),
                        //                                   TextSpan(
                        //                                     text: data['category'],
                        //                                     style: PageService
                        //                                         .bigHeaderStyle2,
                        //                                   ),
                        //                                 ],
                        //                               ),
                        //                             ),
                        //                             Text.rich(
                        //                               TextSpan(
                        //                                 children: [
                        //                                   TextSpan(
                        //                                     text: 'amount: ',
                        //                                     style: PageService
                        //                                         .bigHeaderStylebold2,
                        //                                   ),
                        //                                   TextSpan(
                        //                                     text:
                        //                                         '${currencySymbol} ${double.parse((data['amount']).toStringAsFixed(2))}',
                        //                                     style: PageService
                        //                                         .bigHeaderStyle2,
                        //                                   ),
                        //                                 ],
                        //                               ),
                        //                             ),
                        //                             const SizedBox(height: 3),
                        //                             Align(
                        //                               alignment:
                        //                                   Alignment.bottomRight,
                        //                               child: GestureDetector(
                        //                                 onTap: () {},
                        //                                 child: Text(
                        //                                   'Closed Contest',
                        //                                   style: TextStyle(
                        //                                     color: Colors.orange,
                        //                                     fontSize: 12,
                        //                                     fontWeight:
                        //                                         FontWeight.w500,
                        //                                   ),
                        //                                 ),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //               );
                        //             });
                        //       }
                        //       return Center(
                        //           child: SpinKitFadingCircle(
                        //         color: Colors.red,
                        //         size: 50,
                        //       ));
                        //     });
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
