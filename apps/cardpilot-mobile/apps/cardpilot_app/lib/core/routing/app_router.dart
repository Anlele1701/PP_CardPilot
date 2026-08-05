import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/sign_in_screen.dart';
import '../../features/auth/presentation/views/sign_up_screen.dart';
import '../../features/home/presentation/views/home_screen.dart';
import '../../features/initial_setup/presentation/views/card_setup_screen.dart';
import '../../features/initial_setup/presentation/views/profile_setup_screen.dart';
import '../../features/startup/presentation/views/startup_screen.dart';
import '../presentation/views/error_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static const initialRoute = AppRoutes.startup;
  static const _notFoundArguments = ErrorScreenArguments(
    title: 'No Route was found',
    description: 'Sorry, no route was found!',
    actionLabel: 'Back to sign in',
    actionRoute: AppRoutes.signIn,
  );

  const AppRouter();

  Route<void> onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      AppRoutes.startup => MaterialPageRoute(
        builder: (_) => const StartupScreen(),
        settings: settings,
      ),
      '/' => MaterialPageRoute(
        builder: (_) => const SignInScreen(),
        settings: settings,
      ),
      AppRoutes.signIn => MaterialPageRoute(
        builder: (_) => const SignInScreen(),
        settings: settings,
      ),
      AppRoutes.signUp => MaterialPageRoute(
        builder: (_) => const SignUpScreen(),
        settings: settings,
      ),
      AppRoutes.setupProfile => MaterialPageRoute(
        builder: (_) => const ProfileSetupScreen(),
        settings: settings,
      ),
      AppRoutes.setupCard => MaterialPageRoute(
        builder: (_) => const CardSetupScreen(),
        settings: settings,
      ),
      AppRoutes.home => MaterialPageRoute(
        builder: (_) => const HomeScreen(),
        settings: settings,
      ),
      AppRoutes.error => MaterialPageRoute(
        builder: (_) =>
            ErrorScreen.fromArguments(_errorArgumentsFrom(settings)),
        settings: settings,
      ),
      _ => MaterialPageRoute(
        builder: (_) => ErrorScreen.fromArguments(_notFoundArguments),
        settings: settings,
      ),
    };
  }

  ErrorScreenArguments _errorArgumentsFrom(RouteSettings settings) {
    final arguments = settings.arguments;
    if (arguments is ErrorScreenArguments) {
      return arguments;
    }

    throw ArgumentError.value(
      arguments,
      'settings.arguments',
      'The error route requires ErrorScreenArguments.',
    );
  }
}
