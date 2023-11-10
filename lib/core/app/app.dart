import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:makharej_app/core/navigation/route_paths.dart';
import 'package:makharej_app/core/theming/theme.dart';
import 'package:makharej_app/features/authentication/provider/firebase_auth_provider.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_bloc.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_state.dart';
import 'package:makharej_app/features/categories/provider/categories_provider.dart';
import 'package:makharej_app/features/family/provider/family_provider.dart';
import 'package:makharej_app/features/profile/provider/user_provider.dart';
import 'package:makharej_app/features/splash_screen/ui/splash_screen.dart';
import 'package:makharej_app/core/navigation/router.dart' as router;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MakharejApp extends StatelessWidget {
  const MakharejApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<FirebaseAuthProvider>(
      create: (_) => FirebaseAuthProvider(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<CategoryProvider>(
            create: (context) => CategoryProvider(
              context.read<FirebaseAuthProvider>(),
            ),
          ),
          RepositoryProvider<FamilyProvider>(
            create: (context) => FamilyProvider(
              context.read<FirebaseAuthProvider>(),
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
                create: (context) => AuthBloc(
                      RepositoryProvider.of<FirebaseAuthProvider>(context),
                      RepositoryProvider.of<UserProvider>(context),
                    )),
          ],
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenticatedState) {
                RoutePaths.navigateLoginScreen();
              }
            },
            child: MaterialApp(
              title: 'Modiriyat E Makharej',
              onGenerateRoute: router.Router.generateRoute,
              theme: themeData,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              navigatorKey: navigatorKey,
              supportedLocales: const [
                Locale('en'),
              ],
              home: const SplashScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
