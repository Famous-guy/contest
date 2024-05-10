import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'network_enums.dart';
import 'network_typedef.dart';

class NetworkHelper {
  const NetworkHelper._();

  static bool _isValidResponse(json) {
    return json != null;
  }

  static R filterResponse<R>(
      {required NetworkCallBack callBack,
      required http.Response? response,
      required NetworkOnFailureCallBackWithMessage onFailureCallBackWithMessage,
      CallBackParameterName parameterName = CallBackParameterName.all}) {
    try {
      if (response == null) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.responseEmpty,
            'No response found. Please try again');
      }

      var json = jsonDecode(response.body);

      if (response.body.isEmpty || response.statusCode == 200) {
        return callBack(parameterName.getJson(json));
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (_isValidResponse(json)) {
          return callBack(parameterName.getJson(json));
        }
      } else if (response.statusCode == 400) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.badRequest, json['message']);
      } else if (response.statusCode == 422) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.badRequest, json['message']);
      } else if (response.statusCode == 403) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.badRequest, json['message']);
      } else if (response.statusCode == 409) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.conflict, json['message']);
      } else if (response.statusCode == 404) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.badRequest, json['message']);
      } else if (response.statusCode == 500) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.badRequest, json['message']);
      }

      return onFailureCallBackWithMessage(
          NetworkResponseErrorType.didNotSucceed,
          'Error occurred processing request. Try again!');
    } on TimeoutException catch (_) {
      return onFailureCallBackWithMessage(
          NetworkResponseErrorType.timeout, 'Network timeout');
    } on SocketException catch (_) {
      return onFailureCallBackWithMessage(NetworkResponseErrorType.exception,
          'Network error. Please check that you have internet connection!');
    }
  }
}
