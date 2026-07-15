import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlavorConfig', () {
    test('dev() defaults match the pre-existing hardcoded values', () {
      final config = FlavorConfig.dev();
      expect(config.flavor, Flavor.dev);
      expect(config.appName, 'Flutter Boilerplate Dev');
      expect(config.baseUrl, 'https://api-dev.example.com');
      expect(config.isDev, isTrue);
    });

    test('staging() defaults match the pre-existing hardcoded values', () {
      final config = FlavorConfig.staging();
      expect(config.flavor, Flavor.staging);
      expect(config.appName, 'Flutter Boilerplate Staging');
      expect(config.baseUrl, 'https://api-staging.example.com');
      expect(config.isStaging, isTrue);
    });

    test('prod() defaults match the pre-existing hardcoded values', () {
      final config = FlavorConfig.prod();
      expect(config.flavor, Flavor.prod);
      expect(config.appName, 'Flutter Boilerplate');
      expect(config.baseUrl, 'https://api.example.com');
      expect(config.isProd, isTrue);
    });
  });
}
