import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/home_model.dart';
/// Implementation of [HomeRepository]
/// 
/// This class orchestrates data operations by coordinating
/// between remote data source and local cache using Hive.
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource _remoteDatasource;
  final Box<String> _cacheBox;
  static const String _cacheKey = 'home_data';
  
  HomeRepositoryImpl({
    required HomeRemoteDatasource remoteDatasource,
    required Box<String> cacheBox,
  })  : _remoteDatasource = remoteDatasource,
        _cacheBox = cacheBox;
  
  @override
  Future<HomeEntity> getHomeData() async {
    try {
      // Try to get from cache first
      final cachedData = _cacheBox.get(_cacheKey);
      if (cachedData != null) {
        final cachedModel = HomeModel.fromJson(Map<String, dynamic>.from(jsonDecode(cachedData)));
        if (!cachedModel.isCached) {
          return cachedModel.toEntity();
        }
      }
      
      // Fetch from network
      final response = await _remoteDatasource.getHomeData();
      final homeModel = HomeModel(
        id: response.id,
        title: response.title,
        subtitle: response.subtitle,
        imageUrl: response.imageUrl,
        items: response.items,
        totalCount: response.totalCount,
        lastUpdated: response.lastUpdated,
        isCached: false,
      );
      
      // Cache the result
      await _cacheBox.put(_cacheKey, jsonEncode(homeModel.toJson()));
      
      return homeModel.toEntity();
      } on DioError catch (e) {
        // Try to return cached data on network failure
        final cachedJson = _cacheBox.get(_cacheKey);
        if (cachedJson != null) {
          final cachedModel = HomeModel.fromJson(jsonDecode(cachedJson));
          return cachedModel.toEntity();
        }
        throw Exception('Failed to fetch home data: ${e.message}');
      } catch (e) {
        throw Exception('Unexpected error: $e');
      }
    }
    
    @override
    Future<HomeEntity> getHomeDetail(String id) async {
      try {
        final response = await _remoteDatasource.getHomeDetail(id);
        final homeModel = HomeModel(
          id: response.id,
          title: response.title,
          subtitle: response.subtitle,
          imageUrl: response.imageUrl,
          items: response.items,
          totalCount: response.totalCount,
          lastUpdated: response.lastUpdated,
          isCached: false,
        );
        
        // Cache the detail
        await _cacheBox.put('home_detail_$id', jsonEncode(homeModel.toJson()));
        
        return homeModel.toEntity();
      } on DioError catch (e) {
       // Try cached data
       final cachedJson = _cacheBox.get('home_detail_$id');
       if (cachedJson != null) {
         final cachedModel = HomeModel.fromJson(jsonDecode(cachedJson));
         return cachedModel.toEntity();
       }
       throw Exception('Failed to fetch home detail: ${e.message}');
    }
  }
  
  @override
  Future<bool> hasCachedData() async {
    return _cacheBox.containsKey(_cacheKey);
  }
  
  @override
  Future<void> clearCache() async {
    await _cacheBox.delete(_cacheKey);
    // Also clear detail caches
    final keys = _cacheBox.keys
        .where((k) => k.toString().startsWith('home_detail_'))
        .toList();
    await _cacheBox.deleteAll(keys);
  }
  
  @override
  Stream<HomeEntity> watchHomeData() async* {
    // Watch the cache box for changes
    yield* _cacheBox.watch(key: _cacheKey).asyncMap((event) {
      final jsonString = event.value;
      if (jsonString != null) {
        final model = HomeModel.fromJson(jsonDecode(jsonString));
        return model.toEntity();
      }
      throw Exception('No cached data available');
    });
  }
}
