import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:makharej_app/core/theming/theme.dart';
import 'package:makharej_app/features/authentication/provider/auth_service.dart';
import 'package:makharej_app/features/splash_screen/ui/splash_screen.dart';
import 'package:makharej_app/core/navigation/router.dart' as router;

class MakharejApp extends StatelessWidget {
  const MakharejApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthService>(
      create: (_) => AuthService(),
      child: MaterialApp(
        title: 'Modiriyat E Makharej',
        onGenerateRoute: router.Router.generateRoute,
        theme: themeData,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
        ],
        home: const SplashScreen(),
      ),
    );
  }
}
