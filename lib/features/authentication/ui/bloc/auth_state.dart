import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState extends Equatable {
  final User? user;

  const AuthState(
    this.user,
  );

  @override
  List<Object?> get props => [
        user?.email,
      ];
}

enum LoginStatus { success, failure, loading, init }

class AuthInitState extends AuthState {
  const AuthInitState(super.user);
}

class LoadingAuthState extends AuthState {
  const LoadingAuthState(super.user);
}

class UnauthorizedState extends AuthState {
  final String message;
  const UnauthorizedState(super.user, {this.message = "Unknown Error"});
}

class AuthorizedState extends AuthState {
  const AuthorizedState(super.user);
}

class RegisterationFailedState extends AuthState {
  final String message;

  const RegisterationFailedState(this.message) : super(null);
}
