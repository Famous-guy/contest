import 'package:contest_app/src/src.dart';
import 'package:http/http.dart' as http;

class WalletProvider with ChangeNotifier {
  UrlConstants urlConstants = UrlConstants();
  SharedPreferences? sf;
  bool _isLoading = false;
  bool _hasData = false;
  bool _hasError = false;
  String _response = '';
  String get res => _response;
  bool get hasData => _hasData;
  bool get hasError => _hasError;
  // setters
  bool get isloading => _isLoading;

  // fund wallet function

  Future<String> fundWallet({String? amount, BuildContext? context}) async {
    _isLoading = true;
    sf = await SharedPreferences.getInstance();
    var url = urlConstants.baseUrl + urlConstants.fundWallet;
    String? token = sf!.getString("token");
    http.Response request = await http.post(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "billing": {
          "amount": amount,
          // "vat": "10"
        }
      }),
    );
    var response = json.decode(request.body);
    _isLoading = false;
    notifyListeners();
    if (request.statusCode == 200 || request.statusCode == 201) {
      _isLoading = false;
      _hasData = true;
      _response = response;
      nextPage(context!,
          page: WebViewScreen(url: response, title: "Checkout payment"));
    } else {
      _hasData = false;
      _hasError = true;
      _isLoading = false;
    }
    return response;
  }
}
