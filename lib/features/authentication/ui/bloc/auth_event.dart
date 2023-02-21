abstract class AuthEvent {
  const AuthEvent();
}

class LoginWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  LoginWithEmailAndPasswordEvent(this.email, this.password);
}

class LoginWithGoogle extends AuthEvent {}

class LoginWithTwitter extends AuthEvent {}

class LoginWithFacebook extends AuthEvent {}

class ResetPassword extends AuthEvent {
  final String email;

  ResetPassword(this.email);
}
