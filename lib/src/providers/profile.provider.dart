import 'package:contest_app/src/src.dart';
import 'package:http/http.dart' as http;

class ProfileProvider with ChangeNotifier {
  String? fullName;
  String? balance;
  bool _isLoading = false;
  bool _hasData = false;
  bool _hasError = false;
  bool _isEmpty = false;
  bool get isLoading => _isLoading;
  bool get hasData => _hasData;
  bool get hasError => _hasError;
  bool get isEmpty => _isEmpty;
  List<Voucher> _contests = [];

  List<Voucher> get contests => [..._contests];
  Future<List<Voucher>> getVouchers() async {
    _isLoading = true;
    var url =
        Uri.parse('https://contest-api.100pay.co/api/v1/contest/get-vouchers');
    // String url = UrlConstants().baseUrl + UrlConstants().getVouchers;

    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    // try {
    http.Response request = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    // if (request.statusCode == 200) {
    _isLoading = false;
    _hasData = true;
    print(request.body);
    var data = jsonDecode(request.body) as List;
    List<Voucher> vouchers =
        data.map((json) => Voucher.fromJson(json)).toList();
    // _contests = vouchers;
    // notifyListeners();
    return vouchers;
    // }
    // else {
    //   _isLoading = false;
    //   _hasData = false;
    //   _isEmpty = true;
    //   var error = jsonDecode(request.body)['error'];

    //   notifyListeners();
    //   throw error;
    // }
    // } catch (e) {
    //   _isLoading = false;
    //   _hasData = false;
    //   _isEmpty = true;
    //   notifyListeners();
    //   throw (error);
    // }
  }

  // set variables

  String _resMessage = '';
  String get responseMessage => _resMessage;

  Future<List> getUsersWonContests() async {
    var url =
        Uri.parse('https://contest-api.100pay.co/api/v1/contest/won-contests');
    // UrlConstants().baseUrl + UrlConstants().wonContests;

    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");

    var request = await http.get(
      url,
      // Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print(request.body);
    print(request.statusCode);
    var data = jsonDecode(request.body);
    if (request.statusCode != 200) {
      _resMessage = data['error'];
      notifyListeners();
    }
    log(data["error"]);

    return data;
  }

  Future<UserProfile> getuserProfile() async {
    String url = UrlConstants().userProfile;

    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");

    http.Response request = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    var data = jsonDecode(request.body);
    return UserProfile.fromJson(data);
  }

  final requestBaseUrl = AppString.baseUrl;

  // bool _isLoading = false;
  String _respMessage = "";

  ///Field Getters
  // bool get isLoading => _isLoading;
  String get resMessage => _respMessage;
  ViewState state = ViewState.idle;

  Future<void> updateUser({
    required String email,
    required String gender,
    required String fullName,
    required String username,
    required String image,
    BuildContext? context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Check if any required fields are null
      if (email.isEmpty || gender.isEmpty || fullName.isEmpty) {
        _isLoading = false;
        errorSnackBar(context!, "Please provide all required information");
        return;
      }

      // Authentication URL
      String _url = AppString.signUpUrl;

      // Construct the request body
      final body = {
        "fullName": fullName,
        // "username": username,
        "email": email,
        // "gender": gender,
        // "image": image,
      };
      appLog(body);
      // Make the POST request
      SharedPreferences sf = await SharedPreferences.getInstance();
      String? token = sf.getString("token");

      final http.Response res = await http.patch(
        Uri.parse(_url),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print(res.statusCode);
      if (res.statusCode == 200 || res.statusCode == 201) {
        getuserProfile();
        DatabaseProvider().saveEmail(email: email);
        DatabaseProvider().saveFirstName(name: fullName);
        DatabaseProvider().saveProfileImage(image: image);
        DatabaseProvider().saveGender(gender: gender);
        DatabaseProvider().saveUserName(userName: username);
        _isLoading = false;
        final message = json.decode(res.body)["message"];
        _respMessage = message ?? "profile update successful";
        DatabaseProvider().saveToken(token: 'token');
        successSnackBar(context!, _respMessage);
        appLog("creating account message $_respMessage");
        _isLoading = false;
        notifyListeners();
        // nextPage(context!, page: const WelcomeBack());
      } else {
        // Handle other error responses
        final data = res.body;
        appLog(data);
        final errorMessage = json.decode(data)["error"];
        _respMessage = errorMessage ?? "An error occurred. Please try again.";
        _isLoading = false;
        errorSnackBar(context!, _respMessage); // Show error message
        notifyListeners();
      }
    } on SocketException catch (_) {
      // Socket exception
      _isLoading = false;
      _respMessage = "Please connect to an active internet";
      errorSnackBar(context!, _respMessage); // Show error message

      notifyListeners();
    } catch (e) {
      // Other exceptions
      _isLoading = false;
      _respMessage = "Please try again";
      errorSnackBar(context!, _respMessage); // Show error message
      notifyListeners();
      print("Error: $e");
    }
  }

  Future getUserProfile() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");

    String fileName = "pathString.json";
    var dir = await getTemporaryDirectory();

    File file = File("${dir.path}/$fileName");

    if (file.existsSync()) {
      debugPrint("reading from device memory");

      final data = file.readAsStringSync();
      var res = json.decode(data);
      print(res.toString());
      fullName = res["fullName"].toString();
      balance = res['balance']['amount'].toString();
      notifyListeners();
      return res;
    } else {
      // fetch from network
      print("fetching from network");
      String url = UrlConstants().userProfile;
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      var data = json.decode(response.body);
      print(response.body.toString());
      if (response.statusCode == 200) {
        fullName = data["fullName"].toString();
        balance = data['balance']['amount'].toString();
        notifyListeners();
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        return data;
      } else {
        return data;
      }
    }
  }
}
