import 'dart:ui';

import 'package:contest_app/src/providers/rohashprovider.dart';
import 'package:contest_app/src/providers/user.profile.provider.dart';
import 'package:contest_app/src/screens/user_varients/notification/notification.dart';
import 'package:contest_app/src/src.dart';
import 'package:flutter/cupertino.dart';

class Profile extends StatefulWidget {
  const Profile(
      {super.key,
      required this.amount,
      required this.currency,
      required this.username});
  final String username;
  final String currency;
  final double amount;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _balance = TextEditingController();
  String _username = '';
  double _amount = 0;
  bool isFetched = false;
  String currencySymbol = '';
  late AvatarProvider _avatarProvider;
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

  String? currency;
  @override
  void initState() {
    super.initState();
    _fetchCurrencyData();
    Provider.of<Profile1Provider>(context, listen: false);
    Provider.of<UserProfileProvider>(context, listen: false).fetchUserProfile();
    Provider.of<BalanceProvider>(context, listen: false).fetchBalance();
    _loadUsername();
    // avatarFile = null;
    // fetchAvatar();
  }

  Future<void> _fetchCurrencyData() async {
    homepage();
    _avatarProvider = await Provider.of<AvatarProvider>(context, listen: false);
    _avatarProvider.fetchAvatar();
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

  Future<void> _loadUsername() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String savedUsername = sf.getString('username') ?? '';
    double savedamount = sf.getDouble('amount') ?? 0.0;

    setState(() {
      _username = savedUsername;
      _amount = savedamount;
    });
  }

  Future<void> homepage() async {
    await Provider.of<UserProfileProvider>(context, listen: false)
        .fetchUserProfile();
    await Provider.of<BalanceProvider>(context, listen: false).fetchBalance();
    await Provider.of<Rohash>(context, listen: false).fetchAvatar(_username);
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<Profile1Provider>(context, listen: false);
    // final profileProvider = Provider.of<Profile1Provider>(context);
    final balanceProvider = Provider.of<BalanceProvider>(context);
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    // final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    // final TextEditingController _searchController = TextEditingController();
    String formattedDiscount = NumberFormat('#,##0').format(_amount);
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      color: Colors.white,
      backgroundColor: Colors.red,
      onRefresh: homepage,
      child: Consumer5<Profile1Provider, BalanceProvider, AvatarProvider,
          UserProfileProvider, Rohash>(
        builder: (context, profileProvider, balanceProvider, avatarProvider,
            userProfile, rohash, child) {
          _balance.text =
              "${balanceProvider.currency}${balanceProvider.amount}";
          _name.text = "${userProfile.username}";
          _name.text = userProfile.username ?? '';
          _balance.text = balanceProvider.amount.toString();

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                "Profile",
                style: PageService.headerStyle,
              ),
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://robohash.org/$_username.png?size=100x100&set=set1'),
                      )),
                      PageService.textSpace,
                      Center(
                        child: Text(
                          // userProfile.username ?? '',
                          _username,
                          style: TextStyle(
                            color: AppColor.gray8,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      PageService.textSpace,
                      Center(
                        child: Text(
                          '$currencySymbol $formattedDiscount',
                          // "₦${balanceProvider.amount}",
                          style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      PageService.textSpace,
                      Center(
                        child: Text(
                          "Balance",
                          style: TextStyle(
                            color: AppColor.gray6,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      PageService.textSpace,
                      GestureDetector(
                        onTap: () {
                          topUpModalBottomSheet(context);
                        },
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 45, vertical: 8),
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              "TOP UP",
                              style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      PageService.textSpacexxL,
                      const Divider(color: Color(0xffF3F3FD), thickness: 1),
                      PageService.textSpacexxL,
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: Column(
                            children: [
                              // ProfileBtn(
                              //   onTap: () {
                              //     nextPage1(context,
                              //         page: const EditProfileScreen());
                              //   },
                              //   icon: Image.asset(
                              //       "assets/images/basil_edit-solid.png"),
                              //   text: 'Edit Profile',
                              // ),
                              // PageService.textSpaceL,
                              ProfileBtn(
                                onTap: () {
                                  topUpModalBottomSheet(context);
                                },
                                icon: Image.asset("assets/images/pay.png"),
                                text: 'Top up',
                              ),
                              PageService.textSpaceL,
                              ProfileBtn(
                                onTap: () {
                                  nextPage1(context, page: VoucherScreen());
                                },
                                icon: Image.asset("assets/images/voulcher.png"),
                                text: 'Vouchers',
                              ),
                              PageService.textSpaceL,
                              ProfileBtn(
                                onTap: () {
                                  nextPage1(context, page: ContestScreen());
                                },
                                icon: Image.asset("assets/images/support.png"),
                                text: 'Contest won',
                              ),
                              PageService.textSpaceL,
                              ProfileBtn(
                                onTap: () {
                                  showToast();
                                  // nextPage1(context,
                                  //     page: NotificationScreen());
                                },
                                icon: Image.asset(
                                    "assets/images/notification.png"),
                                text: 'Notification',
                              ),
                              PageService.textSpaceL,
                              ProfileBtn(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Stack(
                                        children: [
                                          Positioned.fill(
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaX: 5, sigmaY: 5),
                                                )),
                                          ),
                                          Center(
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 5, sigmaY: 5),
                                              child: AlertDialog(
                                                clipBehavior: Clip.hardEdge,
                                                elevation: 0,
                                                titleTextStyle: TextStyle(
                                                  color: Color.fromRGBO(
                                                    71,
                                                    71,
                                                    71,
                                                    1,
                                                  ),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  fontFamily: 'SpaceGrotesk',
                                                ),
                                                contentTextStyle: TextStyle(
                                                  color: Color.fromRGBO(
                                                    71,
                                                    71,
                                                    71,
                                                    1,
                                                  ),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  fontFamily: 'SpaceGrotesk',
                                                ),
                                                backgroundColor: Color.fromRGBO(
                                                  255,
                                                  255,
                                                  255,
                                                  1,
                                                ),
                                                title: Text('Log out?'),
                                                content: Text(
                                                    'Are you sure, you want to log out ?'),
                                                actions: [
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment.spaceBetween,
                                                  //   children: [
                                                  //     customButton(
                                                  //       context,
                                                  //       onTap: () {
                                                  //         Navigator.pop(context);
                                                  //       },
                                                  //       text: 'Cancel',
                                                  //     ),
                                                  //     customButton(context, onTap: () {
                                                  //       Navigator.pop(context);
                                                  //     },
                                                  //         textColor: Color.fromRGBO(
                                                  //           255,
                                                  //           255,
                                                  //           255,
                                                  //           1,
                                                  //         ),
                                                  //         text: 'Log Out',
                                                  //         bgColor: Color.fromRGBO(
                                                  //           242,
                                                  //           7,
                                                  //           50,
                                                  //           1,
                                                  //         ))
                                                  //   ],
                                                  // ),

                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    // horizontal:
                                                                    //     40,
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color
                                                                  .fromRGBO(
                                                                235,
                                                                235,
                                                                235,
                                                                1,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "Cancel",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'SpaceGrotesk',
                                                                  color: Color
                                                                      .fromRGBO(
                                                                    71,
                                                                    71,
                                                                    71,
                                                                    1,
                                                                  ),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 20),
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            SharedPreferences
                                                                sf =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            sf
                                                                .clear()
                                                                .whenComplete(
                                                                    () {})
                                                                .then((value) {
                                                              Provider.of<
                                                                  ModelProviders>(
                                                                context,
                                                                listen: false,
                                                              ).changeCounter(
                                                                  0);
                                                              nextPageAndRemovePrevious(
                                                                  context,
                                                                  page:
                                                                      const SignInScreen());
                                                            });
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    // horizontal:
                                                                    //     20,
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color
                                                                  .fromRGBO(
                                                                242,
                                                                7,
                                                                50,
                                                                1,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "Log out",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'SpaceGrotesk',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
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
                                  );
                                  // logOutDialog(context);
                                },
                                icon: Image.asset("assets/images/logout.png"),
                                text: 'Log out',
                              ),
                              PageService.textSpaceL,
                              PageService.textSpaceL,
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfileBtn extends StatelessWidget {
  const ProfileBtn({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final Image icon;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffFEF2F2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon,
              SizedBox(
                width: 14,
              ),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.gray9,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
