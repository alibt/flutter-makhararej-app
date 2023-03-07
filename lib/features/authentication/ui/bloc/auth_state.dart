// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class AuthState extends Equatable {
  final User? user;
  final bool isLoading;

  const AuthState({
    this.user,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        user?.email,
      ];

  AuthState copyWith({
    User? user,
    bool? isLoading,
  }) {
    return AuthState(
        user: user ?? this.user, isLoading: isLoading ?? this.isLoading);
  }
  // UnauthorizedState copyUnauthorized({
  //   User? user,
  //   bool? isLoading ,
  //   String? message,
  // }) {
  //   return UnauthorizedState(
  //     user ?? this.user,
  //     isLoading ?? this.isLoading,
  //   );
  // }
}

class AuthInitState extends AuthState {}

class UnauthorizedState extends AuthState {
  final String message;
  const UnauthorizedState({
    this.message = "Unknown Error",
    super.user,
    super.isLoading,
  });
}

class AuthenticatedState extends AuthState {
  const AuthenticatedState({
    super.user,
    super.isLoading = false,
  });
}

class RegisterationFailedState extends AuthState {
  final String message;

  const RegisterationFailedState(this.message) : super();
}

class AuthenticationFailedState extends AuthState {
  final String message;

  const AuthenticationFailedState(
    this.message, {
    super.isLoading,
    super.user,
  });
}

class UnAuthenticatedState extends AuthState {}
