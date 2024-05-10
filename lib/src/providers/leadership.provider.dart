import 'dart:convert';
import 'package:contest_app/src/models/leadership.modals.dart';
import 'package:contest_app/src/src.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LeaderboardProvider extends ChangeNotifier {
  List<LeaderboardEntry> _leaderboard = [];

  List<LeaderboardEntry> get leaderboard => _leaderboard;
  List<LeaderboardEntry> _weekly = [];

  List<LeaderboardEntry> get weekly => _weekly;
  List<LeaderboardEntry> _today = [];

  List<LeaderboardEntry> get today => _today;

  Future<List<LeaderboardEntry>> fetchLeaderboard() async {
    try {
      print('lead');
      var respone = LeaderBoardService.getLeadershipBoard();
      print('hello  ${respone}');
      respone.then((value) {
        _leaderboard = value;
        print('leading $value');
        notifyListeners();
      }).onError((error, stackTrace) {
        _leaderboard = List.empty();
        print('this: $error $stackTrace');
        notifyListeners();
      });
      return respone;
    } catch (error) {
      _leaderboard = List.empty();
      notifyListeners();
      print('Error fetching leaderboard: $error');

      return leaderboard;
    }
  }

  Future<List<LeaderboardEntry>> fetchLeaderboardweekly() async {
    try {
      print('lead');
      var respone = LeaderBoardService.getLeadershipBoardweekly();
      print('hello  ${respone}');
      respone.then((value) {
        _weekly = value;
        print('leading $value');
        notifyListeners();
      }).onError((error, stackTrace) {
        _weekly = List.empty();
        print('this: $error $stackTrace');
        notifyListeners();
      });
      return respone;
    } catch (error) {
      _weekly = List.empty();
      notifyListeners();
      print('Error fetching leaderboard: $error');

      return weekly;
    }
  }

  Future<List<LeaderboardEntry>> fetchLeaderboardtoday() async {
    try {
      print('lead');
      var respone = LeaderBoardService.getLeadershipBoardtoday();
      print('hello  ${respone}');
      respone.then((value) {
        _today = value;
        print('leading $value');
        notifyListeners();
      }).onError((error, stackTrace) {
        _today = List.empty();
        print('this: $error $stackTrace');
        notifyListeners();
      });
      return respone;
    } catch (error) {
      _today = List.empty();
      notifyListeners();
      print('Error fetching leaderboard: $error');

      return today;
    }
  }
}
