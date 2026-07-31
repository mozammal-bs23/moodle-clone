/// Constants used by the My Courses feature.
///
/// Lives in the domain layer so both the use case (which resolves
/// credentials) and the data layer (which keeps a copy for safety) can
/// share the same source of truth without crossing package boundaries.
class MyCoursesConstants {
  /// Storage key under which the auth token is kept in [LocalStorage].
  static const String tokenKey = 'token';

  /// Storage key under which the Moodle user id is kept in [LocalStorage].
  static const String userIdKey = 'userid';

  /// Fallback token used when SharedPreferences doesn't have one.
  ///
  /// Per the README: only used when no token has been stored. Never
  /// hardcode this in the data source so it can't accidentally leak into
  /// generated/committed code.
  static const String fallbackToken = '5dc0f086abc4b82a1562b01a20637705';

  /// Fallback user id used when SharedPreferences doesn't have one.
  static const int fallbackUserId = 3;

  /// Private constructor — this class is a namespace.
  const MyCoursesConstants._();
}
