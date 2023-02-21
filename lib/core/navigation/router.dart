import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makharej_app/features/authentication/provider/auth_service.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_bloc.dart';
import 'package:makharej_app/features/authentication/ui/view/login_screen.dart';
import 'package:makharej_app/features/home/presentation/home_screen.dart';

import 'route_paths.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var uri = Uri.parse(settings.name!);
    late Widget Function(BuildContext) builder;

    switch (uri.path) {
      case RoutePaths.homeScreen:
        builder = (_) => const HomeScreen();
        break;
      case RoutePaths.loginScreen:
        builder = (_) => BlocProvider(
            create: (context) => AuthBloc(
                  RepositoryProvider.of<AuthService>(context),
                ),
            child: const LoginScreen());
        break;

      default:
        FirebaseCrashlytics.instance.recordError(
          "no route defined for ${settings.name}",
          StackTrace.current,
          fatal: false,
        );
        FirebaseCrashlytics.instance.sendUnsentReports();
        return MaterialPageRoute(
            builder: (_) => Scaffold(body: Container()
                // Center(
                //   child: Text('No route defined for ${settings.name}'),
                // ),
                ));
    }
    return MaterialPageRoute(settings: settings, builder: builder);
  }
}
