import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import '../failure/app_failure.dart';
import 'local_storage.dart';
import '../network/result.dart';

/// Implementation of [LocalStorage] using SharedPreferences
@LazySingleton(as: LocalStorage)
class SharedPrefsImpl implements LocalStorage {

  /// Creates a [SharedPrefsImpl] instance
  const SharedPrefsImpl(this._prefs);
  final SharedPreferences _prefs;

  /// Creates an instance by getting SharedPreferences
  static Future<SharedPrefsImpl> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefsImpl(prefs);
  }

  @override
  Future<Result<T?>> get<T>(String key) async {
    try {
      final value = _prefs.get(key);
      if (value == null) {
        return Result.success<T?>(null);
      }

      // Type conversion logic
      if (T == String) {
        return Result.success(value as T);
      } else if (T == int) {
        return Result.success(value as T);
      } else if (T == double) {
        return Result.success(value as T);
      } else if (T == bool) {
        return Result.success(value as T);
      } else if (T == List<String>) {
        return Result.success(value as T);
      } else {
        // For custom objects, you would need to deserialize
        // This is a basic implementation - for complex objects use Hive or other solutions
        throw UnimplementedError('Type $T not supported for direct retrieval from SharedPreferences');
      }
    } catch (e, stackTrace) {
      return Result.failure(
        CacheFailure(
          message: 'Failed to get value for key: $key',
          key: key,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getAll() async {
    final keys = _prefs.getKeys();
    final result = <String, dynamic>{};
    for (final key in keys) {
      // Note: This only works for primitive types
      result[key] = _prefs.get(key);
    }
    return result;
  }

  @override
  Future<Result<bool>> set<T>(String key, T value) async {
    try {
      // Type-specific storage
      if (value is String) {
        final success = await _prefs.setString(key, value);
        return Result.success(success);
      } else if (value is int) {
        final success = await _prefs.setInt(key, value);
        return Result.success(success);
      } else if (value is double) {
        final success = await _prefs.setDouble(key, value);
        return Result.success(success);
      } else if (value is bool) {
        final success = await _prefs.setBool(key, value);
        return Result.success(success);
      } else if (value is List<String>) {
        final success = await _prefs.setStringList(key, value);
        return Result.success(success);
      } else {
        // For custom objects, serialize to JSON string first
        throw UnimplementedError('Type $T not supported for direct storage in SharedPreferences');
      }
    } catch (e, stackTrace) {
      return Result.failure(
        CacheFailure(
          message: 'Failed to set value for key: $key',
          key: key,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Result<bool>> remove(String key) async {
    try {
      final success = await _prefs.remove(key);
      return Result.success(success);
    } catch (e, stackTrace) {
      return Result.failure(
        CacheFailure(
          message: 'Failed to remove key: $key',
          key: key,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Result<bool>> clear() async {
    try {
      final success = await _prefs.clear();
      return Result.success(success);
    } catch (e, stackTrace) {
      return Result.failure(
        CacheFailure(
          message: 'Failed to clear storage',
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    return _prefs.containsKey(key);
  }

  @override
  Future<Set<String>> getKeys() async {
    return _prefs.getKeys();
  }

  @override
  Future<void> dispose() async {
    // SharedPreferences doesn't need explicit disposal
  }
}
