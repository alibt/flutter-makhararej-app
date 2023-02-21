abstract class LoginException implements Exception {
  @override
  String toString() => "Login Exception";
}

class UserNotFoundException extends LoginException {}

class InvalidCredentialsException extends LoginException {}

class UnknownLoginException extends LoginException {}
