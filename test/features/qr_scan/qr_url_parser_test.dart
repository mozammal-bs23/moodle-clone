import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/feature_qr_scan/utils/qr_url_parser.dart';

void main() {
  group('extractBaseUrl', () {
    test('returns null for empty input', () {
      expect(extractBaseUrl(''), isNull);
    });

    test('returns null for whitespace-only input', () {
      expect(extractBaseUrl('   '), isNull);
    });

    test('returns null for plain text', () {
      expect(extractBaseUrl('hello world'), isNull);
    });

    test('returns null for random words', () {
      expect(extractBaseUrl('just some words'), isNull);
    });

    test('normalizes a clean https URL', () {
      expect(
        extractBaseUrl('https://moodle.example.edu'),
        equals('https://moodle.example.edu'),
      );
    });

    test('lowercases the scheme', () {
      expect(
        extractBaseUrl('HTTPS://Moodle.Example.Edu'),
        equals('https://moodle.example.edu'),
      );
    });

    test('drops path, query, and fragment', () {
      expect(
        extractBaseUrl('https://moodle.example.edu/course/1?foo=bar#x'),
        equals('https://moodle.example.edu'),
      );
    });

    test('preserves port when present', () {
      expect(
        extractBaseUrl('https://moodle.local:8443'),
        equals('https://moodle.local:8443'),
      );
    });

    test('promotes a domain-shaped input without scheme', () {
      expect(
        extractBaseUrl('moodle.example.edu'),
        equals('https://moodle.example.edu'),
      );
    });

    test('promotes www. input to https', () {
      expect(
        extractBaseUrl('www.example.com'),
        equals('https://www.example.com'),
      );
    });

    test('promotes lms. input to https', () {
      expect(
        extractBaseUrl('lms.example.com'),
        equals('https://lms.example.com'),
      );
    });

    test('trims surrounding whitespace', () {
      expect(
        extractBaseUrl('   https://moodle.example.edu  '),
        equals('https://moodle.example.edu'),
      );
    });

    test('rejects non-http(s) schemes', () {
      expect(extractBaseUrl('ftp://example.com'), isNull);
      expect(extractBaseUrl('javascript:alert(1)'), isNull);
    });

    test('rejects a value that has a scheme but no host', () {
      expect(extractBaseUrl('https://'), isNull);
    });

    test('http scheme is preserved (lowercased)', () {
      expect(
        extractBaseUrl('HTTP://example.com'),
        equals('http://example.com'),
      );
    });
  });
}