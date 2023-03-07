import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makharej_app/core/navigation/route_paths.dart';
import 'package:makharej_app/core/utils/extensions/string_extension.dart';
import 'package:makharej_app/core/utils/widgets/spaces.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spaces.VERTICAL_M,
          TextFormField(
            controller: userNameController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
            ),
            validator: (value) {
              if (value == null) {
                return "Please enter your email";
              }
              return value.emailValidator();
            },
          ),
          Spaces.VERTICAL_M,
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          Spaces.VERTICAL_M,
          ElevatedButton(
              onPressed: () => onLoginUsingEmailPassword(
                    BlocProvider.of<AuthBloc>(context),
                  ),
              child: const Text("Login")),
          TextButton(
            onPressed: () => onGoogleLogin(BlocProvider.of<AuthBloc>(context)),
            child: const Text("Sign In Using Google"),
          ),
          TextButton(
            onPressed: () => onSignUp(
              BlocProvider.of<AuthBloc>(context),
            ),
            child: const Text("Don't have an account? SignUp!"),
          )
        ],
      ),
    );
  }

  void onSignUp(AuthBloc authBloc) {
    if (authBloc.state.isLoading) return;
    RoutePaths.navigateSignUpScreen(context);
  }

  void onLoginUsingEmailPassword(AuthBloc authBloc) {
    if (_formKey.currentState?.validate() ?? false) {
      authBloc.add(LoginWithEmailAndPasswordEvent(
          userNameController.text, passwordController.text));
    }
  }

  void onGoogleLogin(AuthBloc authBloc) {
    authBloc.add(LoginWithGoogleEvent());
  }
}
