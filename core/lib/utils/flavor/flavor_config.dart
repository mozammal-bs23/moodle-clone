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
  /// Singleton instance of FlavorConfig
  static late FlavorConfig instance;

  /// Current flavor
  final Flavor flavor;

  /// App display name for the current flavor
  final String appName;

  /// API base URL for the current flavor
  final String baseUrl;

  FlavorConfig._({
    required this.flavor,
    required this.appName,
    required this.baseUrl,
  });

  /// Creates dev flavor configuration
  factory FlavorConfig.dev() => FlavorConfig._(
    flavor: Flavor.dev,
    appName: 'Flutter Boilerplate Dev',
    baseUrl: 'https://api-dev.example.com',
  );

  /// Creates staging flavor configuration
  factory FlavorConfig.staging() => FlavorConfig._(
    flavor: Flavor.staging,
    appName: 'Flutter Boilerplate Staging',
    baseUrl: 'https://api-staging.example.com',
  );

  /// Creates production flavor configuration
  factory FlavorConfig.prod() => FlavorConfig._(
    flavor: Flavor.prod,
    appName: 'Flutter Boilerplate',
    baseUrl: 'https://api.example.com',
  );

  /// Returns true if current flavor is dev
  bool get isDev => flavor == Flavor.dev;

  /// Returns true if current flavor is staging
  bool get isStaging => flavor == Flavor.staging;

  /// Returns true if current flavor is prod
  bool get isProd => flavor == Flavor.prod;
}
