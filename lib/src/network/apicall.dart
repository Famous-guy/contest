// ignore_for_file: use_build_context_synchronously







import 'package:contest_app/src/src.dart';

import 'package:http/http.dart' as http;
String? userData;

class ApiCall {
  static Future<void> signUp(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController fullNameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    Function(bool) setLoading,
  ) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);
      try {
        var url = Uri.parse('https://ecommerce-qfab.onrender.com/api/v1/user');
        var body = {
          "fullName": fullNameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        };
        var headers = {
          'Content-Type': 'application/json',
        };
        var response = await http.post(
          url,
          body: jsonEncode(body),
          headers: headers,
        );

        if (kDebugMode) {
          print('Response: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response Body: ${response.body}');
        }

        if (response.statusCode == 201 || response.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PersonalizedFeedsScreen(),
            ),
          );
        } else if (response.statusCode == 400 ||
            response.statusCode == 503 ||
            response.statusCode == 204 ||
            response.statusCode == 201 ||
            response.statusCode == 401 ||
            response.statusCode == 403 ||
            response.statusCode == 404 ||
            response.statusCode == 500) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              elevation: 10,
              backgroundColor: Colors.white,
              title: const Text('Sign Up Failed'),
              content: Text(jsonDecode(response.body)["error"].toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              elevation: 10,
              backgroundColor: Colors.white,
              title: const Text('Sign Up Failed'),
              content: Text(jsonDecode(response.body)["error"].toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error: $e');
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 10,
            backgroundColor: Colors.white,
            title: const Text(
              'Error',
            ),
            content: const Text(
                'An error occurred. Please make sure your connected to the internet.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } finally {
        setLoading(
            false); // Set loading state to false regardless of success or failure
      }
    }
  }

  static Future<void> signin(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController,
    Function(bool) setLoading,
  ) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);
      try {
        var url =
            Uri.parse('https://ecommerce-qfab.onrender.com/api/v1/user/login/');
        var body = {
          "email": emailController.text,
          "password": passwordController.text,
        };
        var headers = {
          'Content-Type': 'application/json',
        };
        var response = await http.post(
          url,
          body: jsonEncode(body),
          headers: headers,
        );

        if (kDebugMode) {
          print('Response: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response Body: ${response.body}');
        }

        if (response.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainActivityPage(),
            ),
          );
          userData = jsonDecode(response.body)["_id"];
          print(userData);
        } else if (response.statusCode == 400 ||
            response.statusCode == 503 ||
            response.statusCode == 204 ||
            response.statusCode == 401 ||
            response.statusCode == 403 ||
            response.statusCode == 404 ||
            response.statusCode == 500) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              elevation: 10,
              backgroundColor: Colors.white,
              title: const Text('Sign in Failed'),
              content: Text(jsonDecode(response.body)["error"].toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              elevation: 10,
              backgroundColor: Colors.white,
              title: const Text('Sign in Failed'),
              content: Text(jsonDecode(response.body)["error"].toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error: $e');
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } finally {
        setLoading(
            false); // Set loading state to false regardless of success or failure
      }
    }
  }

  static Future<void> getOTP(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    Function(bool) setLoading,
    Function() navigation,
  ) async {
    if (formKey.currentState!.validate()) {
      setLoading(true);
      try {
        var url = Uri.parse(
            'https://ecommerce-qfab.onrender.com/api/v1/verify/send-otp/');
        var body = {
          "email": emailController.text,
        };
        var headers = {
          'Content-Type': 'application/json',
        };
        var response = await http.post(
          url,
          body: jsonEncode(body),
          headers: headers,
        );

        if (kDebugMode) {
          print('Response: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response Body: ${response.body}');
        }

        if (response.statusCode == 201 || response.statusCode == 200) {
          navigation();
        } else if (response.statusCode == 400 ||
            response.statusCode == 503 ||
            response.statusCode == 204 ||
            response.statusCode == 401 ||
            response.statusCode == 403 ||
            response.statusCode == 404 ||
            response.statusCode == 500) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              elevation: 10,
              backgroundColor: Colors.white,
              content: Text(jsonDecode(response.body)["error"].toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              elevation: 10,
              backgroundColor: Colors.white,
              title: const Text('request error'),
              content: Text(jsonDecode(response.body)["error"].toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error: $e');
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } finally {
        setLoading(
            false); // Set loading state to false regardless of success or failure
      }
    }
  }

  static Future<void> resendOTP(
    BuildContext context,
    Function(bool) setLoading,
    var email,
    // Function() navigation,
  ) async {
    setLoading(true);
    try {
      // var email;
      var url = Uri.parse(
          'https://ecommerce-qfab.onrender.com/api/v1/verify/send-otp/');
      var body = {
        "email": email,
      };
      var headers = {
        'Content-Type': 'application/json',
      };
      var response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );

      if (kDebugMode) {
        print('Response: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Response Body: ${response.body}');
      }

      if (response.statusCode == 201 || response.statusCode == 200) {
        const snackBar = SnackBar(
          backgroundColor: Colors.white,
          padding: EdgeInsets.only(bottom: 20, top: 20),
          content: Center(
            child: Text(
              'OTP sent successfully',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (response.statusCode == 400 ||
          response.statusCode == 503 ||
          response.statusCode == 204 ||
          response.statusCode == 401 ||
          response.statusCode == 403 ||
          response.statusCode == 404 ||
          response.statusCode == 500) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 10,
            backgroundColor: Colors.white,
            content: Text(jsonDecode(response.body)["error"].toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 10,
            backgroundColor: Colors.white,
            title: const Text('request error'),
            content: Text(jsonDecode(response.body)["error"].toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setLoading(
          false); // Set loading state to false regardless of success or failure
    }
  }

  static Future<void> changePassword(
    BuildContext context,
    Function(bool) setLoading,
    String passwordController,
    String email,
    String otp,
    Function() navigation,
  ) async {
    setLoading(true);
    try {
      var url = Uri.parse(
          'https://ecommerce-qfab.onrender.com/api/v1/verify/forgot-password');
      var body = {
        "email": email,
        "newPassword": passwordController,
        "otp": otp
      };
      var headers = {
        'Content-Type': 'application/json',
      };
      var response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print(response.body);
        navigation();
      } else if (response.statusCode == 400 ||
          response.statusCode == 503 ||
          response.statusCode == 204 ||
          response.statusCode == 401 ||
          response.statusCode == 403 ||
          response.statusCode == 404 ||
          response.statusCode == 500) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 10,
            backgroundColor: Colors.white,
            content: Text(jsonDecode(response.body)["error"].toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 10,
            backgroundColor: Colors.white,
            title: const Text('Request Error'),
            content: Text(jsonDecode(response.body)["error"].toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setLoading(false);
    }
  }

  final dio = Dio();

  Future<void> request() async {
    final url =
        'https://ecommerce-qfab.onrender.com/api/v1/contest/get-vouchers';
    // userData = '65d4f296544cc5042f5e7c76'; // Replace with an actual user ID

    try {
      final response = await dio.request(
        url,
        options: Options(
          method: 'GET',
          headers: {
            'Authorization': 'Bearer YOUR_API_KEY'
          }, // Replace with your API key
        ),
        data: {'userId': userData},
      );

      print(response.data);
    } catch (e) {
      print('Error: $e');
    }
  }
}

var request = ApiCall().request();
