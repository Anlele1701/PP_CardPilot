import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_providers.dart';
import '../initial_setup/initial_setup_providers.dart';
import 'domain/resolve_startup_destination.dart';
import 'domain/startup_destination.dart';

final resolveStartupDestinationProvider = Provider<ResolveStartupDestination>((
  ref,
) {
  return ResolveStartupDestination(ref.watch(initialSetupRepositoryProvider));
});

final startupDestinationProvider = FutureProvider<StartupDestination>((ref) {
  return ref.watch(resolveStartupDestinationProvider)(
    ref.watch(currentAuthUserProvider),
  );
});
