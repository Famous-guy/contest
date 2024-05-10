// import 'package:app_links/app_links.dart';
// import 'package:contest_app/lifecyclehandler.dart';
// import 'package:contest_app/src/providers/user.profile.provider.dart';
// import 'package:contest_app/src/screens/splash/splash.screen.dart';
// import 'package:contest_app/src/src.dart';
// import 'package:flutter/services.dart';
// import 'src/export/export.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   final lifecycleObserver = LifecycleEventHandler(
//     // onResume: () {
//     //   print('App resumed'); // Placeholder for handling app resume event
//     // },
//     // onPause: () {
//     //   print('App paused'); // Placeholder for handling app pause event
//     // },
//     onResume: () {
//       print('App resumed');
//       // Remove the floating icon when the app is resumed
//       removeOverlay();
//     },
//     onPause: () {
//       print('App paused');
//       // Show the floating icon when the app is paused
//       showFloatingIcon();
//     },
//   );

//   WidgetsBinding.instance.addObserver(lifecycleObserver);

//   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     statusBarColor: primaryColor, // status bar color
//     statusBarBrightness: Brightness.dark,
//   ));
//   runApp(
//       // navigatorKey,
//       //  navigatorKey: navigatorKey,
//       StateManager(child: MyApp()));
// }

// void showFloatingIcon() {
//   OverlayEntry floatingIconEntry = OverlayEntry(
//     builder: (context) => Positioned(
//       top: MediaQuery.of(context).size.height * 0.8,
//       left: MediaQuery.of(context).size.width * 0.8,
//       child: FloatingActionButton(

//         onPressed: () {
//           // Add your logic here to handle tap on the floating icon
//           print('Floating icon tapped');
//         },
//         child: Icon(Icons.play_arrow),
//         backgroundColor: Colors.blue,
//       ),
//     ),
//   );

//   Overlay.of(navigatorKey.currentContext!)?.insert(floatingIconEntry);
// }

// void removeOverlay() {
//   floatingIconEntry?.remove();
// }

// OverlayEntry? floatingIconEntry;

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late AppLinks _appLinks;

//   StreamSubscription<Uri>? _linkSubscription;

//   @override
//   void initState() {
//     super.initState();
//     initDeepLinks();
//     WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
//       context.read<LeaderboardProvider>().fetchLeaderboard();
//       context.read<HomeProvider>().getPastContests();
//       context.read<HomeProvider>().fetchSupportedContests();
//       context.read<HomeProvider>().fetchContests();
//       context.read<BalanceProvider>().fetchBalance();
//       context.read<UserProfileProvider>().fetchUserProfile();
//       context.read<ProfileProvider>().getVouchers();
//     });
//   }

//   Future<void> initDeepLinks() async {
//     _appLinks = AppLinks();

//     final appLink = await _appLinks.getInitialAppLink();
//     if (appLink != null) {
//       log('getInitialAppLink: $appLink');
//       openAppLink(appLink);
//     }
//     _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
//       log('onAppLink: $uri');
//       openAppLink(uri);
//     });
//   }

//   void openAppLink(Uri uri) {
//     log("path ${uri.path}");
//     log("fragment ${uri.hasQuery}");
//     if (uri.queryParameters['contestid'] != null) {
//       init(id: uri.queryParameters["contestid"].toString());
//     }
//   }

//   void init({required String id}) async {
//     await TokenUtil.checkToken().then((isExpire) async {
//       if (isExpire!) {
//         // nextPage(context, page: SignInScreen());
//         navKey.currentState?.pushAndRemoveUntil(
//           MaterialPageRoute(
//             builder: (context) => const SignInScreen(),
//           ),
//           (route) => false,
//         );
//       } else {
//         await TokenUtil.retrieveToken().then((user) {
//           if (user != null) {
//             // nextPage(context, page: MainActivityPage());
//             navKey.currentState?.pushAndRemoveUntil(
//               MaterialPageRoute(
//                 builder: (context) => MainActivityPage(
//                   contestid: id,
//                 ),
//               ),
//               (route) => false,
//             );
//           } else {
//             nextPage(context, page: SignInScreen());
//           }
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: navigatorKey,
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.white,
//         fontFamily: 'SpaceGrotesk',
//         appBarTheme: const AppBarTheme(
//           systemOverlayStyle: SystemUiOverlayStyle.light,
//           backgroundColor: Colors.white,
//           scrolledUnderElevation: 0,
//           elevation: 0,
//         ),
//         highlightColor: Colors.white,
//         primaryColor: AppColor.primaryMaterialColor,
//         colorScheme: ColorScheme.fromSwatch(
//           primarySwatch: AppColor.primaryMaterialColor,
//         ).copyWith(secondary: AppColor.primaryMaterialColor),
//       ),
//       home: LoadingScreen(),
//     );
//   }
// }

import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:contest_app/lifecyclehandler.dart';
import 'package:contest_app/src/providers/user.profile.provider.dart';
import 'package:contest_app/src/screens/splash/splash.screen.dart';
import 'package:contest_app/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   final lifecycleObserver = LifecycleEventHandler(
//     onResume: () {
//       print('App resumed');
//       removeOverlay();
//     },
//     onPause: () {
//       print('App paused');
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         showFloatingIcon();
//       });
//     },
//   );

//   WidgetsBinding.instance.addObserver(lifecycleObserver);

//   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     statusBarColor: primaryColor,
//     statusBarBrightness: Brightness.dark,
//   ));

//   runApp(StateManager(child: MyApp()));
// }

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

// void showFloatingIcon() {
//   OverlayEntry floatingIconEntry = OverlayEntry(
//     builder: (context) => Positioned(
//       top: MediaQuery.of(context).size.height * 0.8,
//       left: MediaQuery.of(context).size.width * 0.8,
//       child: FloatingActionButton(
//         onPressed: () {
//           print('Floating icon tapped');
//           // Add logic here to handle tap on the floating icon
//         },
//         child: Icon(Icons.play_arrow),
//         backgroundColor: Colors.blue,
//       ),
//     ),
//   );

//   Overlay.of(navigatorKey.currentContext!).insert(floatingIconEntry);
// }

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
      navigatorKey: navigatorKey,
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
      home: LoadingScreen(),
    );
  }
}
