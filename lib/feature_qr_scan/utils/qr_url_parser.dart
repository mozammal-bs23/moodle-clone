/// Pure-Dart helpers for turning the raw text from a QR code into a clean
/// base-URL string suitable for the "Connect to your Moodle site" form.
///
/// Kept dependency-free so it can be unit-tested without spinning up
/// Flutter. The scanner UI uses [extractBaseUrl] to decide whether a scan
/// is acceptable; if it returns `null`, the UI shows the "invalid QR" path
/// instead of bouncing the user back with garbage.
library;

/// Best-effort extraction of a base URL from a QR payload.
///
/// Rules:
///   1. Trim surrounding whitespace.
///   2. If the value contains `://`, keep scheme + host (and optional port)
///      only — drop the path, query string, and fragment.
///   3. If the value contains no `://` but starts with a domain-like
///      prefix (`moodle.`, `lms.`, `learn.`, `school.`, `campus.`,
///      `https://`, `http://`, `www.`) prepend `https://`.
///   4. Validate the result with [Uri.tryParse]. If it has no host or is
///      not a recognized scheme, return `null`.
///   5. Normalize: scheme lowercased, host lowercased, trailing slashes
///      removed.
///
/// Returns `null` when the payload is not a usable URL (e.g. plain text
/// like "hello world", emails with no host part, or whitespace-only
/// strings).
String? extractBaseUrl(String raw) {
  if (raw.isEmpty) return null;
  var input = raw.trim();
  if (input.isEmpty) return null;

  // If no scheme marker, try to prepend one when the input looks
  // domain-shaped.
  if (!input.contains('://')) {
    const domainHints = [
      'moodle.',
      'lms.',
      'learn.',
      'school.',
      'campus.',
      'www.',
      'https',
      'http',
    ];
    final lower = input.toLowerCase();
    final looksDomain = domainHints.any(lower.startsWith);
    if (looksDomain) {
      input = 'https://$input';
    } else {
      // Looks like plain text — no scheme and no recognizable host.
      return null;
    }
  }

  final parsed = Uri.tryParse(input);
  if (parsed == null) return null;
  if (parsed.host.isEmpty) return null;
  final scheme = parsed.scheme.toLowerCase();
  if (scheme != 'http' && scheme != 'https') return null;

  final host = parsed.host.toLowerCase();
  final port = parsed.hasPort && parsed.port != 0 ? ':${parsed.port}' : '';
  return '$scheme://$host$port';
}