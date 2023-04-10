abstract class AuthException implements Exception {
  final String message;

  AuthException({this.message = "Unknown Exception"});
  @override
  String toString() => "Login Exception";
}

class UserNotFoundException extends AuthException {
  UserNotFoundException();
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException();
}

class UnknownLoginException extends AuthException {
  UnknownLoginException();
}

class GoogleLoginException extends AuthException {
  GoogleLoginException();
}

class LogoutException extends AuthException {
  LogoutException();
}

class WeakPasswordException extends AuthException {
  WeakPasswordException();
}

class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException();
}

class InvalidEmailException extends AuthException {
  InvalidEmailException();
}

class UnknownRegisterException extends AuthException {
  UnknownRegisterException();
}

class NoAccessToFireBaseServer extends AuthException {
  NoAccessToFireBaseServer();
  @override
  String toString() => "Network Error or Server Unavailable";
}
