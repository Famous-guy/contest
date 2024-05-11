'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "ae16634483b38eea4803897a256b5832",
"macos/Runner.xcworkspace/contents.xcworkspacedata": "7053ea3423578187357b9f92d0c67fc6",
"macos/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist": "117105d2f2ee718eb485a07574a219b6",
"macos/RunnerTests/RunnerTests.swift": "6268cffb63d969b61f7b4e3005239256",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_16.png": "8bf511604bc6ed0a6aeb380c5113fdcf",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png": "c9becc9105f8cabce934d20c7bfb6aac",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_256.png": "dfe2c93d1536ae02f085cc63faa3430e",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_64.png": "04e7b6ef05346c70b663ca1d97de3ad5",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png": "0ad44039155424738917502c69667699",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_128.png": "3ded30823804caaa5ccc944067c54a36",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json": "5bd47c3ef1d1a261037c87fb3ddb9cfd",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png": "8e0ae58e362a6636bdfccbc04da2c58c",
"macos/Runner/DebugProfile.entitlements": "6e164fc6ed6acb30c71fe12e29e49642",
"macos/Runner/Base.lproj/MainMenu.xib": "a41bc20792a7e771d7901124cdb8c835",
"macos/Runner/MainFlutterWindow.swift": "4a747b1f256d62a2bbb79bd976891eb5",
"macos/Runner/Configs/AppInfo.xcconfig": "2895a6639db84581e9e4229d25cab6cd",
"macos/Runner/Configs/Debug.xcconfig": "0a7555f820f3e4371d88ec1c339d70ef",
"macos/Runner/Configs/Release.xcconfig": "d36330778580798c0d9c5a5b71501a0f",
"macos/Runner/Configs/Warnings.xcconfig": "e19c2368cf97e5f3eaf8de37cff2b341",
"macos/Runner/AppDelegate.swift": "ce90ac27873ef28bc53a7dbc142459e5",
"macos/Runner/Info.plist": "b945a5051bb1cca2d906ac0be98b629a",
"macos/Runner/Release.entitlements": "e6fde05dec64f9856d3978a4a5e4bf48",
"macos/Runner.xcodeproj/project.pbxproj": "9a62a924f73c736a604987d335a1c062",
"macos/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist": "117105d2f2ee718eb485a07574a219b6",
"macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme": "026db54045e78732594255c9de4e8197",
"macos/Flutter/Flutter-Debug.xcconfig": "2b03faed3e462ed0ed348559e4796ed8",
"macos/Flutter/GeneratedPluginRegistrant.swift": "c840bc53b61279c2fb631741134c2ed7",
"macos/Flutter/Flutter-Release.xcconfig": "2b03faed3e462ed0ed348559e4796ed8",
"macos/Flutter/ephemeral/flutter_export_environment.sh": "eede10b0e12fe6f11f82bde2f8b9a610",
"macos/Flutter/ephemeral/Flutter-Generated.xcconfig": "b222f158b8e9c8e984d16c4041af912f",
"index.html": "256cb8988c26b7102740a6f112f79540",
"/": "256cb8988c26b7102740a6f112f79540",
"test/widget_test.dart": "cb2dd7128b72a5807c36cba95bd6bbc4",
"main.dart.js": "dc5ccd72739a640f05f8a05d4287036a",
"web/index.html": "0f3a35c48fe76e0d837e63459552f532",
"web/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"web/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"web/icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"web/icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"web/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"web/manifest.json": "c941e4ab19a66120037d3a3efc09ad84",
"pubspec.lock": "6349fa5b1c5b4d499683f5f87b8072d4",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"ios/Runner.xcworkspace/contents.xcworkspacedata": "7053ea3423578187357b9f92d0c67fc6",
"ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist": "117105d2f2ee718eb485a07574a219b6",
"ios/Runner.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings": "56b1e4b1f6b3b790f471044c301e69ea",
"ios/RunnerTests/RunnerTests.swift": "a225a382d14d7b16b6f602a5c1d49331",
"ios/Runner/Runner-Bridging-Header.h": "e07862ac930ed4d8479185d52c6cc66d",
"ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png": "978c1bee49d7ad5fc1a4d81099b13e18",
"ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png": "978c1bee49d7ad5fc1a4d81099b13e18",
"ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md": "e175e436acacf76c814d83532d0b662c",
"ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json": "770f4f65e02ca2fc57f46f4f4148d15d",
"ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png": "978c1bee49d7ad5fc1a4d81099b13e18",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png": "643842917530acf4c5159ae851b0baf2",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png": "be8887071dd7ec39cb754d236aa9584f",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png": "2247a840b6ee72b8a069208af170e5b1",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png": "a2f8558fb1d42514111fbbb19fb67314",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png": "c785f8932297af4acd5f5ccb7630f01c",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png": "665cb5e3c5729da6d639d26eff47a503",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png": "1b3b1538136316263c7092951e923e9d",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json": "c3cdf9688b604d14f2e76a8287e16167",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png": "2247a840b6ee72b8a069208af170e5b1",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png": "2b1452c4c1bda6177b4fbbb832df217f",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png": "8245359312aea1b0d2412f79a07b0ca5",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png": "e419d22a37bc40ba185aca1acb6d4ac6",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png": "5b3c0902200ce596e9848f22e1f0fe0e",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png": "36c0d7a7132bdde18898ffdfcfcdc4d2",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png": "5b3c0902200ce596e9848f22e1f0fe0e",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png": "043119ef4faa026ff82bd03f241e5338",
"ios/Runner/GeneratedPluginRegistrant.h": "decb9041b5e91a07e66f4664e5dac408",
"ios/Runner/Base.lproj/LaunchScreen.storyboard": "89e8363b3b781ee4977c3c9422b88a37",
"ios/Runner/Base.lproj/Main.storyboard": "0e0faca0bc5766e8640496223a31706a",
"ios/Runner/AppDelegate.swift": "640effd31ad5be56ac222976d95a5878",
"ios/Runner/GeneratedPluginRegistrant.m": "f6079b630997f8fd4ae1ac639162419a",
"ios/Runner/Info.plist": "e25ceb4176f3b7d42390b4f75b02c720",
"ios/Runner.xcodeproj/project.pbxproj": "3e1372d1c82186574c3fa51f10d7b287",
"ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata": "a54b6450d65c401d48911394f6a65bd2",
"ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist": "117105d2f2ee718eb485a07574a219b6",
"ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings": "56b1e4b1f6b3b790f471044c301e69ea",
"ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme": "ffac881d52d43c06cc1b45b6aeabc194",
"ios/Flutter/flutter_export_environment.sh": "b5e9c5b54f7cb0869d3a06fcbabdd5ff",
"ios/Flutter/Debug.xcconfig": "bd6254e10068a9a3539aa9710626ac24",
"ios/Flutter/Release.xcconfig": "bd6254e10068a9a3539aa9710626ac24",
"ios/Flutter/AppFrameworkInfo.plist": "5eb1ee18836d512da62e476379865f8d",
"ios/Flutter/Generated.xcconfig": "67336dcae2c0919618c13da5e975d815",
"README.md": "ac18482fc28234fc361bcd7776f73e29",
"favicon.png": "5a175caeab952e34023b655f8b56fce0",
"pubspec.yaml": "cac2dffbcd8e66158433eae4b6c90f3a",
"linux/main.cc": "0643b8609698e96b3abd63c210361a87",
"linux/CMakeLists.txt": "a76fcaf519749b6cebb60716ccf198ba",
"linux/my_application.h": "7bd839b67ebee22174be9f4da4521b6f",
"linux/my_application.cc": "c4a85ac462a00b924c82e3699eea1c7a",
"linux/flutter/generated_plugin_registrant.cc": "d07afe003d5837167bdd357d593f20a0",
"linux/flutter/CMakeLists.txt": "46690fb8ffaf7d227d8bc4713f31140d",
"linux/flutter/generated_plugins.cmake": "e973b0a9c4bf1b7cba923da57b4fbf45",
"linux/flutter/generated_plugin_registrant.h": "d295462c9da9f7fef22dc86c34492318",
"android/app/build.gradle": "a54268d24ded8061a0f97d1c38de6cdd",
"android/app/src/profile/AndroidManifest.xml": "ac1dad6fec40014c3c6cbbd849a880dc",
"android/app/src/main/res/mipmap-mdpi/ic_launcher.png": "6270344430679711b81476e29878caa7",
"android/app/src/main/res/mipmap-hdpi/ic_launcher.png": "13e9c72ec37fac220397aa819fa1ef2d",
"android/app/src/main/res/drawable/launch_background.xml": "79c59c987bd2e693cd741ec3035ef383",
"android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png": "57838d52c318faff743130c3fcfae0c6",
"android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png": "afe1b655b9f32da22f9a4301bb8e6ba8",
"android/app/src/main/res/values-night/styles.xml": "feddd27a2f77ef486e2b7a420b1de43d",
"android/app/src/main/res/values/styles.xml": "58b48ec178bde5aad76063577172ad24",
"android/app/src/main/res/drawable-v21/launch_background.xml": "ab00f2bfdce1a5187d1ba31e9e68b921",
"android/app/src/main/res/mipmap-xhdpi/ic_launcher.png": "a0a8db5985280b3679d99a820ae2db79",
"android/app/src/main/AndroidManifest.xml": "277733986f9bfee25fba8c75afbb327c",
"android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java": "5b3b418ce50367c33bded3c0df06d47f",
"android/app/src/main/kotlin/com/example/web/MainActivity.kt": "c7db54b36dace1e3b8f26b1bc713377a",
"android/app/src/debug/AndroidManifest.xml": "ac1dad6fec40014c3c6cbbd849a880dc",
"android/local.properties": "f8c33dcfa8df9635a3ad98d56fb67681",
"android/web_android.iml": "e631be658ada5ed327bf47f851a6ed5b",
"android/gradle/wrapper/gradle-wrapper.jar": "3ef954ed0adb79a5bd8a5303165fae05",
"android/gradle/wrapper/gradle-wrapper.properties": "8326b56294256808fb7a0f9cf951861f",
"android/gradlew": "7f1cd7eb3f75a1dc85cd37753972a6e2",
"android/build.gradle": "49bd0f7b88d0a680032394990a85627f",
"android/.gradle/vcs-1/gc.properties": "d41d8cd98f00b204e9800998ecf8427e",
"android/.gradle/7.6.3/executionHistory/executionHistory.lock": "a8d443931d32e9b600bfcb462181267c",
"android/.gradle/7.6.3/gc.properties": "d41d8cd98f00b204e9800998ecf8427e",
"android/.gradle/7.6.3/fileChanges/last-build.bin": "93b885adfe0da089cdf634904fd59f71",
"android/.gradle/7.6.3/dependencies-accessors/gc.properties": "d41d8cd98f00b204e9800998ecf8427e",
"android/.gradle/7.6.3/dependencies-accessors/dependencies-accessors.lock": "2e0baf58811c78ba3e7e36c4ad2c4b87",
"android/.gradle/7.6.3/checksums/checksums.lock": "df28c670f265b551e66843c47ff7938f",
"android/.gradle/7.6.3/fileHashes/fileHashes.lock": "aec6385a83149951e55823ef46f3682c",
"android/.gradle/7.6.3/fileHashes/fileHashes.bin": "d76d41515db39ff18c74cbfc96b8af92",
"android/.gradle/buildOutputCleanup/cache.properties": "f149d03a458a24716a567b645cf51ce7",
"android/.gradle/buildOutputCleanup/buildOutputCleanup.lock": "1839b74af2c0eb9ba95ea133fec2ebbd",
"android/gradle.properties": "efccfb9decfb7feee9f4cc9a62cd43e6",
"android/gradlew.bat": "375ddea382b6c56a7be2a967a20e0ab5",
"android/settings.gradle": "e89e3890bc2889b9c36244c2dce37164",
"icons/icon-144.png": "f92aae37335bc32fec472e80f7bcf196",
"icons/icon-192.png": "9dad87a7b8349dd80b3a16d1dd175fc0",
"icons/icon-384.png": "a0735c89c9df7e8b124f7bbd2a3dc8ab",
"icons/icon-152.png": "2f87be3bcf4b280c3ff9fbc301a8d02d",
"icons/icon-72.png": "dae71046ea615a76d4a523878351750c",
"icons/icon-96.png": "ab4807275651948ff4aba11fa5509e94",
"icons/icon-128.png": "641ff7f3ed0691efee7d6fc751cbc7dc",
"icons/icon-512.png": "72adfb583ebb33c0cafaa7fcd262dcc5",
"manifest.json": "c941e4ab19a66120037d3a3efc09ad84",
"lib/main.dart": "86b0318255916c11ea138782b971c22e",
"analysis_options.yaml": "66d03d7647c8e438164feaf5b922d44a",
".dart_tool/package_config.json": "dc0b3035ca99ae6ad9d0438ef55e199f",
".dart_tool/extension_discovery/README.md": "606241196f08642dcc9f7acef0d2d8da",
".dart_tool/extension_discovery/vs_code.json": "afcafc3d0feb52770dec8502c9637406",
".dart_tool/dartpad/web_plugin_registrant.dart": "7ed35bc85b7658d113371ffc24d07117",
".dart_tool/package_config_subset": "098177e0b0cd58c6667be7c9e35e235c",
".dart_tool/version": "ce7714c171cde299e1ca4d9486dab380",
"windows/CMakeLists.txt": "94af68136e6e5b46aa0042682f5bac0a",
"windows/runner/flutter_window.cpp": "9b92b95a9eecce25e3e9d356688d0cb6",
"windows/runner/utils.h": "c741fb9cddbf3a62f4688b6cca39ddcc",
"windows/runner/utils.cpp": "c8ab2070ab710025a405b8e44dd7174d",
"windows/runner/runner.exe.manifest": "19a145783806442d541438903cc9be98",
"windows/runner/CMakeLists.txt": "e99a99b5cc82a168fc557eb23b8d5a96",
"windows/runner/win32_window.h": "5a4cf051798d7e6931ee0405a4523c8f",
"windows/runner/win32_window.cpp": "928e86a2be27eca688669dce6c9177d9",
"windows/runner/resources/app_icon.ico": "6ea04d80ca2a3fa92c7717c3c44ccc19",
"windows/runner/resource.h": "c8f809a4f8d3f2f625e358fd90f72fee",
"windows/runner/Runner.rc": "40f2265c0218715535ee55765899bcb0",
"windows/runner/main.cpp": "3a8985ef77836fcfa1aaee2376b0394a",
"windows/runner/flutter_window.h": "79bea736711adda00c49419a39a4a0b4",
"windows/flutter/generated_plugin_registrant.cc": "a8f91348d8d9090f22ec69d597c41e1f",
"windows/flutter/CMakeLists.txt": "0c500410e3259a9a053797dc1c28070e",
"windows/flutter/generated_plugins.cmake": "620906318e8c8297f3bc95b445ce4c47",
"windows/flutter/generated_plugin_registrant.h": "0ea33875f9f8e118f9c2ded03e2e2835",
"web.iml": "731a1a3080009db8d4572ef3fb1679c3",
"assets/AssetManifest.json": "13454ecd4ab6f16ac0b5d39a85e95acc",
"assets/NOTICES": "812bc95eebcedd555642e0d649a4ec75",
"assets/FontManifest.json": "e3476576affa1e39b279997ba28d4d0d",
"assets/AssetManifest.bin.json": "327a1c50d15cc3dac2a940083f240508",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "c2716c0888c37a8398f61cdb972c43e2",
"assets/packages/fluttertoast/assets/toastify.js": "18cfdd77033aa55d215e8a78c090ba89",
"assets/packages/fluttertoast/assets/toastify.css": "910ddaaf9712a0b0392cf7975a3b7fb5",
"assets/packages/country_picker_plus/assets/countries.json": "749b93bc81bc59bfe645ed591805ac4d",
"assets/packages/currency_picker/lib/src/res/no_flag.png": "3f454777dfe9b6aae5e9d8544f4fa6f6",
"assets/packages/currency_picker/lib/src/res/xof.png": "5843e487ecffd9d3dcd01c1070cc6c6a",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "901e10d580a1b876cd3b10d07259973c",
"assets/fonts/SpaceGrotesk-Light.ttf": "021142e7734a57a1a48ca495158863cf",
"assets/fonts/SpaceGrotesk-Regular.ttf": "7f510d38d1c785c851d73882c0ca58c0",
"assets/fonts/SpaceGrotesk-SemiBold.ttf": "73a35ae608e5c13b794c5f893b67bf61",
"assets/fonts/SpaceGrotesk-Medium.ttf": "705b51b5e52edb8d669adf36eac8f771",
"assets/fonts/MaterialIcons-Regular.otf": "6185b5696a992249d1846755b4a31e37",
"assets/fonts/SpaceGrotesk-Bold.ttf": "a17e24dc3fccc03e32a6e66100fb05df",
"assets/assets/images/close.jpeg": "e8feba79522d010452c855bc4b6ca976",
"assets/assets/images/smallcup.png": "216252c42c76654615ffc122ef20a260",
"assets/assets/images/add.png": "b53bc3a62f326ab91125cc8fa87014dc",
"assets/assets/images/voulcher.png": "8d426eb5445803439d58dcd8827803fe",
"assets/assets/images/backgrund.png": "31a29c15ce2d7b280459bfd6c541740b",
"assets/assets/images/img_frame_1171275325_2.png": "c206787dfef1f221e2289bab82fe97bb",
"assets/assets/images/trophy.png": "99c7a009670138ed52ebd6057975f9e0",
"assets/assets/images/Share1.png": "29221bd20d1a02d2fcb556806f807267",
"assets/assets/images/support.png": "687813263d80ab8323f58333c93a330b",
"assets/assets/images/mdi_password.png": "d161dad8feee6abbbf0a9f7da97eab81",
"assets/assets/images/line2.png": "22f169d76946da93f5bb4afd043938f8",
"assets/assets/images/preview.jpg": "feab0f1b1509d541529caf9978c06861",
"assets/assets/images/preview.png": "881ecc78954b4903c61cd49646b232b5",
"assets/assets/images/img_frame_1171275325_1.png": "8505a12912e5eb0283bb67da49168e88",
"assets/assets/images/successcheck.png": "018b77242847f98df904971e8fbc9691",
"assets/assets/images/earpod.png": "398d2fff29d1ff117b3f7dfd91deda47",
"assets/assets/images/Leadership.png": "dcaf5eb643d456b35a289f7931f8d776",
"assets/assets/images/pay100.png": "219c58e8abd1ece2dc2919cf5bfa975b",
"assets/assets/images/vouchers.png": "0378c9b7715af6116580cebdeeb48e36",
"assets/assets/images/Frame%25201171275202.png": "a8a0b30fb86acd93032b9a9e8c62d17d",
"assets/assets/images/cancle.png": "5a52466f5d09fd5ada0f3539fc4a3ca4",
"assets/assets/images/unsplash_p91W9-rrhLA.png": "b68ec2af11d5481b0d5a0e53870fa7ef",
"assets/assets/images/boyface.png": "08276af94c701352329d6909c8358af4",
"assets/assets/images/img_frame_1171275325.png": "cb4912734c89de022e8192a445a5be48",
"assets/assets/images/img_avatar.png": "48d4de08c872aba654e9c6b6387f0979",
"assets/assets/images/Ellipse.png": "c0f5e4c6529f3a5db0f671ddc793b3fe",
"assets/assets/images/store.png": "0d3eece3d2f2a8cd17b8c35e1f85c459",
"assets/assets/images/Vector%2520(3).png": "63b7f0737cc9440e0c41fce8368d2f47",
"assets/assets/images/Instagram.png": "349628f32819c4b2ef6e97fb8868da69",
"assets/assets/images/success.gif": "995b7af92f4a54b1030935f88e22a01c",
"assets/assets/images/search1.png": "608174b3db783d86c2c191b13a8fb8f6",
"assets/assets/images/contestvo.png": "1be5bd0e1e7762570126781eba745025",
"assets/assets/images/Store_Logos.png": "d2eaf855a6e4051506c7b6acbf481a5a",
"assets/assets/images/StoreLogos.png": "9947c71057cfd3f12d0547af96486deb",
"assets/assets/images/profilepicture.png": "3b951850ce79f2ebb79368e5d12c6faa",
"assets/assets/images/up.png": "724d2b8e6c11e84e008b946ff1a45cf9",
"assets/assets/images/leader.png": "85dd96bed3803b88fe0db4df54981770",
"assets/assets/images/svc5s2smmswmjfgs3pgf.mov": "f1a3b1f299c6f632dbce602c6a43e7d2",
"assets/assets/images/headset.png": "cf8f02aea95ff650f9ddbfba07f514c6",
"assets/assets/images/100.png": "c4e6218d9f15ff9018c424203483837f",
"assets/assets/images/producticon.png": "998171a230cce1dd0aaeabe8cb4d15d9",
"assets/assets/images/Vector.png": "608174b3db783d86c2c191b13a8fb8f6",
"assets/assets/images/fb.png": "1dba383738537f85a3f6abee9413e799",
"assets/assets/images/add.webp": "d4cd02ed86ded3eb92b99f5921734c41",
"assets/assets/images/congratulationpopup.png": "5f2212fbcdd40beaa8e4bd8bdf8a9d80",
"assets/assets/images/Frame32.png": "198dba954ae32a21dc1b3d5d08b5b54c",
"assets/assets/images/down.png": "2725d576e53fe536ecf67a12d7b790b6",
"assets/assets/images/logout.png": "fb224c059cca676a018aabfe16814647",
"assets/assets/images/100pay.png": "0f96b5504b35239fb1399c5bee77f505",
"assets/assets/images/home.png": "492a344cb9703bea0306a954170dee1c",
"assets/assets/images/person.png": "9e4abca9181626f817ec0fa521780ccc",
"assets/assets/images/Rectangle.png": "3514f3499f21ad857c3077d787ca5ebe",
"assets/assets/images/jumialogo.png": "a2382ea7ee6d8fbe40a03e0a02a4af5f",
"assets/assets/images/trophy1.png": "98547c19b3362af8ef3ee0c22ce16bf4",
"assets/assets/images/R.gif": "60720df441b1538b0ca1231120677fcb",
"assets/assets/images/can.png": "fd2f021d66e54cb3678e8b9b4ef26f02",
"assets/assets/images/img_avatar_2.png": "7b4a67751fbc1c50270faebbf3df7722",
"assets/assets/images/contestimage.png": "3b951850ce79f2ebb79368e5d12c6faa",
"assets/assets/images/Fame2.png": "ecc35b9cc08ee0780928716c61e9eaa2",
"assets/assets/images/launchericon.jpeg": "19be8ffddde28073d1fb54dab7514946",
"assets/assets/images/image_processing20201226-32597-12beljt-ezgif.com-gif-maker.gif": "f799380b7b940aaac9b27341eefb4fbf",
"assets/assets/images/cam.png": "31799d2b2a776167357284e4cf706bb6",
"assets/assets/images/img_avatar_1.png": "7ee8481d03e2a6b88497bc218e3dd9d2",
"assets/assets/images/Search.png": "8fa3d78ee6ef52378b31362a9962daef",
"assets/assets/images/image_not_found%25202.png": "a88029aaad6e6ea7596096c7c451840b",
"assets/assets/images/lady.png": "c1aa084578efac624eb7af984590b846",
"assets/assets/images/heart.png": "10a94ef42957f63852a60425978d098c",
"assets/assets/images/dashborad.png": "57a7bbc414ee610b378a7c425c0498e5",
"assets/assets/images/su2.gif": "24447b82f7a577147446e98f684b0f0b",
"assets/assets/images/Swap.png": "826de5f45e07189d06452c2b97466630",
"assets/assets/images/img_avatar_16x16.png": "6288c1cc4a5ddefc6103769ecb403741",
"assets/assets/images/minus.png": "3215054fc5b29abd19ab1a086f82df0c",
"assets/assets/images/image_processing20201226-32597-12beljt.gif": "f799380b7b940aaac9b27341eefb4fbf",
"assets/assets/images/apple.png": "4a0217c3716938050bbb89ac82126e7f",
"assets/assets/images/Avatar.png": "8ed9f3dc435cf23186705e9b03f87534",
"assets/assets/images/password.png": "d161dad8feee6abbbf0a9f7da97eab81",
"assets/assets/images/img_image_130.png": "f23aecc7ea75ca153733d3c3418f62fe",
"assets/assets/images/naira.png": "f912d44c05a1ca4d34640a8c44e56ded",
"assets/assets/images/sampleicon.png": "c158369971344cbc798c88ecb1bf757d",
"assets/assets/images/img_image_131.png": "4d039763eabc2c4a43becb710962145a",
"assets/assets/images/cup.png": "c2d0d8d3221106a62b10570cdcb64107",
"assets/assets/images/img_frame_1171275325_123x147.png": "695e73c2725da488f8977d9092d88391",
"assets/assets/images/logo.png": "6a0be4b0a30c098fec21ca977ed14ecb",
"assets/assets/images/img_close.svg": "bc413bff57de5652b7dd226b39b26f23",
"assets/assets/images/img_search.svg": "b9bafdb90b9264eea7feb97d7980b747",
"assets/assets/images/basil_edit-solid.png": "00753fd75a0ea9cc92c8cbddaa4cc451",
"assets/assets/images/InfoSquare.png": "c8f189d5ed7f5a5a5b5bfdb1b1a24c6b",
"assets/assets/images/profileIcom.png": "14a67f28b1ddd46cf695cf101e18efc5",
"assets/assets/images/Frame3.png": "198dba954ae32a21dc1b3d5d08b5b54c",
"assets/assets/images/contestlogo.png": "0c31d719efe7b3ddf6229fccf694573c",
"assets/assets/images/notify.png": "fa8305f24532828ee4ca6688c56cbab6",
"assets/assets/images/twitter.png": "96fc16c09e586ffe0fa064fa3dcd594a",
"assets/assets/images/img_search_gray_800.svg": "22d02ced078f514ae8980e83c9117b99",
"assets/assets/images/pay.png": "ffb1f29560d15c67a43648bc15227b64",
"assets/assets/images/comment.png": "0d36ca8d212035ab1fdcfcd00bf87c45",
"assets/assets/images/discord.png": "dfc3fa35b7cbf3d77e75256bc1193162",
"assets/assets/images/successIcon.png": "47dfcb02e5d49013e08e679508508902",
"assets/assets/images/stack.png": "09efe6358af699fbb0b1d3ba901498d4",
"assets/assets/images/devicon_twitter.png": "598ce3605f24796ecbe2f4ae9fb932ca",
"assets/assets/images/share.png": "c15605b831853011adc8089c97f96239",
"assets/assets/images/Profile.png": "525b70e3648f5910931794d44c6eda2b",
"assets/assets/images/Iconly.png": "b8b52e0b4c3b6bc8c4b9ae21b5d21f29",
"assets/assets/images/Frame1.png": "e978a9db52fb5deb35c63dca36484257",
"assets/assets/images/Avatarg.png": "93bf4d1c2f91808b342453869b86262b",
"assets/assets/images/comingsoon.png": "8b192ab9d20094484aae16b46605b218",
"assets/assets/images/voucher.png": "2256367e334e3403cd18e7fa771b85e6",
"assets/assets/images/productimga.png": "85b20db4dd30d874f510648652d473b3",
"assets/assets/images/Littlecup.png": "c36faed6de3a997928b82ccd29a1122f",
"assets/assets/images/img_arrow_left.svg": "f0b7910d79e6d1e65d0a5ba06fc24a1b",
"assets/assets/images/sharing.png": "b7b61db3b1fa6c64c62dd731a6270921",
"assets/assets/images/Artwork.png": "4dddca917be23095bd7c7f9ab5fe25fb",
"assets/assets/images/thisman.png.png": "e8c99912933df3816165c93e45bdc9c9",
"assets/assets/images/image_not_found.png": "a88029aaad6e6ea7596096c7c451840b",
"assets/assets/images/market.png": "a59464ad1eedb00662e71eb62999defd",
"assets/assets/images/Line.png": "eaf468cfe47e4d87f556e36c6997b909",
"assets/assets/images/roundimage.png": "25c069a039c443c76867bb75c5776ee6",
"assets/assets/images/closc.png": "1a6f3eb5bc2bd832f01d262842d2545e",
"assets/assets/images/WhatsApp.png": "613816c44cebdf0ea8b7a97d1ab05f9a",
"assets/assets/images/google.png": "11ea99e6ba46983f3b4727609cc475a1",
"assets/assets/images/su.gif": "60720df441b1538b0ca1231120677fcb",
"assets/assets/images/facebook.png": "1245fa7a5d775677ae01e94db2cc56be",
"assets/assets/images/shortline.png": "6c8d3d4025f608ff35a125cdc248a084",
"assets/assets/images/notification.png": "08a9b6cb79b7380baf2cb032a986a332",
"assets/assets/images/img_rectangle_124.png": "6fe95b839b2fe65e6eab5ff145a18103",
"assets/assets/images/contest.png": "c77825092ac03e6c360bedf028f4e17c",
"assets/assets/images/jiji.png": "7f492bcf2b766bf0aa00ab2af8a1c564",
"assets/assets/images/profile1.png": "99daad153da644f6ee8feb44d2d56ea6",
"assets/assets/images/check-circle.png": "ceffc0e918c9426f7cf68d5acc24a7cc",
"assets/assets/images/Vector1.png": "f74b23776b9173722df0da8c58c44a8e",
"assets/assets/images/Featured%2520icon.png": "018b77242847f98df904971e8fbc9691",
"assets/assets/images/pro.png": "0e4f05a135c730c1ede59e350a6b0fa6",
"assets/assets/images/padlock.png": "31aa297cfbb3fafd88c3133db558fb78",
"assets/assets/images/bg.png": "31a29c15ce2d7b280459bfd6c541740b",
"assets/assets/images/Rating%2520Like%25201.png": "09268eb85dd2df8037881bf153b29e1d",
"assets/assets/images/close.png": "ac5edd5549f201e887ff9f73b4e7edb4",
"assets/assets/images/frameimage.png": "0688bf5e7049f42096577d7f3f54a295",
"assets/assets/images/checkmark.gif": "a5eb16fb1ea82f72252609f70908f468",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
".idea/runConfigurations/main_dart.xml": "2b82ac5d547e7256de51268edfd10dc3",
".idea/libraries/Dart_SDK.xml": "a91d4e12717832ee365485aff1ea0d1b",
".idea/libraries/KotlinJavaRuntime.xml": "4b0df607078b06360237b0a81046129d",
".idea/workspace.xml": "cc5f609be0f96835c87839f62217d14b",
".idea/modules.xml": "6e562bd2e74aaa79b0f10c5b25fab769"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
