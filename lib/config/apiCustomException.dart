

class ApiCustomException implements Exception {

  final _message;
  final _code;

  ApiCustomException([this._message, this._code]);

  String toString() {
    return "$_code $_message";
  }

}

class FetchDataException extends ApiCustomException {
  FetchDataException([String? message]) : super (message, "Error During Communication: ");
}

class BadRequestException extends ApiCustomException {
  BadRequestException([String ? message]) : super (message, "Invalid request: ");
}

class UnauthorizedException extends ApiCustomException {
  UnauthorizedException([String ? message]) : super (message, "Unauthorised: ");
}

class InvalidInputException  extends ApiCustomException {
  InvalidInputException ([String ? message]) : super (message, "Invalid input: ");
}





