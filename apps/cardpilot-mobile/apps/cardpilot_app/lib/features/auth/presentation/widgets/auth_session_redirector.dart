import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../initial_setup/domain/entities/access_mode.dart';
import '../../../initial_setup/initial_setup_providers.dart';

class AuthSessionRedirector extends ConsumerStatefulWidget {
  const AuthSessionRedirector({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<AuthSessionRedirector> createState() =>
      _AuthSessionRedirectorState();
}

class _AuthSessionRedirectorState extends ConsumerState<AuthSessionRedirector> {
  StreamSubscription<AuthState>? _authSubscription;
  bool _hasContinuedToSetup = false;

  @override
  void initState() {
    super.initState();

    if (!AppConfig.isSupabaseConfigured) {
      return;
    }

    final auth = Supabase.instance.client.auth;
    _authSubscription = auth.onAuthStateChange.listen((authState) {
      if (authState.session != null) {
        _continueToSetup();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (auth.currentSession != null) {
        _continueToSetup();
      }
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  void _continueToSetup() {
    if (!mounted || _hasContinuedToSetup) {
      return;
    }

    _hasContinuedToSetup = true;
    ref
        .read(initialSetupControllerProvider.notifier)
        .selectAccessMode(AccessMode.authenticated);
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutes.setupProfile, (_) => false);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
