import 'package:contest_app/src/src.dart';
import 'package:http/http.dart' as http;

class AuthenticationProvider extends ChangeNotifier {
  /// Base Url
  // final requestBaseUrl = AppString.baseUrl;
  final requestBaseUrl = AppString.baseUrl;

  Function(bool)? setLoadingState;
  bool _isLoading = false;
  String _resMessage = "";

  ///Field Getters
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  ViewState state = ViewState.idle;
  var token;
  var userOtp;

  void setSetLoadingState(Function(bool) setLoading) {
    setLoadingState = setLoading;
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String fullName,
    required String username,
    required String country,
    required String gender,
    required String currency,
    BuildContext? context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Check if any required fields are null
      if (email.isEmpty ||
          password.isEmpty ||
          fullName.isEmpty ||
          username.isEmpty ||
          country.isEmpty ||
          gender.isEmpty ||
          currency.isEmpty) {
        _isLoading = false;
        errorSnackBar(context!, "Please provide all required information");
        return;
      }

      // Authentication URL
      String _url = AppString.signUpUrl;

      // Construct the request body
      final body = {
        "email": email,
        "fullName": fullName,
        "password": password,
        "username": username,
        "country": country,
        "gender": gender != null ? gender : "Male",
        "balance": {"currency": currency}
      };
      appLog(body);
      // Make the POST request
      final http.Response res = await http.post(
        Uri.parse(_url),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );
      print(res.statusCode);
      if (res.statusCode == 200 || res.statusCode == 201) {
        // DatabaseProvider().saveEmail(email: email);
        _isLoading = false;
        final message = json.decode(res.body)["message"];
        _resMessage = message ?? "Signup successful";
        // DatabaseProvider().saveGender(gender: gender);
        successSnackBar(context!, _resMessage);
        appLog("creating account message $_resMessage");
        _isLoading = false;
        notifyListeners();
        // nextPage(context!, page: const WelcomeBack());
      } else {
        print('${res.body}');
        // Email already exists
        errorSnackBar(context!, jsonDecode(res.body)['error']);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      // Socket exception
      _isLoading = false;
      _resMessage = "Please connect to an active internet";
      errorSnackBar(context!, _resMessage); // Show error message
      notifyListeners();
    } catch (e) {
      // Other exceptions
      _isLoading = false;
      _resMessage = "Please try again";
      errorSnackBar(context!, _resMessage); // Show error message
      notifyListeners();
      print("Error: $e");
    }
  }

  Future<void> login({
    String? email,
    String? password,
    BuildContext? context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      String _url = AppString.loginUrl;
      final body = {
        "email": email,
        "password": password,
      };
      appLog(body);

      // Make the POST request
      var res = await http.post(
        Uri.parse(_url),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );
      // var dataRes = jsonDecode(res.body);

      log(res.body.toString());

      if (res.statusCode == 200) {
        // await Provider.of<HomeProvider>(context!, listen: false)
        //     .fetchContests();
        if (res.body.isNotEmpty) {
          var dataRes = json.decode(res.body.trim());

          if (dataRes["token"] != null) {
            _isLoading = false;
            SharedPreferences sf = await SharedPreferences.getInstance();
            sf.setString("token", dataRes["token"]);
            DatabaseProvider().getToken();

            sf.setString("_id", dataRes["_id"]);
            DatabaseProvider().getUserId();
            TokenUtil.persistToken(
                token: dataRes["token"], refresh: dataRes["token"]);

            UserId.persistuserId(id: dataRes["_id"]);
            notifyListeners();
            await Provider.of<HomeProvider>(context!, listen: false)
                .fetchContests();
            // Navigate to the main activity page
            // nextPageOnly(context, page: MainActivityPage());

            // Save the token

            // DatabaseProvider().saveToken(token: dataRes["token"]);
            log(dataRes.toString());
            nextPageAndRemovePrevious(context, page: MainActivityPage());
          } else {
            _isLoading = false;
            notifyListeners();
          }
        }
      } else {
        print('${res.body}');
        // Email already exists
        errorSnackBar(context!, jsonDecode(res.body)['error']);
        _isLoading = false;
        notifyListeners();
      }
      // else if (res.statusCode == 401) {
      //   _isLoading = false;
      //   notifyListeners();
      //   log("401");
      // } else {
      //   _isLoading = false;
      //   notifyListeners();
      //   // Handle other status codes here
      // }
    } catch (e) {
      // Handle any errors that occur during the execution of the function
      print("Error occurred during login: $e");
      errorSnackBar(context!,
          "An error occurred: $resMessage"); // Adjust the message as needed
      _isLoading = false;
      notifyListeners();
    }
  }



  Future sendEmailOtp({
    String? email,
    BuildContext? context,
    bool isResend = false,
  }) async {
    _isLoading = true;
    notifyListeners();
    String _url = AppString.sendOtp;
    final body = {
      "email": email,
    };
    appLog(body);

    // Make the POST request
    final http.Response res = await http.post(
      Uri.parse(_url),
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );
    print(res.body);
    // var dataRes = jsonDecode(res.body);

    if (res.statusCode == 200 || res.statusCode == 201) {
      _isLoading = false;
      notifyListeners();
      if (isResend == true) {
        successSnackBar(context!, "Otp Sent Successfully");
      } else {
        DatabaseProvider().getToken();
        DatabaseProvider().saveToken(token: 'token');

        nextPage(context!,
            page: OtpScreen(
              email: email.toString(),
            ));
      }
      successSnackBar(context, "OTP sent successfully");
    } else if (res.statusCode == 400 || res.statusCode == 404) {
      _isLoading = false;
      notifyListeners();
      errorSnackBar(context!, "User does not exist");
    } else {
      _isLoading = false;
      notifyListeners();
      errorSnackBar(context!, "Something went wrong");
    }
  }

  Future verifyForgotPassword({
    String? email,
    String? otp,
    String? newPassword,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();
    String url = AppString.verifyForgotPassword;
    final body = {
      "email": email,
      "otp": otp,
      "newPassword": newPassword,
    };
    token = DatabaseProvider().getToken();
    DatabaseProvider().saveOtp(otp: otp);
    userOtp = DatabaseProvider().getOtp();

    final http.Response response = await http.patch(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    var dataRes = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      _isLoading = false;
      notifyListeners();
      successSnackBar(context!, "Verification Successful");
      nextPage(context, page: SignInScreen());
      // nextPageAndRemovePrevious(context, page: ForgottenPassword(otp: userOtp));
    }
    // else if (response.statusCode == 400) {
    //   _isLoading = false;
    //   notifyListeners();

    //   errorSnackBar(context!, 'Invalid OTP');
    //   nextPage(context, page: ForgottenPassword());
    // }
    else {
      _isLoading = false;
      Navigator.pushReplacement(
          context!,
          MaterialPageRoute(
            builder: (context) => ForgottenPasswordScreen(),
          ));
      notifyListeners();
      print(response.statusCode);
      print(response.body);
      errorSnackBar(context, jsonDecode(response.body)['error']);
    }
  }

  void clearMessage() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
