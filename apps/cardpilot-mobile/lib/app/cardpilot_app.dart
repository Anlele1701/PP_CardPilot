import 'package:flutter/material.dart';

import '../core/config/app_config.dart';
import '../core/routing/app_router.dart';
import '../core/theme/app_theme.dart';

class CardPilotApp extends StatelessWidget {
  const CardPilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      onGenerateRoute: const AppRouter().onGenerateRoute,
      initialRoute: AppRouter.initialRoute,
    );
  }
}
