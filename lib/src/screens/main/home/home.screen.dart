import 'package:contest_app/src/screens/user_varients/notification/notification.dart';
import 'package:contest_app/src/screens/user_varients/product_details.dart';
import 'package:contest_app/src/src.dart';

import '../../../widgets/avatar.widget.dart'; // Import video player package

class HomeScreen extends StatefulWidget {
  final String? contestid;
  const HomeScreen({Key? key, this.contestid}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  // late VideoPlayerController _videoController; // Initialize video controller
  final unlikedPhoto = Colors.white;
  final likedPhoto = Colors.red;
  String userid = '';
  String userdata = '';
  // late ChewieController _chewieController;
  String currencySymbol = '';
  String? currency;
  // late HomeProvider? _homePage;
  @override
  void initState() {
    // _fetchCurrencyData();
    super.initState();
    homepage();
  }

  Future<void> _fetchCurrencyData() async {
    print('it will work if u try doing it better');
    // Fetch currency data asynchronously
    // UserData userData = await getUserDataFromPrefs();
    SharedPreferences sf = await SharedPreferences.getInstance();
    String savedcurrency = sf.getString('currency') ?? '';
    currencySymbol = getCurrencySymbol(savedcurrency);
    setState(() {}); // Update UI when currency data is available
  }

  String getCurrencySymbol(String? currency) {
    if (currency != null && currencies.containsKey(currency)) {
      return currencies[currency]!;
    } else {
      return ''; // Return empty string if currency not found
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    // _chewieController.dispose();
    // _homePage.removeListener(_onDataChange);
    // _videoController.dispose(); // Dispose video controller
  }

  void _onDataChange() {
    setState(() {
      // Handle any necessary state updates here
    });
  }

  Future<void> homepage() async {
    await Provider.of<HomeProvider>(context, listen: false).fetchContests();
    userid = (await UserId.retrieveUserid())!;
    SharedPreferences sf = await SharedPreferences.getInstance();
    userdata = sf.getString("_id")!;
  }

  @override
  Widget build(BuildContext context) {
    // final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    // final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    // final TextEditingController _searchController = TextEditingController();
    // _searchController.addListener(() {
    //   searchProvider.search(_searchController.text);
    // });
    final likeProvider = Provider.of<LikeProvider>(context);
    // final authToken = Provider.of<AuthProvider>(context).authToken;
    // final searchProvider = Provider.of<HomeProvider>(context, listen: false);
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      color: Colors.white,
      backgroundColor: Colors.red,
      // onRefresh: _fetchCurrencyData,
      onRefresh: () async {
        await Provider.of<HomeProvider>(context, listen: false)
            .fetchContests(); // Assuming you have a method named fetchData in your HomeProvider to refetch the data
      },

      child: Scaffold(
        body: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            // if (homeProvider.data == null) {
            //   return Image.asset(
            //     "assets/images/backgrund.png",
            //     fit: BoxFit.cover,
            //     height: MediaQuery.of(context).size.height,
            //   );
            // }
            // else {
            return Stack(
              children: [
                PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _pageController,
                  itemCount: homeProvider.data!.length,
                  itemBuilder: (context, int index) {
                    final contest = homeProvider.contestData[index];
                    // _videoController = VideoPlayerController.network(
                    //   contest['videoURL'],
                    // );
                    currencySymbol = getCurrencySymbol(contest.currency);
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: () {
                              SearchProvider()
                                  .tapPrice('660305fc04c515f43a9d2e13');
                              // print(contest. );
                              nextPage1(
                                context,
                                page: ProductDetailsScreen(
                                  image: '${contest.videoUrl}',
                                  currency: '$currencySymbol',
                                  amount: contest.amount,
                                  productName: contest.productName,
                                  productId: contest.productCode,
                                  contestId: contest.contestId,
                                  tapCount: contest.supporters.length,
                                  targetTime: DateTime.parse(
                                    contest.startTime.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Image.network(
                                  "${contest.videoUrl}",
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                        Colors.transparent.withOpacity(0.2),
                                        Colors.black.withOpacity(0.6),
                                      ])),
                                  // color: Colors.blue.withOpacity(
                                  //     0.5), // Adjust color and opacity as needed
                                  // You can change the blend color and its opacity here
                                  // For example, Colors.blue.withOpacity(0.5) gives a semi-transparent blue overlay
                                  // Adjust the color and opacity to achieve the desired blend effect
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                              ],
                            ),

                            // Image.network(
                            //   "${contest.videoUrl}",
                            //   // scale: 100,
                            //   fit: BoxFit.cover,
                            //   height: MediaQuery.of(context).size.height,
                            // ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: 320),
                                        child: Text(
                                          contest.productName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${currencySymbol} ${double.parse((contest.amount * 0.01).toStringAsFixed(2))}  ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${currencySymbol}${contest.amount}',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        214, 214, 214, 1),
                                                    fontSize: 18,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationColor:
                                                        Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        contest.productCode,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset("assets/images/add.png"),
                                        Text(
                                          contest.supporters.length.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () async {
                                        print('tap');
                                        // homepage();
                                        // if (likeProvider.isLiked) {
                                        if (contest.likes
                                            .contains('${userid}')) {
                                          //  {
                                          print('null');
                                          // homepage();
                                          return;
                                          // }
                                          // await likeProvider.dislikeContest(
                                          //     contest.contestId);
                                        } else {
                                          await likeProvider.likeContest(
                                            contest.contestId,
                                          );
                                          homepage();
                                          // homepage();
                                        }

                                        // homepage();
                                        // }
                                        // else if (contest.likes
                                        //     .contains('${userid}')) {
                                        //   //  {
                                        //   print('null');
                                        //   // homepage();
                                        //   return;
                                        //   // }
                                        //   // await likeProvider.dislikeContest(
                                        //   //     contest.contestId);
                                        // }
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/images/heart.png",
                                            color: contest.likes
                                                    .contains('${userid}')
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                          Text(
                                            contest.likes.length.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Consumer<LikeProvider>(
                                    //   builder: (context, like, child) {
                                    //     return GestureDetector(
                                    //       onTap: () {
                                    //         like.updateLikeStatus();
                                    //         if (like.isLiked) {
                                    //           return;
                                    //         } else {
                                    //           like.updateLike(
                                    //             contestId: contest["contestId"],
                                    //           );
                                    //         }
                                    //       },
                                    //       child: Column(
                                    //         children: [
                                    //           Image.asset(
                                    //             "assets/images/heart.png",
                                    //             color: !like.isLiked
                                    //                 ? likedPhoto
                                    //                 : unlikedPhoto,
                                    //           ),
                                    //           Text(
                                    //             like.likes == null
                                    //                 ? contest['likes']
                                    //                     .length
                                    //                     .toString()
                                    //                 : like.likes.toString(),
                                    //             style: TextStyle(
                                    //               color: Colors.white,
                                    //               fontSize: 16,
                                    //               fontWeight: FontWeight.w700,
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     );
                                    //   },
                                    // ),

                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () async {
                                        // Share contest
                                        Share.share(
                                          'Join the current contest https://contest-api.100pay.co/?contestid=${contest.contestId}',
                                          subject: 'Contest App!',
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset(
                                              "assets/images/share.png"),
                                          Text(
                                            " ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 32.0, bottom: 8.0, left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage('assets/images/contestlogo.png'),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showToast();
                                // nextPage1(
                                //   context,
                                //   page: NotificationScreen(),
                                // );
                                // Navigate to notification screen
                              },
                              child: Image(
                                image: AssetImage("assets/images/notify.png"),
                              ),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            IconButton(
                              onPressed: () {
                                // showToast();
                                nextPage1(
                                  context,
                                  page: SupportScreen(),
                                );
                                // Navigate to support screen
                              },
                              icon: Image(
                                image: AssetImage("assets/images/store.png"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
            // }
          },
        ),
      ),
    );
  }

  String shareLink(String liveId) =>
      "Join my live stream https://contest-api.100pay.co/?liveId=$liveId";

  void _openCommentSection(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageService.textSpaceL,
            Center(
              child: Image.asset("assets/images/shortline.png"),
            ),
            PageService.textSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Spacer(),
                    const Text(
                      "commit",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff15152D)),
                    ),
                    const Spacer(), // This will push the image to the left
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset('assets/images/cancle.png')),
                  ],
                ),
              ),
            ),
            PageService.textSpaceL,
            Divider(
              color: AppColor.gray1,
            ),
            PageService.textSpace,
            ListTile(
              leading: Image.asset("assets/images/profilepicture.png"),
              title: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: 'Cynthia_Morgan ',
                      style: TextStyle(
                          color: Color(0xff15152D),
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                  TextSpan(
                      text: ' 2w',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.gray6,
                          fontSize: 12)),
                ]),
              ),
              trailing: Column(
                children: [
                  Icon(
                    Icons.favorite,
                    color: AppColor.gray4,
                  ),
                  const Text(
                    "0",
                    style: TextStyle(
                      color: Color(0xff5C5C5C),
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Image.asset("assets/images/profilepicture.png"),
              title: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: 'Cynthia_Morgan ',
                      style: TextStyle(
                          color: Color(0xff15152D),
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                  TextSpan(
                      text: ' 2w',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.gray6,
                          fontSize: 12)),
                ]),
              ),
              trailing: Column(
                children: [
                  Icon(
                    Icons.favorite,
                    color: AppColor.gray4,
                  ),
                  const Text(
                    "0",
                    style: TextStyle(
                      color: Color(0xff5C5C5C),
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Image.asset("assets/images/profilepicture.png"),
              title: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: 'Cynthia_Morgan ',
                      style: TextStyle(
                          color: Color(0xff15152D),
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                  TextSpan(
                      text: ' 2w',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColor.gray6,
                          fontSize: 12)),
                ]),
              ),
              trailing: Column(
                children: [
                  Icon(
                    Icons.favorite,
                    color: AppColor.gray4,
                  ),
                  const Text(
                    "0",
                    style: TextStyle(
                      color: Color(0xff5C5C5C),
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset("assets/images/profilepicture.png"),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        isDense: true,
                        fillColor: const Color(0xffF1F1F3),
                        hintText: 'Enter your comment',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.gray4,
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 15, bottom: 10, left: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xffF1F1F3), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xffF1F1F3), width: 1),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Handle @ icon tap
                                print("User tapped @");
                              },
                              child: const Text(
                                "@",
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                // Handle moji icon tap
                                print("User tapped moji");
                              },
                              child: const Icon(
                                Icons.emoji_emotions,
                                color: Color(0xff151923),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: AppColor.primaryColor,
                    child: const Icon(Icons.arrow_upward),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: "Coming soon",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
