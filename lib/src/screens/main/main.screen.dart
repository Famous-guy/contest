import 'package:contest_app/src/providers/user.profile.provider.dart';
import 'package:contest_app/src/providers/won.dart';
import 'package:contest_app/src/src.dart';

class MainActivityPage extends StatefulWidget {
  final String? contestid;
  MainActivityPage({Key? key, this.auth, this.id, this.contestid})
      : super(key: key);

  final auth;
  final id;

  @override
  State<MainActivityPage> createState() => _MainActivityPageState();
}

class _MainActivityPageState extends State<MainActivityPage> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  late List<Map<String, String>> bottomNavItems;
  String _username = '';
  double _amount = 0;
  String? currency;
  String currencySymbol = '';

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      context.read<LeaderboardProvider>().fetchLeaderboard();
      context.read<LeaderboardProvider>().fetchLeaderboardweekly();
      context.read<LeaderboardProvider>().fetchLeaderboardtoday();
      context.read<HomeProvider>().getPastContests();
      context.read<HomeProvider>().fetchSupportedContests();
      context.read<HomeProvider>().getLike();
      context.read<BalanceProvider>().fetchBalance();
      context.read<UserProfileProvider>().fetchUserProfile();
      context.read<ProfileProvider>().getVouchers();
      context.read<ContestProvider>().fetchContestData();
    });

    super.initState();
    // _fetchCurrencyData();
    // _loadUsername();
    // Provider.of<UserProfileProvider>(context, listen: false).fetchUserProfile();
    // Provider.of<BalanceProvider>(context, listen: false).fetchBalance();
    // homepage();
    // Provider.of<Profile1Provider>(context, listen: false);
    // Provider.of<UserProfileProvider>(context, listen: false).fetchUserProfile();
    // Provider.of<BalanceProvider>(context, listen: false).fetchBalance();
    Future.microtask(() =>
        Provider.of<ProfileProvider>(context, listen: false).getUserProfile());
    Future.microtask(() =>
        Provider.of<HomeProvider>(context, listen: false).fetchContests());
    bottomNavItems = [
      {'title': 'Home', 'icon': 'assets/images/home.png'},
      {'title': 'Search', 'icon': 'assets/images/Search.png'},
      {'title': 'Leadership', 'icon': 'assets/images/Leadership.png'},
      {'title': 'Voucher', 'icon': 'assets/images/voucher.png'},
      {'title': 'Profile', 'icon': 'assets/images/Profile.png'},
    ];
  }

  Future<void> homepage() async {
    await Provider.of<UserProfileProvider>(context, listen: false)
        .fetchUserProfile();
    await Provider.of<BalanceProvider>(context, listen: false).fetchBalance();
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

  Future<void> _fetchCurrencyData() async {
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
  Widget build(BuildContext context) {
    return Consumer<ModelProviders>(
      builder: (context, counter, child) {
        return Scaffold(
          body: bottomNavPages[counter.bottomCounter],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              selectedItemColor: Colors.red,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xff15152D),
              unselectedItemColor: Colors.white,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedLabelStyle: const TextStyle(color: Colors.white),
              onTap: (value) {
                counter.changeCounter(value);
              },
              currentIndex: counter.bottomCounter,
              items: List.generate(bottomNavItems.length, (index) {
                final data = bottomNavItems[index];
                return BottomNavigationBarItem(
                  backgroundColor: const Color(0xff15152D),
                  tooltip: data['title'],
                  icon: Column(
                    children: [
                      Image.asset(
                        data['icon']!,
                        width: 21,
                        color: counter.bottomCounter == index
                            ? AppColor.primaryColor
                            : null,
                      ),
                    ],
                  ),
                  label: data['title']!,
                );
              }),
            ),
          ),
        );
      },
    );
  }

  List<Widget> get bottomNavPages => [
        HomeScreen(
          contestid: widget.contestid,
        ),
        SearchScreen(),
        LeadershipScreen(),
        const VoucherScreen(),
        Profile(amount: _amount, currency: currencySymbol, username: _username),
      ];
}
