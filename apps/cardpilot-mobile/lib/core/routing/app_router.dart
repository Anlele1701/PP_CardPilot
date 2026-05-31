import 'package:flutter/material.dart';

import '../../features/onboarding/presentation/views/onboarding_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static const initialRoute = AppRoutes.onboarding;
  const AppRouter();

  Route<void> onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      AppRoutes.onboarding => MaterialPageRoute(
        builder: (_) => const OnboardingScreen(),
        settings: settings,
      ),
      _ => MaterialPageRoute(
        builder: (_) => const OnboardingScreen(),
        settings: settings,
      ),
    };
  }
}
