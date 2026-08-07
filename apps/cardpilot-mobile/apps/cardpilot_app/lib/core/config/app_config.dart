class AppConfig {
  const AppConfig._();

  static const appName = 'CardPilot';
  static const appTagline = 'Smart cashback tracking for smarter spending';
  static const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );
  static const oauthRedirectUrl = 'io.cardpilot.app://login-callback/';

  static bool get isSupabaseConfigured =>
      supabaseUrl.isNotEmpty && supabasePublishableKey.isNotEmpty;

  static bool get isApiConfigured => apiBaseUrl.isNotEmpty;
}
