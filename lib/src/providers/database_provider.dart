import 'package:flutter/cupertino.dart';

// import 'package:goclean/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Storage : A class to store users data e.g token, username etc
class DatabaseProvider extends ChangeNotifier {
  ///Users data will be stored using shared preference for efficiency
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  // final Future<SharedPreferences> _userProfile =
  //     SharedPreferences.getInstance();

  ///Setters
  String? _setToken = '';
  String? _setEmail = '';
  double? _setBalance = 0;
  int? _setNotificationCount = 0;
  String? _setLastName = '';
  String? _setName = '';
  String? _setUserName = '';
  String? _setId = "";
  String? _setFirstName = '';
  String? _setCountry = '';
  String? _setState = '';
  String? _setCity = '';
  String? _setGender = '';
  String? _setProfileImage = '';
  String? _setOtp = '';
  String? _setTap = '';

  bool? _phoneVerificationStatus = false;

  //banks

  ///For chat
  String _setChatId = '';
  String get chatId => _setChatId;

  ///Business profile check
  bool? _isBusinessVerified = true;
  bool get isBusinessVerified => _isBusinessVerified!;

  ///Getters
  String get token => _setToken!;
  String get tap => _setTap!;
  String get email => _setEmail!;
  double get balance => _setBalance!;
  int get notificationCount => _setNotificationCount!;
  String get lastName => _setLastName!;
  String get UserName => _setUserName!;
  String get firstName => _setFirstName!;
  String get name => _setName!;
  String get country => _setCountry!;
  String get state => _setState!;
  String get city => _setCity!;
  String get gender => _setGender!;
  String get profileImage => _setProfileImage!;
  String get id => _setId!;
  String get otp => _setOtp!;

  //
  bool get phoneVerificationStatus => _phoneVerificationStatus!;

  ///Save User Token
  void saveToken({String? token}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("token", token!);
  }

  ///Save User Token
  void saveOtp({String? otp}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("otp", otp!);
  }

  ///Save banks
  void saveBanks({String? banks}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("banks", banks!);
  }

  ///Save User email
  void saveEmail({required String email}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("email", email);
  }

  ///Save User email
  void saveBalance({required double balance}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setDouble("balance", balance);
  }

  ///save notification count
  void saveNotificationCount({required int count}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setInt("count", count);
  }

  ///Last name
  void saveLastName({String? name}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("lName", name!);
  }

  void saveTaps({String? tap}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("tapCount", tap!);
  }

  ///Save phone
  void saveUserName({required String userName}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("UserName", userName);
  }

  void saveProfileImage({required String image}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("image", image);
  }

  ///Save User Id
  void saveUserId({required String id}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("id", id);
  }

  void saveState({String? state}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("state", state!);
  }

  void saveCountry({String? country}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("country", country!);
  }

  void saveCity({String? city}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("city", city!);
  }

  void saveGender({String? gender}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("gender", gender!);
  }

  ///Save first name
  void saveFirstName({String? name}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("fName", name!);
  }

  void savePhoneVerificationStatus({bool? value}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setBool("phone_verified", value!);
  }

  ///Save chat id
  ///Save User Token
  void saveChatId({String? id}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setString("chatId", id!);
  }

  ///Get chat id
  Future<String> getChatId() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("chatId")) {
      String? _id = _instancePref.getString("chatId");

      _setChatId = _id!;
      notifyListeners();

      return _id;
    } else {
      _setChatId = "";

      notifyListeners();
      return "";
    }
  }

  ///Business profile check
  void saveBusinessProfileStatus({bool? status}) async {
    SharedPreferences _instancePref = await _pref;

    _instancePref.setBool("bCheck", status!);
  }

  ///Get chat id
  Future<bool> getBusinessProfileStatus() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("bCheck")) {
      bool? _status = _instancePref.getBool("bCheck");

      _isBusinessVerified = _status;
      notifyListeners();

      return _status!;
    } else {
      _isBusinessVerified = true;

      notifyListeners();
      return _isBusinessVerified!;
    }
  }

  ///DATA SAVING END

  ///DATA FETCHING/ READING STARTS

  ///Get user token
  Future<String> getToken() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("token")) {
      String? _token = _instancePref.getString("token");

      _setToken = _token;
      notifyListeners();

      return _token!;
    } else {
      _setToken = "";

      notifyListeners();
      return "";
    }
  }

  ///Get user otp
  Future<String> getOtp() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("otp")) {
      String? _otp = _instancePref.getString("otp");

      _setOtp = _otp;
      notifyListeners();

      return _otp!;
    } else {
      _setOtp = "";

      notifyListeners();
      return "";
    }
  }

  ///Get user email
  Future<String> getEmail() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("email")) {
      String? _email = _instancePref.getString("email");
      _setEmail = _email;
      notifyListeners();
      return _email!;
    } else {
      _setEmail = '';
      notifyListeners();
      return "";
    }
  }

  ///Get user balance
  Future<double> getBalance() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("balance")) {
      double? _balance = _instancePref.getDouble("balance");
      _setBalance = _balance;
      notifyListeners();
      return _balance!;
    } else {
      _setBalance = 0;
      notifyListeners();
      return 0;
    }
  }

  ///get notification count
  Future<int> getNotificationCount() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("count")) {
      int? _count = _instancePref.getInt("count");
      _setNotificationCount = _count;
      notifyListeners();
      return _count!;
    } else {
      _setNotificationCount = 0;
      notifyListeners();
      return 0;
    }
  }

  Future<String> getCountry() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("country")) {
      String? _value = _instancePref.getString("country");
      _setCountry = _value;
      notifyListeners();
      return _value!;
    } else {
      _setCountry = '';
      notifyListeners();
      return "";
    }
  }

  Future<String> getState() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("state")) {
      String? _value = _instancePref.getString("state");
      _setState = _value;
      notifyListeners();
      return _value!;
    } else {
      _setState = '';
      notifyListeners();
      return "";
    }
  }

  Future<String> getAddress() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("gender")) {
      String? _value = _instancePref.getString("gender");
      _setGender = _value;
      notifyListeners();
      return _value!;
    } else {
      _setGender = '';
      notifyListeners();
      return "";
    }
  }

  Future<String> getCity() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("city")) {
      String? _value = _instancePref.getString("city");
      _setCity = _value;
      notifyListeners();
      return _value!;
    } else {
      _setCity = '';
      notifyListeners();
      return "";
    }
  }

  ///GET LAST NAME
  Future<String> getLastName() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("lName")) {
      String? _name = _instancePref.getString("lName");

      _setLastName = _name;
      notifyListeners();
      return _name!;
    } else {
      _setLastName = '';
      notifyListeners();
      return "";
    }
  }

  ///GET PHONE NUMBER
  Future<String> getPhone() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("UserName")) {
      String? _UserName = _instancePref.getString("UserName");

      _setUserName = _UserName;
      notifyListeners();

      return _UserName!;
    } else {
      _setUserName = "";
      notifyListeners();
      return "";
    }
  }

  ///GET USER Id
  Future<String> getUserId() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("_id")) {
      String? _id = _instancePref.getString("_id");

      _setId = _id;
      notifyListeners();
      return _id!;
    } else {
      _setId = "";
      notifyListeners();
      return "";
    }
  }

  ///GET FIRST NAME
  Future<String> getFirstName() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("fName")) {
      String? _name = _instancePref.getString("fName");

      _setFirstName = _name;
      notifyListeners();
      return _name!;
    } else {
      _setFirstName = '';
      notifyListeners();
      return "";
    }
  }

  ///Profile status
  Future<bool> getPhoneStatus() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("phone_verified")) {
      bool? _value = _instancePref.getBool("phone_verified");

      _phoneVerificationStatus = _value;
      notifyListeners();

      return _value!;
    } else {
      _phoneVerificationStatus = false;
      notifyListeners();
      return false;
    }
  }

  Future<String> getProfileImage() async {
    SharedPreferences _instancePref = await _pref;

    if (_instancePref.containsKey("image")) {
      String? _image = _instancePref.getString("image");

      _setProfileImage = _image;
      notifyListeners();
      return _image!;
    } else {
      _setProfileImage = "";
      notifyListeners();
      return "";
    }
  }

  ///Log Out user
  // Future<void> logOut() async {
  //   //CLEAR ALL SHARED PREFERENCE DATA
  //   final logOut = await _pref;
  //   // final profileData = await _userProfile;
  //   logOut.clear();
  //   await FirebaseAuth.instance.signOut();
  //   await GoogleSignIn(
  //       scopes: <String>["email"],
  //       clientId: DefaultFirebaseOptions.currentPlatform.iosClientId)
  //       .signOut();
  //   // await FacebookAuth.instance.logOut();
  //
  //   // profileData.clear();
  //   // PageNavigator(ctx: context).pushPageAndRemove(Login());
  // } //Sign out done
}
