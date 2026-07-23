import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/login_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static const initialRoute = AppRoutes.login;

  const AppRouter();

  Route<void> onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      AppRoutes.login => MaterialPageRoute(
        builder: (_) => const LoginScreen(),
        settings: settings,
      ),
      _ => MaterialPageRoute(
        builder: (_) => const LoginScreen(),
        settings: settings,
      ),
    };
  }
}
