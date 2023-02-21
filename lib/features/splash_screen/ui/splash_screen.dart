import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makharej_app/core/navigation/route_paths.dart';
import 'package:makharej_app/core/utils/widgets/spaces.dart';
import 'package:makharej_app/features/authentication/provider/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var user = context.read<AuthService>().getUser();
      await Future.delayed(const Duration(seconds: 1));
      handleAuthorizationStatus(user);
    });
    super.initState();
  }

  void handleAuthorizationStatus(User? user) {
    if (user == null) {
      RoutePaths.navigateLoginScreen(context);
    } else {
      RoutePaths.navigateHome(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Spaces.VERTICAL_XL,
            Text(
              "Makharej App",
            ),
            Text("It is simple to use!"),
            Spaces.VERTICAL_XL,
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
