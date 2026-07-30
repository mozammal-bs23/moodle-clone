/// User-facing strings for the login flow.
///
/// Kept in one file so the login cubit, repository, and tests can share
/// them without duplicating literal strings or reaching into each other's
/// private scope.
library;

/// Moodle's documented errorcode for "wrong username or password".
const String loginInvalidLoginErrorcode = 'invalidlogin';

/// Shown when the server reports `invalidlogin`. Translates the technical
/// code into an explicit sentence so the user knows which field is wrong.
const String loginInvalidLoginUserMessage =
    'Incorrect username or password. Please try again.';

/// Shown when the server returns 200 with neither `token` nor an
/// `error`/`message`/`errorcode` — i.e. an unknown shape.
const String loginServerMissingTokenMessage =
    'Server returned a success response without a token';

/// Shown when both username and password are empty on submit. Local to the
/// feature because the cubit already owns the same check.
const String loginEmptyCredentialsMessage =
    'Please enter both username and password';

/// Shown when the server takes too long to respond.
const String loginNetworkErrorTimeout =
    'The server took too long to respond. Please try again.';

/// Shown when the device cannot reach the server at all.
const String loginNetworkErrorUnreachable =
    'Could not reach the server. Check your connection and try again.';

/// Shown when the request was cancelled (typically because the widget
/// unmounted mid-flight).
const String loginNetworkErrorCancelled = 'Request was cancelled.';

/// Shown when TLS/SSL fails.
const String loginNetworkErrorBadCertificate =
    'Secure connection failed. Please try again later.';

/// Shown for HTTP 429 (rate limiting).
const String loginNetworkErrorRateLimited =
    'Too many login attempts. Please wait a moment and try again.';

/// Shown for any HTTP 5xx response.
const String loginNetworkErrorServerUnavailable =
    'The server is currently unavailable. Please try again later.';

/// Fallback for HTTP errors that are neither 429 nor 5xx.
const String loginNetworkErrorOther = 'Network error. Please try again.';
