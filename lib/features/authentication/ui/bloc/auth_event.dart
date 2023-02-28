abstract class AuthEvent {
  const AuthEvent();
}

class CheckAuthStateEvent extends AuthEvent {}

class LoginWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  LoginWithEmailAndPasswordEvent(this.email, this.password);
}

class LoginWithGoogleEvent extends AuthEvent {}

class LoginWithTwitterEvent extends AuthEvent {}

class LoginWithFacebookEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class ResetPassword extends AuthEvent {
  final String email;

  ResetPassword(this.email);
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpEvent(this.email, this.password);
}
