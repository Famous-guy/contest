import 'dart:ui';

import 'package:contest_app/src/export/export.dart';
import 'package:contest_app/src/providers/connect.dart';
import 'package:contest_app/src/src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  // late List<TextEditingController> _controllers;
  bool connected = false;
  bool _isLoading = false;
  bool _isApiKeyValid = true;
  void _showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: Please input a value.'),
        duration: Duration(seconds: 1),
      ),
    );
    _isLoading = false;
  }

  @override
  void initState() {
    // _controllers = List.generate(
    //   7,
    //   (index) => TextEditingController(),
    // );
    // TODO: implement initState
    super.initState();
    // getContest();
  }

  @override
  // void dispose() {
  //   for (var controller in _controllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

  Future<void> getContest() async {
    await Provider.of<ProfileProvider>(context, listen: false).getVouchers();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      var data = provider.contests;
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                'Vouchers',
                style: PageService.headerStyle,
              ),
              Text(
                'Spendable on 100pay partner site',
                style: TextStyle(
                  fontSize: 9,
                  color: AppColor.gray8,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  connected == true ? 'Connected' : 'Connect',
                  style: TextStyle(
                    color: Color.fromRGBO(
                      22,
                      163,
                      74,
                      1,
                    ),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
        body:
            // RefreshIndicator(
            //   triggerMode: RefreshIndicatorTriggerMode.anywhere,
            //   color: Colors.white,
            //   backgroundColor: Colors.red,
            //   onRefresh: getContest,
            //   child: Consumer<ProfileProvider>(builder: (context, provider, child) {
            //     var data = provider.contests;
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: FutureBuilder<List<Voucher>>(
                    future: provider.getVouchers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "An error occurred when trying to retrive your vouchers from the server",
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else if (snapshot.data!.isEmpty) {
                        return Center(
                          child: Image.asset(
                            'assets/images/vouchers.png',
                            width: 268,
                            height: 143.91,
                          ),
                        );
                      } else {
                        return CustomScrollView(
                          slivers: <Widget>[
                            SliverPadding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return VoucherWidget(
                                      voucher: snapshot.data![index],
                                    );
                                  },
                                  childCount: snapshot.data!.length,
                                ),
                              ),
                            ),
                          ],
                        );
                        // ListView.builder(
                        //   itemCount: snapshot.data!.length,
                        //   itemBuilder: (context, index) {
                        //     return VoucherWidget(
                        //         voucher: snapshot.data![index]);
                        //   },
                        // );
                      }
                    })),
      );
    });
  }
}

class VoucherWidget extends StatefulWidget {
  final Voucher voucher;

  VoucherWidget({
    required this.voucher,
  });

  @override
  State<VoucherWidget> createState() => _VoucherWidgetState();
}

class _VoucherWidgetState extends State<VoucherWidget> {
  late IOWebSocketChannel channel;
  double? cValue;
  bool isInputFocused = false;
  // late List<TextEditingController> _controllers;
  @override
  void initState() {
    // _controllers = List.generate(
    //   7,
    //   (index) => TextEditingController(),
    // );
    super.initState();
    connectToWebSocket();
  }

  @override
  void dispose() {
    // for (var controller in _controllers) {
    //   controller.dispose();
    // }
    // Close WebSocket connection when the widget is disposed
    channel.sink.close();
    super.dispose();
  }

  void connectToWebSocket() {
    // Establish WebSocket connection
    channel = IOWebSocketChannel.connect(
      'ws://jfxrates.com/websocket/asset-price/',
      headers: {
        'pair': 'pay_usdt',
        'fiat': 'ngn',
        'interval': 0,
      },
    );

    // Listen for messages from the WebSocket server
    channel.stream.listen(
      (message) {
        print('Received message: $message');

        Map<String, dynamic> data = json.decode(message);

        setState(() {
          cValue = data['data']['price'];

          print('Price: $cValue');
        });
      },
      onError: (error) {
        print('Error occurred: $error');
        // Handle errors here
      },
      onDone: () {
        print('WebSocket connection closed');
        // Handle WebSocket connection closed
      },
    );
  }

  String currencySymbol = '';
  String getCurrencySymbol(String? currency) {
    if (currency != null && currencies.containsKey(currency)) {
      return currencies[currency]!;
    } else {
      return ''; // Return empty string if currency not found
    }
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    Fluttertoast.showToast(
      msg: "Vocher code Copied",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Copied to clipboard'),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    String code = widget.voucher.code;
    String firstThree = code.substring(0, 3);
    String lastThree = code.substring(code.length - 3);
    String formattedDiscount =
        NumberFormat('#,##0').format(widget.voucher.discount);
    String formattedDiscountwithdraw =
        NumberFormat('#,##0').format(widget.voucher.discount - 6);
    String formattedconvert = NumberFormat('#,##0')
        .format(widget.voucher.discount * double.parse('${cValue ?? 31.888}'));
    NumberFormat('#,##0').format(widget.voucher.discount);
    currencySymbol = getCurrencySymbol('${widget.voucher.voucherCurrency}');

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: ShapeDecoration(
              shape: SwTicketBorder(
                radius: 8,
                fillColor: AppColor.primaryColor,
                borderColor: AppColor.primaryColor,
                borderWidth: 2,
                bottomLeft: false,
                bottomRight: true,
                topLeft: false,
                topRight: true,
              ),
            ),
            child: Column(
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: '\$PAY ${formattedDiscount}',
                      style: TextStyle(
                          color: AppColor.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700)),
                ])),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'NGN $formattedconvert',
                  style: TextStyle(
                    fontSize: 9,
                    color: AppColor.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  border: Border(
                      top: BorderSide(color: Color(0xffF3F4F6), width: 1),
                      bottom: BorderSide(color: Color(0xffF3F4F6), width: 1),
                      right: BorderSide(color: Color(0xffF3F4F6), width: 1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      _copyToClipboard(context, code);
                                    },
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Voucher code: ',
                                          ),
                                          TextSpan(
                                            text: firstThree,
                                          ),
                                          TextSpan(
                                            text: '***',
                                          ),
                                          TextSpan(
                                            text: lastThree,
                                          ),
                                        ],
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Color(
                              0xfff20732,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: const Text(
                          'Use voucher',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
