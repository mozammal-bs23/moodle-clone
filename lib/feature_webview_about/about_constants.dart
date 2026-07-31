import 'package:flutter/material.dart';

/// Local constants for the About page feature.
///
/// Centralises values that are not yet exposed by the shared
/// `flutter_boilerplate_core` package (which must not be modified
/// from feature branches).
class AboutConstants {
  /// Private constructor to prevent instantiation.
  AboutConstants._();

  /// Page and AppBar background colour — matches the white canvas
  /// used across the app's secondary screens.
  static const Color pageBackground = Color(0xFFFFFFFF);


  /// Size of trailing action icons (chevron / open-in-new).
  static const double trailingIconSize = 18;

  // Strings ------------------------------------------------------------

  /// Label for the Open Source Licences row.
  static const String labelOpenSourceLicences = 'Open Source Licences';

  /// Label for the Privacy policy row.
  static const String labelPrivacyPolicy = 'Privacy policy';

  /// Label for the Accessibility statement row.
  static const String labelAccessibilityStatement = 'Accessibility statement';

  /// Caption shown at the bottom of the page (app version).
  static const String labelAboutFooter = 'Moodle Mobile 5.2.1';
}
