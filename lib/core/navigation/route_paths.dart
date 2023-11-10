import 'package:makharej_app/core/app/app.dart';

class RoutePaths {
  static const String homeScreen = "homeScreen";
  static const String loginScreen = "loginScreen";
  static const String signUpScreen = "signUpScreen";
  static const String familyScreen = "familyScreen";
  static void navigateHome() {
    navigatorKey.currentState?.pushReplacementNamed(homeScreen);
  }

  static void navigateLoginScreen() {
    navigatorKey.currentState?.pushReplacementNamed(loginScreen);
  }

  static void navigateSignUpScreen() {
    navigatorKey.currentState?.pushNamed(signUpScreen);
  }

  static void navigateFamilyScreen() {
    navigatorKey.currentState?.pushNamed(familyScreen);
  }
}
