import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makharej_app/core/navigation/route_paths.dart';
import 'package:makharej_app/core/utils/widgets/spaces.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_bloc.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_event.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkAuthState();
    });
    super.initState();
  }

  void checkAuthState() {
    BlocProvider.of<AuthBloc>(context).add(CheckAuthStateEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        listener: authBlocListener,
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spaces.VERTICAL_XL,
                  const Text(
                    "Makharej App",
                  ),
                  const Text("It is simple to use!"),
                  Spaces.VERTICAL_XL,
                  if (state.isLoading) const CircularProgressIndicator()
                ],
              ),
            ),
          );
        });
  }

  void authBlocListener(context, state) {
    if (state is AuthenticatedState) {
      if (state.user?.familyID == null) {
        RoutePaths.navigateFamilyScreen(true);
        return;
      }
      RoutePaths.navigateHome();
    }
    if (state is UnAuthenticatedState) {
      RoutePaths.navigateLoginScreen();
    }
  }
}
