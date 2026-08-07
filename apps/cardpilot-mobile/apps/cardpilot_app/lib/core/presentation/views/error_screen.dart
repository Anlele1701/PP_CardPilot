import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';

class ErrorScreenArguments {
  const ErrorScreenArguments({
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.actionRoute,
  });

  final String title;
  final String description;
  final String actionLabel;
  final String actionRoute;
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    required this.title,
    required this.description,
    required this.actionLabel,
    this.actionRoute,
    this.onAction,
    super.key,
  }) : assert(actionRoute != null || onAction != null);

  ErrorScreen.fromArguments(ErrorScreenArguments arguments, {super.key})
    : title = arguments.title,
      description = arguments.description,
      actionLabel = arguments.actionLabel,
      actionRoute = arguments.actionRoute,
      onAction = null;

  final String title;
  final String description;
  final String actionLabel;
  final String? actionRoute;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ui.AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    child: Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: colorScheme.errorContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.error_outline_rounded,
                        size: 48,
                        color: colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: ui.AppSpacing.xl),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: ui.AppSpacing.sm),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: ui.AppSpacing.xl),
                  ui.AppPrimaryButton(
                    label: actionLabel,
                    onPressed: () {
                      final action = onAction;
                      if (action != null) {
                        action();
                        return;
                      }

                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil(actionRoute!, (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
