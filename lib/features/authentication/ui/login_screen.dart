import 'package:flutter/material.dart';
import 'package:makharej_app/core/utils/spaces.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text("login"), Spaces.VERTICAL_M],
      ),
    );
  }
}
