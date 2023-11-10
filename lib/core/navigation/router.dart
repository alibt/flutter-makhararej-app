import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makharej_app/features/authentication/ui/view/login_screen.dart';
import 'package:makharej_app/features/authentication/ui/view/signup_screen.dart';
import 'package:makharej_app/features/categories/provider/categories_provider.dart';
import 'package:makharej_app/features/categories/ui/bloc/categories_bloc.dart';
import 'package:makharej_app/features/family/provider/family_provider.dart';
import 'package:makharej_app/features/family/ui/bloc/family_screen_bloc.dart';
import 'package:makharej_app/features/family/ui/view/family_screen.dart';
import 'package:makharej_app/features/home/ui/home_screen.dart';
import 'package:makharej_app/features/profile/provider/user_provider.dart';

import 'route_paths.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var uri = Uri.parse(settings.name!);
    late Widget Function(BuildContext) builder;

    switch (uri.path) {
      case RoutePaths.homeScreen:
        builder = (_) => BlocProvider<CategoriesBloc>(
            create: (context) =>
                CategoriesBloc(context.read<CategoryProvider>()),
            child: const HomeScreen());
        break;
      case RoutePaths.loginScreen:
        builder = (_) => const LoginScreen();
        break;
      case RoutePaths.signUpScreen:
        builder = (_) => const SignupScreen();
        break;
      case RoutePaths.familyScreen:
        builder = (_) => BlocProvider<FamilyBloc>(
              create: (context) {
                return FamilyBloc(
                  context.read<FamilyProvider>(),
                  context.read<UserProvider>(),
                );
              },
              child: const FamilyScreen(),
            );
        break;
      default:
        FirebaseCrashlytics.instance.recordError(
          "no route defined for ${settings.name}",
          StackTrace.current,
          fatal: false,
        );
        FirebaseCrashlytics.instance.sendUnsentReports();
        return MaterialPageRoute(builder: (_) => Scaffold(body: Container()));
    }
    return MaterialPageRoute(settings: settings, builder: builder);
  }
}
