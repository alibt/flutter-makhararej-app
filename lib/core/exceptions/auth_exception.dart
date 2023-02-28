abstract class AuthException implements Exception {
  @override
  String toString() => "Login Exception";
}

class UserNotFoundException extends AuthException {}

class InvalidCredentialsException extends AuthException {}

class UnknownLoginException extends AuthException {}

class GoogleLoginException extends AuthException {}

class LogoutException extends AuthException {}

class WeakPasswordException extends AuthException {}

class EmailAlreadyInUseException extends AuthException {}

class UnknownRegisterException extends AuthException {}
