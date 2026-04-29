import 'dart:async';

import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// Abstract interface for local storage operations
/// 
/// Implementations can use SharedPreferences, Hive, or any other storage mechanism
abstract class LocalStorage {
  /// Retrieves a value by [key]
  /// Returns [CacheFailure] if key doesn't exist or deserialization fails
  Future<Result<T?>> get<T>(String key);

  /// Retrieves all stored values
  Future<Map<String, dynamic>> getAll();

  /// Saves a value with the given [key]
  /// Returns `true` if successful, `false` otherwise
  Future<Result<bool>> set<T>(String key, T value);

  /// Removes a value by [key]
  /// Returns `true` if the value was removed, `false` otherwise
  Future<Result<bool>> remove(String key);

  /// Removes all values
  /// Returns `true` if successful, `false` otherwise
  Future<Result<bool>> clear();

  /// Checks if a key exists
  Future<bool> containsKey(String key);

  /// Gets all keys
  Future<Set<String>> getKeys();

  /// Disposes the storage instance
  Future<void> dispose();
}
