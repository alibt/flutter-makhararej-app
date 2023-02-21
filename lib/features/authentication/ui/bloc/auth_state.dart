import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState extends Equatable {
  final User? user;
  final bool isLoading;

  const AuthState(this.user, this.isLoading);

  @override
  List<Object?> get props => [user?.email, isLoading];
}

enum LoginStatus { success, failure, loading, init }

class LoginState extends AuthState {
  final LoginStatus state;
  final String? message;

  const LoginState({
    required this.state,
    this.message,
  }) : super(null, false);

  @override
  List<Object?> get props => [state, message, super.props];
}
