import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makharej_app/core/navigation/route_paths.dart';
import 'package:makharej_app/core/utils/widgets/spaces.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_bloc.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_event.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController userNameController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    userNameController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, LoginState>(listener: (context, state) {
      if (state.state == LoginStatus.success) {
        Navigator.of(context).pushNamed(RoutePaths.homeScreen);
      }
      if (state.state == LoginStatus.failure) {
        showDialog(
          context: context,
          builder: (context) {
            return Text(state.message ?? "Error While Logging In");
          },
        );
      }
    }, buildWhen: (previous, current) {
      return previous.state != current.state;
    }, builder: (context, state) {
      return SafeArea(
        child: Stack(
          children: [
            Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${state.state}"),
                    Spaces.VERTICAL_M,
                    TextField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                        hintText: "User Name",
                      ),
                    ),
                    Spaces.VERTICAL_M,
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    TextButton(
                        onPressed: (() =>
                            onLogin(BlocProvider.of<AuthBloc>(context))),
                        child: const Text("login")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: onFacebookLogin,
                          child: const Text("Facebook"),
                        ),
                        TextButton(
                          onPressed: onGoogleLogin,
                          child: const Text("Google"),
                        ),
                        TextButton(
                          onPressed: onTwitterLogin,
                          child: const Text("Twitter"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            if (state.state == LoginStatus.loading)
              const Center(child: CircularProgressIndicator())
          ],
        ),
      );
    });
  }

  void onLogin(AuthBloc authBloc) {
    authBloc.add(LoginWithEmailAndPasswordEvent(
        userNameController.text, passwordController.text));
  }

  void onTwitterLogin() {}

  void onGoogleLogin() {}

  void onFacebookLogin() {}
}
