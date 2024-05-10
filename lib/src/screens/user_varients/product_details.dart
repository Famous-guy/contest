import 'dart:ui';
import 'package:contest_app/src/providers/user.profile.provider.dart';
import 'package:contest_app/src/src.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:contest_app/src/screens/user_varients/countdown.dart';
import 'package:contest_app/src/models/message.dart';
import 'package:contest_app/src/screens/user_varients/paint.dart';
import 'package:contest_app/src/screens/user_varients/tap_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class ProductDetailsScreen extends StatefulWidget {
  final String contestId;
  final int tapCount;
  final String productId;

  final int amount;
  final String productName;
  final DateTime targetTime;
  final String currency;
  // final DateTime price;
  // final String productName;
  final String image;
  ProductDetailsScreen({
    Key? key,
    required this.image,
    required this.currency,
    required this.productName,
    required this.amount,
    required this.productId,
    required this.contestId,
    required this.tapCount,
    required this.targetTime,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late ScrollController _scrollController;
  late TextEditingController _textEditingController;
  bool winner = false;
  late final GraphQLClient _client;
  late final String _contestId;
  bool _isLoading = false;
  String? _error;
  List<dynamic> _comments = [];
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  late IO.Socket socket;
  String _username = '';
  double _amount = 0;
  String username = '';
  String message = '';
  String tap = '';
  bool isFetched = false;
  String currencySymbol = '';
  late AvatarProvider _avatarProvider;
  int number = 0;
  int funds = 3000;
  bool canJoinContest = false;
  // String product = widget.productName;
  int endTime = DateTime.now().millisecondsSinceEpoch;
  Timer? _timer;
  late Duration _duration;
  bool isConnected = false;
  bool isJoin = false;

  // static const maxSecond = 10;
  // int seconds = maxSecond;
  int tapCounter = 0;
  late int seconds;
  late ConfettiController _confettiController;
  bool _timerExpired = false;
  int maxSeconds = 10;

  void _resetTimer() {
    setState(() {
      seconds = maxSeconds;
      _timerExpired = false;
      // _showContainer = false; // Hide the container when the timer resets
    });
  }

  void _startTimer() {
    _resetTimer(); // Reset the timer before starting

    if (_timer!.isActive) {
      // Check if the timer is already active
      _timer!.cancel(); // Cancel the timer if it's already running
    }

    _timer = Timer.periodic(Duration(seconds: 1), (_) async {
      if (seconds > 0 && isConnected == true) {
        setState(() {
          seconds--;
        });
      } else {
        _timer!.cancel();
        setState(() {
          _timerExpired = true; // Set timer state to expired
        });
      }
      _confettiController.play();
      await Haptics.vibrate(HapticsType.success);
    });
  }

  void _stopTimer() {
    _timer!.cancel();
  }

  Widget buildTime() {
    return Text(
      '$seconds',
      style: TextStyle(
        color: Color.fromRGBO(52, 64, 84, 1),
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontFamily: 'SpaceGrotesk',
      ),
    );
  }

  Widget buildTimer() {
    return SizedBox(
      width: 70,
      height: 65,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            // size: Size.fromWidth(58),
            painter: HalfCircularProgressPainter(
              value: seconds / maxSeconds,
              color: Color.fromRGBO(242, 7, 50, 1),
              backgroundColor: Color.fromRGBO(235, 235, 235, 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 13, left: 13, right: 13),
            child: Center(
              child: Column(
                children: [
                  buildTime(),
                  Text(
                    'Secs',
                    style: TextStyle(
                      color: Color.fromRGBO(52, 64, 84, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'SpaceGrotesk',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fetchCurrencyData();
    _loadUsername();
    Provider.of<SearchProvider>(context, listen: false)
        .tapPrice(widget.contestId);
    Provider.of<Profile1Provider>(context, listen: false);
    Provider.of<UserProfileProvider>(context, listen: false).fetchUserProfile();
    Provider.of<BalanceProvider>(context, listen: false).fetchBalance();
    fetchContestData(widget.contestId).then((data) {
      setState(() {
        tapCounter = data['tapCount'];
      });
    }).catchError((error) {
      // Handle errors
      print(error);
    });
    print(isConnected);

    // connectio();
    socket = IO.io(
      'https://contest-api.100pay.co/', // Assuming server is running locally
      IO.OptionBuilder()
          .setTransports(['websocket']).build(), // Using object parameters
    );
    _connectSocket();

    seconds = maxSeconds;

    _confettiController = ConfettiController(duration: Duration(seconds: 3));
    _duration = widget.targetTime.difference(DateTime.now());

    endTime = widget.targetTime.millisecondsSinceEpoch;
    _textEditingController = TextEditingController(text: 'Min of 2');
  }

  Future<void> _fetchCurrencyData() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    String message = _messageController.text.trim();
    print(token);
    print(widget.contestId);
    homepage();
    _avatarProvider = await Provider.of<AvatarProvider>(context, listen: false);
    _avatarProvider.fetchAvatar();
    // Fetch currency data asynchronously
    // UserData userData = await getUserDataFromPrefs();
    // SharedPreferences sf = await SharedPreferences.getInstance();
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
  }

  _sendMessage() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    String message = _messageController.text.trim();
    print(token);
    print(widget.contestId);
    if (_messageController.text.isNotEmpty) {
      socket.emit('join-room', {
        'msg': message,
        'token': token,
        'contestId': widget.contestId,
      });

      print('message sent');
      isConnected == false;
      print(isConnected);
    } else {
      // If message is empty, send tap event
      socket.emit('join-room', {
        'msg': '1~@#\$%^&*()_+Po"uT?/~V>sC<w,qhgKK}|-',
        'token': token,
        'contestId': widget.contestId,
      });

      isConnected = true;
      print(isConnected);

      print('tap sent');
    }

    _messageController.clear();
  }

  void _connectSocket() {
    socket.onConnect((data) => print('Connection established'));
    socket.onConnectError((data) => print('Connect Error: $data'));
    socket.onDisconnect((data) => print('Socket.IO server disconnected $data'));
    print(isConnected);

    socket.on(
      'comment',
      (data) {
        print(data);
        if (data is Map<String, dynamic>) {
          Provider.of<MessageProvider>(context, listen: false)
              .addNewMessage(User.fromJson(data));
          // .addNewMessage(message);
          print(isConnected);
          print(data);
        } else {
          print('Received invalid message data: $data');
        }
      },
    );

    socket.on('winner-message', (data) {
      winner = true;
      print(data);
      username = data['username'];
      message = data['message'];
    });

    socket.on('welcome-to-room', (data) {
      print(data);
      final Map<String, dynamic> messageData = data;
      // Extract the message from the data
      final String message = messageData['message'];
      successSnackBar(context, message);
    });
    socket.on('disconnected', (data) {
      print(data);
      final Map<String, dynamic> messageData = data;
      // Extract the message from the data
      final String message = messageData['message'];
      errorSnackBar(context, message);
    });

    socket.on('welcome', (data) {
      final Map<String, dynamic> messageData = data;
      // Extract the message from the data
      final String message = messageData['message'];
      successSnackBar(context, message);

      print(data);
    });

    socket.on('tap', (data) {
      print(data);
      if (data is Map<String, dynamic>) {
        successSnackBar(context, data['message']);

        username = data['username'];
        tap = data['message'];
        print(isConnected);
        print(data);
        if (isConnected == true) {
          isConnected == true;
          _startTimer();

          setState(() {
            if (seconds <= 0 && isConnected == false) {
              return;
            } else if (seconds > 0) {
              tapCounter--;
            }

            if (tapCounter == 0) {
              // Disable the button when the counter reaches zero
              tapCounter = 0; // Ensure tapCounter does not go negative
            }
          });
          print(isConnected);
        }
      } else {
        print('Received invalid message data: $data');
      }
    });
    socket.on('error-message', (data) {
      final Map<String, dynamic> messageData = data;
      // Extract the message from the data
      final String message = messageData['error'];
      errorSnackBar(context, message);

      print(data);
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    _messageController.dispose();

    if (_timer != null) {
      _timer!.cancel();
    }

    _confettiController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void increment() {
    setState(() {
      if (number < 10) {
        number++;
        _textEditingController.text = '$number';
      }
    });
  }

  void decrement() {
    setState(() {
      if (number > 1) {
        number--;
        _textEditingController.text = '$number';
      }
    });
  }

  String _formatDuration(Duration duration) {
    return DateFormat('mm:ss')
        .format(DateTime(0, 1, 1, 0, 0, duration.inSeconds));
  }

  @override
  Widget build(BuildContext context) {
    int start = widget.tapCount < 5 ? 5 : widget.tapCount;
    return Consumer3<HomeProvider, AvatarProvider, SearchProvider>(
        builder: (context, homeProvider, avatarProvider, search, child) {
      if (homeProvider.isLoading == true) {
        return const BusyOverlay(
          title: 'Please wait...',
          show: true,
          child: Text(""),
        );
      } else {
        String remainingTime =
            CountdownUtil.getRemainingTime(widget.targetTime);

        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset("assets/images/InfoSquare.png"),
              )
            ],
            centerTitle: true,
            title: Text(
              "Product",
              style: PageService.headerStyle,
            ),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                        child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 11, horizontal: 31),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(242, 7, 50, 1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${widget.tapCount} of ${start} remaining',
                                  style: TextStyle(
                                    color: Color.fromRGBO(
                                      255,
                                      255,
                                      255,
                                      1,
                                    ),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (canJoinContest) {
                                      return;
                                    } else {
                                      join(context, homeProvider);
                                    }
                                  },
                                  child: canJoinContest
                                      ? Text(
                                          'Joined Contest',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                              255,
                                              255,
                                              255,
                                              1,
                                            ),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      : Text(
                                          tapCounter > 0
                                              ? 'Buy Taps'
                                              : 'Join Contest',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                              255,
                                              255,
                                              255,
                                              1,
                                            ),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 17, right: 17, top: 16),
                            child: ListTile(
                              trailing: canJoinContest
                                  ? GestureDetector(
                                      onTap: () {
                                        joinContestModal(context);
                                      },
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            NetworkImage('${widget.image}'),
                                      ),
                                    )
                                  : Column(children: [
                                      GestureDetector(
                                          onTap: () {
                                            Share.share(
                                              'Join the current contest https://contest-api.100pay.co/?contestid=${widget.contestId}',
                                              subject: 'Look what I made!',
                                            );
                                          },
                                          child: ImageIcon(
                                              color:
                                                  Color.fromRGBO(242, 7, 50, 1),
                                              AssetImage(
                                                  'assets/images/sharing.png'))),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Share',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Color.fromRGBO(
                                            112,
                                            112,
                                            112,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ]),
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.red,
                                backgroundImage: NetworkImage(
                                    'https://robohash.org/$_username.png?size=50x50&set=set1'),
                                // child: Image.network(
                                //     'https://robohash.org/$_username.png?size=100x100&set=set1'),
                              ),
                              subtitle: Text(
                                "Product ID: ${widget.productId}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: AppColor.gray8),
                              ),
                              title: Text(
                                "${_username}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.gray9),
                              ),
                            ),
                          ),
                          PageService.textSpace,
                          canJoinContest && isConnected
                              ? Tap()
                              : product(context, remainingTime),
                          PageService.textSpaceL,
                          TapButton(context, homeProvider, search),
                          PageService.textSpacexL,
                          MessageField(),
                        ],
                      ),
                    ))
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 15, top: 15, right: 12, bottom: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            // readOnly: canJoinContest ? false : true,
                            controller: _messageController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              isDense: true,
                              fillColor: const Color(0xffF1F1F3),
                              hintText: 'Add a comment',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.gray4,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 15),
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
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: _sendMessage,
                          child: CircleAvatar(
                            backgroundColor: AppColor.primaryColor,
                            child: const Icon(Icons.arrow_upward),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // }),
        );
      }
    });
  }

  Container MessageField() {
    return Container(
      padding: EdgeInsets.only(bottom: 60),
      height: 200,
      child: Consumer<MessageProvider>(
        builder: (_, provider, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: ListView.builder(
            reverse: true,
            controller: _scrollController,
            addRepaintBoundaries: true,
            itemCount: provider.messages.length,
            itemBuilder: (BuildContext context, int index) {
              final reversedIndex = provider.messages.length - 1 - index;
              final message = provider.messages[reversedIndex];
              // final message = provider.messages[index];
              if (message.contestID != widget.contestId) {
                return SizedBox.shrink();
              }
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 22,
                  backgroundImage: NetworkImage(
                    'https://robohash.org/${message.username}.png?size=50x50&set=set1',
                  ),
                ),
                title: Text(
                  message.username,
                  style: TextStyle(
                    color: Color.fromRGBO(51, 51, 51, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  message.message,
                  style: TextStyle(
                    color: Color.fromRGBO(92, 92, 92, 1),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  GestureDetector TapButton(
      BuildContext context, HomeProvider homeProvider, SearchProvider search) {
    return GestureDetector(
      onTap: () async {
        // canJoinContest == true;

        if (canJoinContest && widget.tapCount >= 2) {
          _sendMessage();
          print('i tap, wow');
          await Haptics.vibrate(HapticsType.success);
        } else if (canJoinContest == false) {
          await Haptics.vibrate(HapticsType.error);
          join(context, homeProvider);
        }
      },
      child: Visibility(
        visible: !canJoinContest ||
            !isConnected, // Hide the container if canJoinContest is true
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 13),
            decoration: BoxDecoration(
              color: !canJoinContest || widget.tapCount < 2
                  ? Color(0xffA5B0C1)
                  : AppColor.primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tap to win",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Image.asset('assets/images/Littlecup.png'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding product(BuildContext context, String remainingTime) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Stack(
          children: [
            Positioned(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent
                          .withOpacity(0.1), // Start color (transparent)
                      Colors.black.withOpacity(
                          0.5), // End color with opacity (adjust as needed)
                    ],
                  ).createShader(bounds);
                },
                blendMode:
                    BlendMode.srcATop, // Apply the blend mode to the image
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.image != null
                      ? Image.network(
                          widget.image, // URL of the image
                          fit: BoxFit.cover,
                          height: 376,
                          width: 378,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Shimmer.fromColors(
                              baseColor: Color(0xffBDBDBD),
                              highlightColor: Color(0xffF5F5F5),
                              child: Container(
                                color: Colors.grey[300], // Placeholder color
                                height: 376,
                                width: 378,
                              ),
                            );
                          },
                        )
                      : Shimmer.fromColors(
                          baseColor: Color(0xffBDBDBD),
                          highlightColor: Color(0xffF5F5F5),
                          child: Container(
                            color: Colors.grey[300], // Placeholder color
                            height: 376,
                            width: 378,
                          ),
                        ),
                ),

                // ClipRRect(
                //   borderRadius: BorderRadius.circular(12),
                // child: Image.network(
                //   fit: BoxFit.cover,
                //   widget.image,
                //   height: 376,
                //   width: 378,
                // ),
                // ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.productName,
                    // 'Iphone 13 pro',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffffffff),
                    ),
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text:
                          '${widget.currency} ${double.parse((widget.amount * 0.01).toStringAsFixed(2))}  ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffffffff),
                      ),
                    ),
                    TextSpan(
                      text: '${widget.currency}${widget.amount}  ',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.white,
                        fontSize: 18,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ])),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 15,
              child: Visibility(
                visible: !canJoinContest,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color.fromRGBO(
                      242,
                      7,
                      50,
                      1,
                    ),
                  ),
                  child: Text(
                    'Starts in $remainingTime',
                    // {_formatDuration(_duration)}
                    // s
                    // ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Color.fromRGBO(
                        255,
                        255,
                        255,
                        1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
        // Container(
        //   height: 347,
        //   width: MediaQuery.of(context).size.width,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(20),
        //       image: DecorationImage(
        //         image: NetworkImage(
        //           '${widget.image}',
        //         ),
        //         fit: BoxFit.fitWidth,
        //       )),
        //   child: Padding(
        //     padding: const EdgeInsets.all(16),
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           children: [
        //             Text(
        //               widget.productName,
        //               // 'Iphone 13 pro',
        //               style: TextStyle(
        //                 fontSize: 18,
        //                 fontWeight: FontWeight.w700,
        //                 color: Color(0xffffffff),
        //               ),
        //             ),
        //             Text.rich(TextSpan(children: [
        //               TextSpan(
        //                 text:
        //                     '${widget.currency} ${double.parse((widget.amount * 0.01).toStringAsFixed(2))}  ',
        //                 style: TextStyle(
        //                   fontSize: 18,
        //                   fontWeight: FontWeight.w700,
        //                   color: Color(0xffffffff),
        //                 ),
        //               ),
        //               TextSpan(
        //                 text: '${widget.currency}${widget.amount}  ',
        //                 style: TextStyle(
        //                   decoration: TextDecoration.lineThrough,
        //                   decorationColor: Colors.white,
        //                   fontSize: 18,
        //                   color: Color(0xffffffff),
        //                 ),
        //               ),
        //             ])),
        //           ],
        //         ),
        //         Visibility(
        //           visible: !canJoinContest,
        //           child: Container(
        //             padding: EdgeInsets.symmetric(
        //               horizontal: 10,
        //               vertical: 3,
        //             ),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(4),
        //               color: Color.fromRGBO(
        //                 242,
        //                 7,
        //                 50,
        //                 1,
        //               ),
        //             ),
        //             child: Text(
        //               'Starts in $remainingTime',
        //               // {_formatDuration(_duration)}
        //               // s
        //               // ',
        //               style: TextStyle(
        //                 fontWeight: FontWeight.w500,
        //                 fontSize: 10,
        //                 color: Color.fromRGBO(
        //                   255,
        //                   255,
        //                   255,
        //                   1,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),

        );
  }

  Consumer<MessageProvider> Tap() {
    return Consumer<MessageProvider>(
      builder: (context, provide, child) {
        List<User> messages = provide.messages;
        final user = messages.first;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 36, vertical: 40),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 130,
                        child: Stack(
                          // fit: StackFit
                          //     .expand, // Make the Stack fill the entire container
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Color.fromRGBO(
                                      253, 230, 138, 1), // Border color
                                  width: 5.222, // Border width
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    'https://robohash.org/${username}.png?size=50x50&set=set1'),
                              ),
                            ),
                            Positioned(
                              bottom: -30,
                              left: 0,
                              right: 0,
                              child: Image.asset(
                                // user.profilePhoto
                                'assets/images/stack.png',
                                // Icons.favorite,
                                // color: Colors.red,
                                // size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        username,
                        // 'Chrisdon',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'SpaceGrotesk',
                            color: Color.fromRGBO(21, 21, 45, 1),
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        _timerExpired
                            ? '$message ${widget.productName}'
                            : '$tap',
                        //  Winning this product in',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SpaceGrotesk',
                            color: Color.fromRGBO(21, 21, 45, 1),
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Visibility(
                        visible: !_timerExpired,
                        child: buildTimer(),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Haptics.vibrate(HapticsType.success);
                          if (_timerExpired == true) {
                            print('won');
                            nextPage1(context, page: VoucherScreen());
                          }
                          if (_timerExpired || tapCounter == 0) {
                            return;
                          }
                          _timerExpired
                              ? nextPage1(context, page: VoucherScreen())
                              : seconds <= 0
                                  ? null
                                  : _sendMessage();

                          print(isConnected);

                          if (tapCounter == 0) {
                            // Perform any action when the counter reaches zero
                            print('Button disabled');
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            color: !canJoinContest || tapCounter == 0
                                ? _timerExpired
                                    ? AppColor.primaryColor
                                    : Color(0xffA5B0C1)
                                : AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: _timerExpired
                              ? Text(
                                  'View Voucher',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'SpaceGrotesk',
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontWeight: FontWeight.w700),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tap to win",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Image.asset(
                                          'assets/images/Littlecup.png'),
                                    )
                                  ],
                                ),
                        ),
                      ),
                      Visibility(
                        visible: !_timerExpired,
                        child: SizedBox(
                          height: 12,
                        ),
                      ),
                      Visibility(
                          visible: !_timerExpired,
                          child: Text(
                            '$tapCounter taps remaining!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(92, 92, 92, 1),
                              fontFamily: 'SpaceGrotesk',
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                      Visibility(
                        visible: _timerExpired,
                        child: SizedBox(
                          height: 12,
                        ),
                      ),
                      Visibility(
                          visible: _timerExpired,
                          child: Text(
                            'Contest ended',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.red,
                              fontFamily: 'SpaceGrotesk',
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      Visibility(
                        visible: _timerExpired,
                        child: SizedBox(
                          height: 35,
                        ),
                      ),
                      Visibility(
                          visible: _timerExpired,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Share',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(21, 21, 45, 1),
                                  fontFamily: 'SpaceGrotesk',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Image.asset('assets/images/Share1.png')
                            ],
                          )),
                      Visibility(
                        visible: _timerExpired,
                        child: ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirectionality: BlastDirectionality.explosive,
                          numberOfParticles: 20,
                          gravity: 0.1,
                          emissionFrequency: 0.05,
                          maxBlastForce: 100,
                          minBlastForce: 80,
                          shouldLoop: false,
                          colors: const [
                            Colors.green,
                            Colors.blue,
                            Colors.pink,
                            Colors.orange,
                            Colors.purple,
                          ],
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(235, 235, 235, 1),
                      ),
                      color: Color.fromRGBO(251, 251, 251, 1),
                      borderRadius: BorderRadius.circular(20))),
            ),
          ],
        );
      },
      // child:
    );
  }

  Future<dynamic> join(BuildContext context, HomeProvider homeProvider) {
    currencySymbol = getCurrencySymbol(homeProvider.currency);
    String formattedDiscount =
        NumberFormat('#,##0').format(double.parse(_amount.toStringAsFixed(2)));
    return showDialog(
      context: context,
      builder: (ctx) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  )),
            ),
            Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    // Calculate drag direction
                    if (details.delta.dy < 0) {
                      increment();
                    } else if (details.delta.dy > 0) {
                      decrement();
                    }
                  },
                  child: AlertDialog(
                    actionsPadding:
                        EdgeInsets.symmetric(horizontal: 22, vertical: 24),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    iconColor: Color(0xff858585),
                    surfaceTintColor: Colors.white,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    title: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: ImageIcon(
                              size: 30,
                              color: Colors.grey,
                              AssetImage(
                                'assets/images/closc.png',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Buy Taps To Join Contest',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xff474747),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Purchase taps to gain access to participate in the contest.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff5C5C5C),
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
                              color: Color(0xff5C5C5C),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _textEditingController,
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffF3F3FD),
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffF3F3FD),
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: increment,
                                  child: ImageIcon(
                                    color: Colors.grey,
                                    AssetImage(
                                      'assets/images/add.webp',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: decrement,
                                  child: ImageIcon(
                                    color: Colors.grey,
                                    AssetImage(
                                      'assets/images/minus.png',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Consumer<SearchProvider>(builder: (_, search, __) {
                          currencySymbol = getCurrencySymbol(search.currency);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '1 tap equals ${currencySymbol} ${search.tapprice}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff858585),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: 'Balance: ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff858585),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: '$currencySymbol $formattedDiscount',
                                  // {double.parse(_amount.toStringAsFixed(2))
                                  // }',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xff5C5C5C),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]))
                            ],
                          );
                        }),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                    actions: [
                      customButton(
                        context,
                        padding: 9,
                        onTap: () async {
                          Navigator.pop(context);
                          homeProvider
                              .joinContest(
                            contestId: widget.contestId,
                            tapCount: _textEditingController.text,
                            context: context,
                          )
                              .then((_) async {
                            if (homeProvider.responseText ==
                                "Insufficient balance, top up.") {
                              await Haptics.vibrate(HapticsType.error);
                              topupDialog(context);
                            } else if (homeProvider.responseText ==
                                "Total tap count exceeds the maximum limit.") {
                              await Haptics.vibrate(HapticsType.warning);
                              return;
                            } else if (homeProvider.responseText ==
                                "User successfully joined contest.") {
                              await Haptics.vibrate(HapticsType.success);
                              print('success');
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
                                            actionsPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 22,
                                                    vertical: 24),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12),
                                            iconColor: Color(0xff858585),
                                            surfaceTintColor: Colors.white,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            title: Image.asset(
                                              'assets/images/su2.gif',
                                              height: 100,
                                              width: 100,
                                              repeat: ImageRepeat.noRepeat,
                                            ),
                                            content: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  height: 18,
                                                ),
                                                Text(
                                                  'Purchase Successful!',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromRGBO(
                                                        242, 7, 50, 1),
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'SpaceGrotesk',
                                                  ),
                                                ),
                                                Text(
                                                  'You\'re now ready to dive into the contest and unleash your potential. Let the games begin!',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        92, 92, 92, 1),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SpaceGrotesk',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 43,
                                                ),
                                                child: customButton(
                                                  context,
                                                  padding: 9,
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  text: "Done",
                                                  bgColor:
                                                      AppColor.primaryColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (homeProvider.isLoading == true) {
                              BusyOverlay(
                                title: 'Please wait...',
                                show: true,
                                child: Text(""),
                              );
                            }
                          });
                        },
                        text: "Proceed",
                        bgColor: AppColor.primaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> preview(BuildContext context, HomeProvider homeProvider,
      TextEditingController amount) {
    TextEditingController data = amount;
    return showDialog(
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
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  )),
            ),
            Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: AlertDialog(
                  actionsPadding:
                      EdgeInsets.symmetric(horizontal: 22, vertical: 24),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  iconColor: Color(0xff858585),
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: Image.asset(
                    'assets/images/preview.png',
                    height: 100,
                    width: 100,
                    repeat: ImageRepeat.noRepeat,
                  ),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        'Preview purchase',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(242, 7, 50, 1),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'SpaceGrotesk',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Your total Payment is:'),
                      Text(
                        '${currencySymbol} ${homeProvider.total}',
                        // 'You\'re now ready to dive into the contest and unleash your potential. Let the games begin!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(92, 92, 92, 1),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SpaceGrotesk',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 43,
                      ),
                      child: customButton(
                        context,
                        padding: 9,
                        onTap: () async {
                          Navigator.pop(context);
                          print('start');
                          print(_textEditingController);
                          homeProvider
                              .joinContest(
                            contestId: widget.contestId,
                            tapCount: data.text,
                            context: context,
                          )
                              .then((_) async {
                            if (homeProvider.responseText ==
                                "Insufficient balance, top up.") {
                              await Haptics.vibrate(HapticsType.error);
                              topupDialog(context);
                            } else if (homeProvider.responseText ==
                                "Total tap count exceeds the maximum limit.") {
                              await Haptics.vibrate(HapticsType.warning);
                              return;
                            } else if (homeProvider.responseText ==
                                "User successfully joined contest.") {
                              await Haptics.vibrate(HapticsType.success);
                              print('success');
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
                                            actionsPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 22,
                                                    vertical: 24),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12),
                                            iconColor: Color(0xff858585),
                                            surfaceTintColor: Colors.white,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            title: Image.asset(
                                              'assets/images/su2.gif',
                                              height: 100,
                                              width: 100,
                                              repeat: ImageRepeat.noRepeat,
                                            ),
                                            content: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  height: 18,
                                                ),
                                                Text(
                                                  'Purchase Successful!',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromRGBO(
                                                        242, 7, 50, 1),
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'SpaceGrotesk',
                                                  ),
                                                ),
                                                Text(
                                                  'You\'re now ready to dive into the contest and unleash your potential. Let the games begin!',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        92, 92, 92, 1),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SpaceGrotesk',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 43,
                                                ),
                                                child: customButton(
                                                  context,
                                                  padding: 9,
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  text: "Done",
                                                  bgColor:
                                                      AppColor.primaryColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          });
                          Navigator.pop(context);
                        },
                        text: "Continue to Pay",
                        bgColor: AppColor.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> joinContestModal(BuildContext context) {
    return showDialog(
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
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  )),
            ),
            Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: AlertDialog(
                  // shape: ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12), // Adjust the border radius as needed
                  ),
                  backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product overview',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(71, 71, 71, 1),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'SpaceGrotesk',
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.cancel,
                          )),
                    ],
                  ),
                  content: Container(
                    height: 320,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ]),
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(
                            '${widget.image}',
                          ),
                          fit: BoxFit.cover,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.productName,
                            // 'Iphone 13 pro',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffffffff),
                            ),
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text:
                                  '${widget.currency} ${double.parse((widget.amount * 0.01).toStringAsFixed(2))}  ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffffffff),
                              ),
                            ),
                            TextSpan(
                              text: '${widget.currency}${widget.amount}  ',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white,
                                fontSize: 18,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ])),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
