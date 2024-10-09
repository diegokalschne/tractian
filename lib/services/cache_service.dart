import 'dart:convert';

import '../models/errors/error_model.dart';
import 'shared_service.dart';

class CacheService {
  /// Function to store a cached value using SharedPreferences
  static Future<void> storeCache<T, K>(String key, dynamic data, {bool maintainData = false, T Function(Map)? factory, String suffixKey = '', int? page}) async {
    final suffix = _checkSuffixByKey(key, suffixKey: suffixKey);

    if (maintainData && factory == null) {
      throw ErrorModel('Informe uma factory quando maintainData = true');
    }

    // If it is checked to keep data, it first reads the data that was cached and then saves it.
    if (maintainData) {
      final originalData = await getCache<T, K>(key, factory!);

      if (originalData != null && originalData is List<T>) {
        originalData.addAll(data);

        data = originalData;
      }
    }

    String json = jsonEncode(data);

    await SharedService.saveString(key, json, suffix: suffix);
    await _saveDateHourLastCache(key, suffixKey: suffixKey);

    if (page != null) {
      await _savePageCache(key, page, suffixKey: suffixKey);
    }
  }

  /// Retrieves a cached value
  static Future<K?> getCache<T, K>(String key, T Function(Map) factory, {String suffixKey = ''}) async {
    final suffix = _checkSuffixByKey(key, suffixKey: suffixKey);

    final value = await SharedService.getString(key, suffix: suffix);

    if (value == null) return null;

    final jsonDecoded = jsonDecode(value);

    if (jsonDecoded is List) {
      return jsonDecoded.map((e) => factory(e)).toList() as K;
    } else if (jsonDecoded is Map) {
      return factory(jsonDecoded) as K;
    }

    return jsonDecoded;
  }

  /// Clear cache saved in a given key
  static Future<void> clearCache(String key, {String suffixKey = ''}) async {
    final suffix = _checkSuffixByKey(key, suffixKey: suffixKey);

    await SharedService.remove(key, suffix: suffix);
  }

  /// Retrieves the last time a given key was cached
  static Future<DateTime?> getLastDateHourCache(String key, {String suffixKey = ''}) async {
    final suffix = _checkSuffixByKey(key, suffixKey: suffixKey);

    key = '${key}_hour_last_cache';

    final lastCache = await SharedService.getInt(key, suffix: suffix);

    if (lastCache == null) return null;

    return DateTime.fromMillisecondsSinceEpoch(lastCache);
  }

  /// Checks whether information can be read from the cache.
  ///
  ///Information can be read if it was last saved in the cache within an hour.
  static Future<bool> canGetCacheInfo(String key, {String suffixKey = ''}) async {
    final lastCacheDateHour = await getLastDateHourCache(key, suffixKey: suffixKey);
    if (lastCacheDateHour == null) return false;

    final now = DateTime.now();

    return now.difference(lastCacheDateHour).inHours < 1;
  }

  /// Retrieves the page number saved in cache
  static Future<int?> getLastPageCache(String key, {String suffixKey = ''}) async {
    final suffix = _checkSuffixByKey(key, suffixKey: suffixKey);

    key = '${key}_page_cache';

    return await SharedService.getInt(key, suffix: suffix);
  }

  static String _checkSuffixByKey(String key, {required String suffixKey}) {
    return suffixKey;
  }

  /// Saves the date and time the last cache was saved for a given key
  static Future<void> _saveDateHourLastCache(String key, {String suffixKey = ''}) async {
    final now = DateTime.now();

    final suffix = _checkSuffixByKey(key, suffixKey: suffixKey);

    key = '${key}_hour_last_cache';

    await SharedService.saveInt(key, now.millisecondsSinceEpoch, suffix: suffix);
  }

  /// Used to save the page number for caches where there is paging
  static Future<void> _savePageCache(String key, int page, {String suffixKey = ''}) async {
    final suffix = _checkSuffixByKey(key, suffixKey: suffixKey);

    key = '${key}_page_cache';

    await SharedService.saveInt(key, page, suffix: suffix);
  }
}
