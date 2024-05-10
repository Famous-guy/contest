import 'package:contest_app/src/models/new.contest.model.dart';
import 'package:contest_app/src/src.dart';
import 'package:http/http.dart' as http;

class HomeProvider with ChangeNotifier {
  late final BuildContext context;

  DatabaseProvider databaseProvider = DatabaseProvider();

  bool _isLoading = false;
  dynamic _data;
  dynamic _past;
  double _total = 0;
  String _currency = '';
  double get total => _total;
  String get currency => _currency;
  dynamic _support;
  bool _hasData = false;
  bool _empty = false;
  bool get isLoading => _isLoading;
  List<Contests> contests = [];
  dynamic get data => _data;
  dynamic get past => _past;
  dynamic get support => _support;
  bool get hasData => _hasData;
  bool get empty => _empty;
  List<Contest1> _searchResults = [];
  bool _iSLoading = false;
  List<NewContestModel> _contestData = [];
  List<NewContestModel> get contestData => _contestData;
  List<NewContestModel> _contestDat = [];
  List<NewContestModel> get contestDat => _contestDat;

  List<Contest1> get searchResults => _searchResults;
  bool get iLoading => _iSLoading;
  String _responseText = '';
  String get responseText => _responseText;

  //  https://contest-api.100pay.co/api/v1/contest/liked-contest

  Future getLike() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");

    // String fileName = "pathString.json";
    // var dir = await getTemporaryDirectory();

    // File file = File("${dir.path}/$fileName");

    // if (file.existsSync()) {
    //   debugPrint("reading from device memory");

    //   final data = file.readAsStringSync();
    //   var res = json.decode(data);
    //   print(res);

    //   _data = res;
    //   notifyListeners();
    //   return res;
    // } else {

    final response = await http.get(
      Uri.parse('https://contest-api.100pay.co/api/v1/contest/liked-contest'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(response.body);
      print(response.statusCode);
      log(response.body);
      _data = data;
      List<dynamic> dat = data;
      final List<NewContestModel> leaderboard =
          dat.map((json) => NewContestModel.fromJson(json)).toList();
      _contestDat = leaderboard;

      print('this the outcome $_contestData');
      notifyListeners();
      // file.writeAsStringSync(response.body,
      // flush: true, mode: FileMode.write);
      return data;
    } else {
      throw Exception('Failed to load contests: ${response.statusCode}');
      // }
    }
  }

  Future fetchContests() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");

    // String fileName = "pathString.json";
    // var dir = await getTemporaryDirectory();

    // File file = File("${dir.path}/$fileName");

    // if (file.existsSync()) {
    //   debugPrint("reading from device memory");

    //   final data = file.readAsStringSync();
    //   var res = json.decode(data);
    //   print(res);

    //   _data = res;
    //   notifyListeners();
    //   return res;
    // } else {

    final response = await http.get(
      Uri.parse(
          'https://contest-api.100pay.co/api/v1/contest/upcoming-contests'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(response.body);
      print(response.statusCode);
      log(response.body);
      _data = data;
      List<dynamic> dat = data;
      final List<NewContestModel> leaderboard =
          dat.map((json) => NewContestModel.fromJson(json)).toList();
      _contestData = leaderboard;

      print('this the outcome $_contestData');
      notifyListeners();
      // file.writeAsStringSync(response.body,
      // flush: true, mode: FileMode.write);
      return data;
    } else {
      throw Exception('Failed to load contests: ${response.statusCode}');
      // }
    }
  }

  Future fetchSupportedContests() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    _isLoading = true;
    // String fileName = "pathString.json";
    // var dir = await getTemporaryDirectory();

    // File file = File("${dir.path}/$fileName");

    // if (file.existsSync()) {
    //   debugPrint("reading from device memory");

    //   final data = file.readAsStringSync();
    //   var res = json.decode(data);
    //   print(res);

    //   _data = res;
    //   notifyListeners();
    //   return res;
    // } else {

    try {
      final response = await http.get(
        Uri.parse(
            'https://contest-api.100pay.co/api/v1/contest/upcoming-supported-contests'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      print(response.body);
      print(response.statusCode);
      var request = json.decode(response.body.trim());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        _isLoading = false;
        log(response.body);
        _support = data;
        notifyListeners();
        // file.writeAsStringSync(response.body,
        // flush: true, mode: FileMode.write);
        return data;
      } else {
        _isLoading = false;
        _responseText = request["error"];
        throw Exception('Failed to load contests: ${response.statusCode}');
      }
    } catch (e) {
      // _empty = true;
      _hasData = false;
      _isLoading = false;
      notifyListeners();

      print('Error fetching contests: $e');
      errorSnackBar(context, "+ $e");
    }

    // }
  }

  Future joinContest(
      {String? contestId, String? tapCount, BuildContext? context}) async {
    _isLoading = true;

    String url =
        "https://contest-api.100pay.co/api/v1/contest/join-contest/$contestId";

    Map<String, dynamic> body = {
      "tapCount": tapCount,
    };

    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");

    try {
      var request = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );
      var response = json.decode(request.body.trim());
      print(request.body);
      log(request.body);

      if (request.statusCode == 200) {
        _isLoading = false;
        _responseText = response['msg'];
        notifyListeners();
      } else {
        _responseText = response["error"];
        _isLoading = false;
        notifyListeners();
        error(context!, message: response["error"]);
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      errorSnackBar(context!, "+ $e");
      log("Error + ${e.toString()}");
    }
  }

  Future preview(
      {String? contestId, String? tapCount, BuildContext? context}) async {
    _isLoading = true;

    String url =
        "https://contest-api.100pay.co/api/v1/payment/preview-purchase/$contestId";

    Map<String, dynamic> body = {
      "tapCount": tapCount,
    };

    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");

    try {
      var request = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
      );
      var response = json.decode(request.body.trim());
      print(request.body);
      log(request.body);

      if (request.statusCode == 200) {
        _isLoading = false;
        _total = response['total'];
        _currency = response['product'];
        _responseText = response['msg'];
        notifyListeners();
      } else {
        _responseText = response["error"];
        _isLoading = false;
        notifyListeners();
        error(context!, message: response["error"]);
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      errorSnackBar(context!, "+ $e");
      log("Error + ${e.toString()}");
    }
  }

// variables for like

  // set variables

  dynamic _pastContests;
  dynamic get pastContests => _pastContests;

  Future getPastContests() async {
    _isLoading = true;
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    try {
      final response = await http.get(
        Uri.parse('https://contest-api.100pay.co/api/v1/contest/past-contests'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      var request = json.decode(response.body.trim());
      print(response.body);
      print(response.statusCode);
      var resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _hasData = true;
        _isLoading = false;
        // var data = jsonDecode(response.body);

        // log(response.body);
        // _past = data;
        final dynamic responseBody = jsonDecode(response.body);
        _pastContests = responseBody;
        notifyListeners();
      } else {
        _empty = true;
        _hasData = false;
        _isLoading = false;
        notifyListeners();
        _responseText = request["error"];
        print(response.body);
        print(response.statusCode);

        throw Exception('Failed to load contests: ${response.statusCode}');
      }
      return resData;
    } catch (e) {
      _empty = true;
      _hasData = false;
      _isLoading = false;
      notifyListeners();

      print('Error fetching contests: $e');
      errorSnackBar(context, "+ $e");
    }
  }
}
