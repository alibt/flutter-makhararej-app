import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makharej_app/core/navigation/route_paths.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_bloc.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_state.dart';

import 'widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        listener: authBlocListener,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Sign In'),
            ),
            body: Stack(
              children: [
                const Padding(padding: EdgeInsets.all(8.0), child: LoginForm()),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator())
              ],
            ),
          );
        });
  }

  void authBlocListener(context, state) {
    if (state is AuthenticatedState) {
      if (state.user?.familyID != null) {
        RoutePaths.navigateHome();
        return;
      }
      if (state.user?.familyID == null) {
        RoutePaths.navigateFamilyScreen();
        return;
      }
    }
    if (state is UnauthorizedState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }
}
