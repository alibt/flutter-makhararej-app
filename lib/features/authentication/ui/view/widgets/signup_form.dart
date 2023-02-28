import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makharej_app/core/utils/extensions/string_extension.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        _confirmPasswordController = confirmPasswordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
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
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
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
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Enter your password again',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your password again';
              } else if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => onSignUp(context),
            child: const Text('Sign up'),
          ),
        ],
      ),
    );
  }

  void onSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context)
          .add(SignUpEvent(_emailController.text, _passwordController.text));
    }
  }
}
