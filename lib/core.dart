/// Core library for Flutter Boilerplate
/// 
/// This library exports all core functionality including:
/// - Base classes for BLoC pattern
/// - Network layer with Dio
/// - Local storage abstraction
/// - App theming
/// - Dependency injection
/// - Logging utilities
/// - Utility extensions and helpers
/// - Constants
/// - Failure types
library core;

// Base
export 'src/base/base_event.dart';
export 'src/base/base_state.dart';
export 'src/base/base_bloc.dart';

// Network
export 'src/network/result.dart';
export 'src/network/api_client.dart';
export 'src/network/interceptors/auth_interceptor.dart';
export 'src/network/interceptors/logging_interceptor.dart';

// Storage
export 'src/storage/local_storage.dart';
export 'src/storage/shared_prefs_impl.dart';

// Theme
export 'src/theme/app_theme.dart';

// Dependency Injection
export 'src/injection/di.dart';

// Logger
export 'src/logger/app_logger.dart';

// Utils - Extensions
export 'src/utils/extensions/string_extensions.dart';
export 'src/utils/extensions/context_extensions.dart';

// Utils - Utilities
export 'src/utils/utilities/validators.dart';
export 'src/utils/utilities/formatters.dart';

// Constants
export 'src/constants/app_constants.dart';

// Failures
export 'src/failure/app_failure.dart';
