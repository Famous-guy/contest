import 'package:contest_app/src/models/search.modal.dart';
import 'package:contest_app/src/src.dart';
import 'package:flutter_launcher_icons/utils.dart';

class SearchProvider extends ChangeNotifier {
  // final Dio _dio = Dio();
  final dio = Dio();
  List<Product> _searchResults = [];
  bool _isLoading = false;
  double? tapprice;
  String? currency;
  List<Product> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  Future<void> search(String productName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    try {
      _isLoading = true;
      notifyListeners();

      final dio = Dio();

      final response = await dio.get(
        'https://contest-api.100pay.co/api/v1/contest/search-name',
        data: {"productName": productName},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      final List<dynamic> responseData = response.data;
      _searchResults =
          responseData.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      // Handle error
      print("Error: $e");
      _searchResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchCategory(String category) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    try {
      _isLoading = true;
      notifyListeners();

      final dio = Dio();

      final response = await dio.get(
        'https://contest-api.100pay.co/api/v1/contest/search-category',
        data: {"category": category},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      final List<dynamic> responseData = response.data;
      _searchResults =
          responseData.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      // Handle error
      print("Error: $e");
      _searchResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> tapPrice(String contestId) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? token = sf.getString("token");
    try {
      _isLoading = true;
      notifyListeners();

      final dio = Dio();

      final response = await dio.get(
        'https://contest-api.100pay.co/api/v1/contest/contest-tap-price',
        data: {"contestId": contestId},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      print(response.data);
      int tapdata = response
          .data['tapPrice']; // No need for jsonDecode since it's already parsed
      print(tapdata);
      currency = response
          .data['currency']; // No need for jsonDecode since it's already parsed
      print(currency);

      tapprice = double.parse('${tapdata}');
      // print('i guess u are $tapdata');
      // tapprice = jsonDecode(response.data['tapPrice']);
      // double.parse(tapprice!);
      // print('hello this is $tapprice');
      // print(response.data);
      // print(response.statusCode);
      // print(response.statusMessage);
      // printStatus('hello guy');
      // final List<dynamic> responseData = response.data;
      // _searchResults =
      //     responseData.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      // Handle error
      print("Error is: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

    // void search() async {
      //   final response = await dio.get(
      //     'https://contest-api.100pay.co/api/v1/contest/search-name',
      //     // queryParameters: {"productName": 'Fan'},
      //     data: {"productName": 'F'},
      //     options: Options(
      //       headers: {
      //         // Add your header key-value pairs here
      //         "Authorization":
      //             "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWQ0ZjI5NjU0NGNjNTA0MmY1ZTdjNzYiLCJlbWFpbCI6ImhvZ2FuaXp5ODVAZ21haWwuY29tIiwiaWF0IjoxNzExNTI5ODAxLCJleHAiOjE3MjAxNjk4MDF9.GAIiAso_UAmuSkFGxGJMI9P43MAvXkx2HXGLTR-yf9o",
      //         "Content-Type": "application/json",
      //       },
      //     ),
      //   );
      //   print(response.data);
      // }