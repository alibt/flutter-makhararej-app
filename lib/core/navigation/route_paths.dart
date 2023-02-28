import 'package:flutter/material.dart';

class RoutePaths {
  static const String homeScreen = "homeScreen";
  static const String loginScreen = "loginScreen";
  static const String signUpScreen = "signUpScreen";

  static void navigateHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(homeScreen);
  }

  static void navigateLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(loginScreen);
  }

  static void navigateSignUpScreen(BuildContext context) {
    Navigator.of(context).pushNamed(signUpScreen);
  }
}
