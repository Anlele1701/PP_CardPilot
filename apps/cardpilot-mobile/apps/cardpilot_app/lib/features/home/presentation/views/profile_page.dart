import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/notifications/app_toast.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../auth/auth_providers.dart';
import '../../../initial_setup/domain/entities/access_mode.dart';
import '../../../initial_setup/domain/entities/local_workspace.dart';

const _pagePadding = EdgeInsets.fromLTRB(
  ui.AppSpacing.lg,
  ui.AppSpacing.lg,
  ui.AppSpacing.lg,
  132,
);

class ProfilePage extends ConsumerWidget {
  const ProfilePage({required this.workspace});

  final LocalWorkspace workspace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGuest = workspace.accessMode == AccessMode.guest;
    final signOutState = ref.watch(signOutControllerProvider);
    final isSigningOut = signOutState.status == SignOutStatus.loading;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: _pagePadding,
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                workspace.profile.displayName.characters.first.toUpperCase(),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: ui.AppSpacing.md),
            Text(
              workspace.profile.displayName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: ui.AppSpacing.xs),
            Text(
              isGuest ? 'Guest · local-only' : 'Signed in',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: ui.AppSpacing.xl),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text('Personal information'),
                    subtitle: const Text('Name and profile preferences'),
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.workspace_premium_outlined),
                    title: const Text('Membership'),
                    subtitle: const Text('Bronze'),
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    key: const Key('sync-now-button'),
                    leading: const Icon(Icons.sync_rounded),
                    title: const Text('Sync now'),
                    subtitle: const Text(
                      'Refresh common data and sync your changes',
                    ),
                    onTap: () => AppToast.showInfo(
                      context,
                      'Sync will be connected in the next phase.',
                    ),
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('App settings'),
                    subtitle: const Text(
                      'Appearance, notifications and privacy',
                    ),
                    onTap: () {},
                  ),
                  if (isGuest) ...[
                    const Divider(height: 1, indent: 56),
                    const ListTile(
                      leading: Icon(Icons.cloud_upload_outlined),
                      title: Text('Sign in and sync'),
                      subtitle: Text('Back up local data to your account'),
                    ),
                  ],
                ],
              ),
            ),
            if (!isGuest) ...[
              const SizedBox(height: ui.AppSpacing.lg),
              OutlinedButton.icon(
                onPressed: isSigningOut
                    ? null
                    : () => _confirmAndSignOut(context, ref),
                icon: isSigningOut
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.logout_rounded),
                label: Text(isSigningOut ? 'Signing out...' : 'Log out'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _confirmAndSignOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Log out?'),
          content: const Text(
            'You will need to sign in again to access your synced data.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Log out'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final signedOut = await ref
        .read(signOutControllerProvider.notifier)
        .signOut();

    if (!context.mounted) {
      return;
    }

    if (!signedOut) {
      AppToast.showError(
        context,
        ref.read(signOutControllerProvider).errorMessage ??
            'Unable to sign out right now. Please try again.',
      );
      return;
    }

    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutes.signIn, (route) => false);
  }
}
