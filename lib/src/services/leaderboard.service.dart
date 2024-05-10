import 'package:contest_app/src/src.dart';

class LeaderBoardService {
  static Future<List<LeaderboardEntry>> getLeadershipBoard() async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.get,
      token: "${await TokenUtil.retrieveToken()}",
      url: 'https://contest-api.100pay.co/api/v1/contest/leadersboard',
    );
    log('leadership ${response!.body}');

    return await NetworkHelper.filterResponse(
        callBack: (json) {
          print('json $json');
          List<dynamic> data = json;
          final List<LeaderboardEntry> leaderboard =
              data.map((json) => LeaderboardEntry.fromJson(json)).toList();
          print('lead $leaderboard');
          return leaderboard;
        },
        response: response,
        parameterName: CallBackParameterName.all,
        onFailureCallBackWithMessage: (errorType, msg) {
          log(msg!);
          throw msg.toString();
        });
  }

  static Future<List<LeaderboardEntry>> getLeadershipBoardweekly() async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.get,
      token: "${await TokenUtil.retrieveToken()}",
      url: 'https://contest-api.100pay.co/api/v1/contest/weekly-leadersboard',
    );
    log('leadership ${response!.body}');

    return await NetworkHelper.filterResponse(
        callBack: (json) {
          print('json $json');
          List<dynamic> data = json;
          final List<LeaderboardEntry> leaderboard =
              data.map((json) => LeaderboardEntry.fromJson(json)).toList();
          print('lead $leaderboard');
          return leaderboard;
        },
        response: response,
        parameterName: CallBackParameterName.all,
        onFailureCallBackWithMessage: (errorType, msg) {
          log(msg!);
          throw msg.toString();
        });
  }

  static Future<List<LeaderboardEntry>> getLeadershipBoardtoday() async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.get,
      token: "${await TokenUtil.retrieveToken()}",
      url: 'https://contest-api.100pay.co/api/v1/contest/daily-leadersboard',
    );
    log('leadership ${response!.body}');

    return await NetworkHelper.filterResponse(
        callBack: (json) {
          print('json $json');
          List<dynamic> data = json;
          final List<LeaderboardEntry> leaderboard =
              data.map((json) => LeaderboardEntry.fromJson(json)).toList();
          print('lead $leaderboard');
          return leaderboard;
        },
        response: response,
        parameterName: CallBackParameterName.all,
        onFailureCallBackWithMessage: (errorType, msg) {
          log(msg!);
          throw msg.toString();
        });
  }
}
