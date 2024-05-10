import 'package:contest_app/src/src.dart';

class AuthService {
  static Future<dynamic> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.post,
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
      url: '${AppString.baseUrl}auth/login/',
    );

    return await NetworkHelper.filterResponse(
        callBack: (json) {
          return (json);
        },
        response: response,
        parameterName: CallBackParameterName.all,
        onFailureCallBackWithMessage: (errorType, msg) {
          throw msg.toString();
        });
  }
}
