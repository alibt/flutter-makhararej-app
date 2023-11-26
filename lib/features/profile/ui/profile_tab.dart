import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makharej_app/core/navigation/route_paths.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_bloc.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_event.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_state.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitState) {
          RoutePaths.navigateLoginScreen();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("profile tab"),
                TextButton(
                    onPressed: () =>
                        context.read<AuthBloc>().add(LogoutEvent()),
                    child: const Text("logout")),
              ],
            ),
            if (state.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
        );
      },
    );
  }
}
