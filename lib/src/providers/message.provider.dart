// import 'package:contest_app/screens/user_varients/message.dart';
// import 'package:flutter/foundation.dart';
// // import 'package:flutter_socket_io/model/message.dart';

// class MessageProvider extends ChangeNotifier {
//   final List<Message> _messages = [];
//   final List<Message> _username = [];

//   List<Message> get messages => _messages;
//   List<Message> get username => _username;

//   addNewMessage(Message message, Message username) {
//     _messages.add(message);
//     _username.add(username);
//     notifyListeners();
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:contest_app/src/models/message.dart';

// class MessageProvider extends ChangeNotifier {
//   final List<User> _messages = [];

//   List<User> get messages => _messages;

//   void addNewMessage(User message) {
//     _messages.add(message);
//     notifyListeners();
//   }
// }

class MessageProvider extends ChangeNotifier {
  final List<User> _messages = [];

  List<User> get messages => _messages;
  final List<User> _message = [];

  List<User> get message => _message;

  void addNewMessage(User message) {
    _messages.add(message);
    notifyListeners();
  }
}
