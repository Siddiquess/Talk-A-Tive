class AppExceptions implements Exception {
  final dynamic _message;

  AppExceptions([this._message]);

  @override
  String toString() {
    return "$_message";
  }
}

class FetchDataExceptions extends AppExceptions {
  FetchDataExceptions([String? message]) : super(message);
}

class UnauthorizedExeptions extends AppExceptions {
  UnauthorizedExeptions([String? message]) : super(message);
}

class BadRequestExeptions extends AppExceptions {
  BadRequestExeptions([String? message]) : super(message);
}

class InvalidException extends AppExceptions {
  InvalidException([String? message]) : super(message);
}
