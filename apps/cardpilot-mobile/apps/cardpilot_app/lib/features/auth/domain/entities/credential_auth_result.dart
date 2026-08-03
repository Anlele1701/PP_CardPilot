class CredentialAuthResult {
  const CredentialAuthResult({
    required this.hasSession,
    required this.requiresEmailConfirmation,
  });

  final bool hasSession;
  final bool requiresEmailConfirmation;
}
