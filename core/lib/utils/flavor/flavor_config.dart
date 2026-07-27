/// Supported app flavors
enum Flavor {
  /// Development environment
  dev,

  /// Staging environment
  staging,

  /// Production environment
  prod,
}

/// Global flavor configuration for the app
class FlavorConfig {
  FlavorConfig._({
    required this.flavor,
    required this.appName,
    required this.baseUrl,
  });

  /// Creates dev flavor configuration.
  ///
  /// Reads `APP_NAME`/`BASE_URL` from the compile-time environment
  /// (pass `--dart-define-from-file=env/dev.json` to override), falling
  /// back to the values below when the flag is omitted.
  factory FlavorConfig.dev() => FlavorConfig._(
    flavor: Flavor.dev,
    appName: const String.fromEnvironment(
      'APP_NAME',
      defaultValue: 'Flutter Boilerplate Dev',
    ),
    baseUrl: const String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'https://api-dev.example.com',
    ),
  );

  /// Creates staging flavor configuration.
  ///
  /// Reads `APP_NAME`/`BASE_URL` from the compile-time environment
  /// (pass `--dart-define-from-file=env/staging.json` to override), falling
  /// back to the values below when the flag is omitted.
  factory FlavorConfig.staging() => FlavorConfig._(
    flavor: Flavor.staging,
    appName: const String.fromEnvironment(
      'APP_NAME',
      defaultValue: 'Flutter Boilerplate Staging',
    ),
    baseUrl: const String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'https://api-staging.example.com',
    ),
  );

  /// Creates production flavor configuration.
  ///
  /// Reads `APP_NAME`/`BASE_URL` from the compile-time environment
  /// (pass `--dart-define-from-file=env/prod.json` to override), falling
  /// back to the values below when the flag is omitted.
  factory FlavorConfig.prod() => FlavorConfig._(
    flavor: Flavor.prod,
    appName: const String.fromEnvironment(
      'APP_NAME',
      defaultValue: 'Flutter Boilerplate',
    ),
    baseUrl: const String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'https://api.example.com',
    ),
  );

  /// Singleton instance of FlavorConfig
  static late FlavorConfig instance;

  /// Current flavor
  final Flavor flavor;

  /// App display name for the current flavor
  final String appName;

  /// API base URL for the current flavor
  final String baseUrl;

  /// Returns true if current flavor is dev
  bool get isDev => flavor == Flavor.dev;

  /// Returns true if current flavor is staging
  bool get isStaging => flavor == Flavor.staging;

  /// Returns true if current flavor is prod
  bool get isProd => flavor == Flavor.prod;
}
