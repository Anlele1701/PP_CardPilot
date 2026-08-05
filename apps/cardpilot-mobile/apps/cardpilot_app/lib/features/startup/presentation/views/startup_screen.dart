import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/presentation/views/error_screen.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../initial_setup/initial_setup_providers.dart';
import '../../domain/startup_destination.dart';
import '../../startup_providers.dart';

class StartupScreen extends ConsumerWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(startupDestinationProvider, (_, next) {
      next.whenData((destination) {
        final workspace = destination.workspace;
        if (workspace != null) {
          ref.read(initialSetupControllerProvider.notifier).restore(workspace);
        } else if (destination.accessMode != null) {
          ref
              .read(initialSetupControllerProvider.notifier)
              .selectAccessMode(destination.accessMode!);
        }

        final route = switch (destination.route) {
          StartupRoute.signIn => AppRoutes.signIn,
          StartupRoute.setupProfile => AppRoutes.setupProfile,
          StartupRoute.home => AppRoutes.home,
        };

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            Navigator.of(context).pushReplacementNamed(route);
          }
        });
      });
    });

    final startup = ref.watch(startupDestinationProvider);
    return startup.when(
      data: (_) =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, _) => ErrorScreen(
        title: 'Could not open CardPilot',
        description:
            'Your local data could not be loaded. Close the app and try again.',
        actionLabel: 'Try again',
        onAction: () => ref.invalidate(startupDestinationProvider),
      ),
    );
  }
}
