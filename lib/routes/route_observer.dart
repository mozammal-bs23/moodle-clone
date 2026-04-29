import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// Custom route observer for tracking navigation events
/// Used for analytics, logging, and performance monitoring
class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  /// Creates a new instance of [AppRouteObserver]
  AppRouteObserver({Logger? logger}) : _logger = logger ?? Logger();

  final Logger _logger;

  /// Called when a new route has been pushed
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logRouteEvent('PUSH', route, previousRoute);
  }

  /// Called when a route has been popped
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logRouteEvent('POP', route, previousRoute);
  }

  /// Called when a route has been replaced
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null && oldRoute != null) {
      _logger.i(
        'Route replaced: ${_getRouteName(oldRoute)} -> '
        '${_getRouteName(newRoute)}',
      );
    }
  }

  /// Called when a route's popGesture [Navigator.popUntil] is started
  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    super.didStartUserGesture(route, previousRoute);
    _logger.i('User started gesture to pop: ${_getRouteName(route)}');
  }

  /// Called when a route's popGesture [Navigator.popUntil] is completed
  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    _logger.i('User stopped gesture on current route');
  }

  /// Log route navigation event
  void _logRouteEvent(
    String event,
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    final routeName = _getRouteName(route);
    final previousRouteName = previousRoute != null
        ? _getRouteName(previousRoute)
        : 'none';

    _logger.i('Route $event: $routeName (from: $previousRouteName)');
  }

  /// Extract route name from route settings
  String _getRouteName(Route<dynamic> route) {
    if (route is PageRoute) {
      return route.settings.name ?? 'unknown';
    }
    return route.runtimeType.toString();
  }
}
