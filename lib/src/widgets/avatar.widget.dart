// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// class AvatarScreen extends StatefulWidget {
//   @override
//   _AvatarScreenState createState() => _AvatarScreenState();
// }

// class _AvatarScreenState extends State<AvatarScreen> {
//   late File? avatarFile;

//   // Function to fetch a random avatar
//   Future<void> fetchAvatar() async {
//     try {
//       String styleName = 'adventurer'; // Change the style name if needed
//       final response = await http.get(Uri.parse('https://api.dicebear.com/8.x/$styleName/svg'));

//       if (response.statusCode == 200) {
//         Directory tempDir = await getTemporaryDirectory();
//         String tempPath = tempDir.path;
//         String filePath = '$tempPath/avatar.svg';
//         avatarFile = File(filePath);
//         await avatarFile!.writeAsString(response.body);
//         print('Avatar fetched successfully');
//         setState(() {});
//       } else {
//         print('Failed to load avatar: ${response.statusCode}');
//         throw Exception('Failed to load avatar: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error fetching avatar: $error');
//       throw Exception('Failed to load avatar');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     avatarFile = null;
//     fetchAvatar();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Random Avatar'),
//       ),
//       body: Center(
//         child: avatarFile != null && avatarFile!.existsSync()
//             ? SvgPicture.file(
//           avatarFile!,
//           height: 100,
//           width: 100,
//           fit: BoxFit.cover,
//         )
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: AvatarScreen(),
//   ));
// }
