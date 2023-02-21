import 'package:flutter/material.dart';

class RoutePaths {
  static const String homeScreen = "homeScreen";
  static const String loginScreen = "loginScreen";

  static void navigateHome(BuildContext context) {
    Navigator.of(context).pushNamed(homeScreen);
  }

  static void navigateLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(loginScreen);
  }
}
