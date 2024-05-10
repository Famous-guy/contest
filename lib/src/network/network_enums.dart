enum NetworkResponseErrorType {
  socket,
  exception,
  badRequest,
  timeout,
  responseEmpty,
  didNotSucceed,
  conflict
}

enum CallBackParameterName { all, token }

extension CallbackParameterNameExtention on CallBackParameterName {
  dynamic getJson(json) {
    if (json == null) return null;
    switch (this) {
      case CallBackParameterName.all:
        return json;
      case CallBackParameterName.token:
        return json['token'];
    }
  }
}
