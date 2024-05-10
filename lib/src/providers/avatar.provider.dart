import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AvatarProvider extends ChangeNotifier {
  File? _avatarFile;
  bool _isLoading = false;

  File? get avatarFile => _avatarFile;
  bool get isLoading => _isLoading;

  Future<void> fetchAvatar() async {
    _isLoading = true;
    notifyListeners();
    try {
      String styleName = 'adventurer'; // Change the style name if needed
      final response = await http
          .get(Uri.parse('https://api.dicebear.com/8.x/$styleName/svg'));

      if (response.statusCode == 200) {
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        String filePath = '$tempPath/avatar.svg';
        _avatarFile = File(filePath);
        await _avatarFile!.writeAsString(response.body);
        print('Avatar fetched successfully');
      } else {
        print('Failed to load avatar: ${response.statusCode}');
        throw Exception('Failed to load avatar: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching avatar: $error');
      throw Exception('Failed to load avatar');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
