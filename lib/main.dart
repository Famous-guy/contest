import 'dart:async';
import 'dart:developer';
import 'dart:html' as html;

import 'package:app_links/app_links.dart';
import 'package:contest_app/lifecyclehandler.dart';
import 'package:contest_app/src/constants/appcolors.dart';
import 'package:contest_app/src/models/userdata.dart';
import 'package:contest_app/src/providers/providers.dart';
import 'package:contest_app/src/providers/user.profile.provider.dart';
import 'package:contest_app/src/screens/screens.dart';
import 'package:contest_app/src/screens/splash/splash.screen.dart';
import 'package:contest_app/src/src/make_api_call.dart';
import 'package:contest_app/src/utils/utils.dart';
import 'package:contest_app/src/widgets/widgets.dart';
// import 'package:contest_app/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:ui' as ui;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<UserData> getUserDataFromPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String publicKey = prefs.getString('publicKey') ?? '';
  String email = prefs.getString('email') ?? '';
  String phone = prefs.getString('phone') ?? '';
  String accountName = prefs.getString('accountName') ?? '';
  String currency = prefs.getString('currency') ?? '';
  String accountId = prefs.getString('accountId') ?? '';
  String businessId = prefs.getString('businessId') ?? ''; // Corrected line
  String token = prefs.getString('100pay_token') ?? '';

  return UserData(
    publicKey: publicKey,
    email: email,
    phone: phone,
    accountName: accountName,
    currency: currency,
    accountId: accountId,
    businessId: businessId,
    token: token,
  );
}

// Future<UserData> getUserDataFromPrefs() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String publicKey = prefs.getString('publicKey') ?? '';
//   String email = prefs.getString('email') ?? '';
//   String phone = prefs.getString('phone') ?? '';
//   String accountName = prefs.getString('accountName') ?? '';
//   String currency = prefs.getString('currency') ?? '';
//   String accountId = prefs.getString('accountId') ?? '';
//   String businessId = prefs.getString('businessId') ?? ''; // Corrected line
//   String token = prefs.getString('100pay_token') ?? '';

//   return UserData(
//     publicKey: publicKey,
//     email: email,
//     phone: phone,
//     accountName: accountName,
//     currency: currency,
//     accountId: accountId,
//     businessId: businessId,
//     token: token,
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final lifecycleObserver = LifecycleEventHandler(
    onResume: () {
      print('App resumed');
      removeOverlay();
    },
    onPause: () {
      print('App paused');
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        if (navigatorKey.currentContext != null) {
          showFloatingIcon(navigatorKey.currentContext!);
        }
      });
    },
  );

  WidgetsBinding.instance?.addObserver(lifecycleObserver);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: primaryColor,
    statusBarBrightness: Brightness.dark,
  ));

  runApp(StateManager(child: MyApp()));
  // if (kIsWeb) {
  //   MakeApiCall uri = MakeApiCall();
  //   print('this is ${MakeApiCall.respons}');
  //   ui.platformViewRegistry.registerViewFactory('iframeElement', (int viewId) {
  //     final iframe = IFrameElement()
  //       ..style.border = 'none'
  //       ..style.width = '100%' // Set iframe width
  //       ..style.height = '100%'; // Set iframe height

  //     // Get the URL dynamically
  //     // final url =
  //     // 'https://pay.100pay.co/pay/66417f18c536a8002cff2c26'; // Replace getUrl() with your method to get the URL dynamically
  //     iframe.src = MakeApiCall.respons; // Set iframe src

  //     return iframe;
  //   });
  // }
  if (kIsWeb) {
    print('this is ${MakeApiCall.respons}');
    // Register view factory for the iframe element
    ui.platformViewRegistry.registerViewFactory('iframeElement', (int viewId) {
      // Create the iframe element
      final iframe = html.IFrameElement()
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%';

      // Set the iframe source URL
      final url = MakeApiCall.respons;
      iframe.src = url;

      // Listen for the "load" event on the iframe
      iframe.addEventListener('load', (event) {
        print('loading');

        // Perform actions when the iframe finishes loading
        final show100PayWrapper =
            html.document.getElementById('show100PayWrapper');
        show100PayWrapper?.classes.add('show');

        // Add any additional actions here, such as appending elements to the DOM
        // Example:
        // img_wrapper.appendChild(vic_hand_img);
        // img_wrapper.appendChild(connected_img);
      });
      html.window.addEventListener('message', (event) {
        final data = event; // Access the event object directly
        print({'type': data.runtimeType, 'data': data});
        if (data is html.MessageEvent) {
          // Check if it's a MessageEvent
          final messageData =
              data.data; // Access the data property of the MessageEvent
          if (messageData is String) {
            final checkData = messageData.split('_');
            if (checkData.length == 2 && checkData[0] == '100PAY-PAYMENT-REF') {
              // Perform the action when the payment reference is received
              // For example, call the charge.onPayment function with the payment reference
              // charge.onPayment(checkData[1]);
              print(checkData[1]);
              print('success');
            }
          }
        }
      });

      return iframe;
    });
  }
  // if (kIsWeb) {
  //   ui.platformViewRegistry.registerViewFactory('iframeElement', (int viewId) {
  //     final iframe = html.IFrameElement()
  //       ..style.border = 'none'
  //       ..style.width = '100%' // Set iframe width
  //       ..style.height = '100%'; // Set iframe height

  //     // Get the URL dynamically
  //     final url = 'https://pay.100pay.co/pay/66417f18c536a8002cff2c26';
  //     iframe.src = url; // Set iframe src

  //     // Define JavaScript function to handle events
  //    final script = '''
  //       window.addEventListener('load', function() {
  //         // Send message to Flutter when the load event occurs
  //         window.parent.postMessage('load', '*');
  //       });
  //     ''';

  //     // Create a script element and add the JavaScript code to it
  //     final scriptElement = html.ScriptElement()..text = script;
  //     // Add the script element to the document body
  //     html.document.body!.append(scriptElement);

  //     return iframe;
  //   });
  // }
  // if (kIsWeb) {
  //   ui.platformViewRegistry.registerViewFactory('iframeElement', (int viewId) {
  //     final iframe = IFrameElement()
  //       ..src = 'flutter.html' // Replace with the path to your HTML file
  //       ..style.border = 'none';
  //     return iframe;
  //   });
  // }
}

void showFloatingIcon(BuildContext context) {
  OverlayEntry floatingIconEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.8,
      left: MediaQuery.of(context).size.width * 0.8,
      child: FloatingActionButton(
        onPressed: () {
          print('Floating icon tapped');
          // Add logic here to handle tap on the floating icon
        },
        child: Icon(Icons.play_arrow),
        backgroundColor: Colors.blue,
      ),
    ),
  );

  Overlay.of(context).insert(floatingIconEntry);
}

void removeOverlay() {
  floatingIconEntry?.remove();
}

OverlayEntry? floatingIconEntry;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    initDeepLinks();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      context.read<LeaderboardProvider>().fetchLeaderboard();
      context.read<HomeProvider>().getPastContests();
      context.read<HomeProvider>().fetchSupportedContests();
      context.read<HomeProvider>().fetchContests();
      context.read<BalanceProvider>().fetchBalance();
      context.read<UserProfileProvider>().fetchUserProfile();
      context.read<ProfileProvider>().getVouchers();
    });
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null) {
      log('getInitialAppLink: $appLink');
      openAppLink(appLink);
    }
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      log('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    log("path ${uri.path}");
    log("fragment ${uri.hasQuery}");
    if (uri.queryParameters['contestid'] != null) {
      init(id: uri.queryParameters["contestid"].toString());
    }
  }

  void init({required String id}) async {
    await TokenUtil.checkToken().then((isExpire) async {
      if (isExpire!) {
        navKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
          (route) => false,
        );
      } else {
        await TokenUtil.retrieveToken().then((user) {
          if (user != null) {
            navKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MainActivityPage(
                  contestid: id,
                ),
              ),
              (route) => false,
            );
          } else {
            nextPage(context, page: SignInScreen());
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'SpaceGrotesk',
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          elevation: 0,
        ),
        highlightColor: Colors.white,
        primaryColor: AppColor.primaryMaterialColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColor.primaryMaterialColor,
        ).copyWith(secondary: AppColor.primaryMaterialColor),
      ),
      home: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 600, // Adjust the max width as needed
          ),
          child:
              LoadingScreen(), // Assuming LoadingScreen is your starting screen
        ),
      ),
    );
  }
}
