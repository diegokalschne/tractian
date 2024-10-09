import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static SharedPreferences? _instance;

  static Future<SharedPreferences> _getPreferences() async {
    _instance ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  static Future<void> saveString(String key, String value, {String suffix = ''}) async {
    final prefs = await _getPreferences();
    await prefs.setString(key + suffix, value);
  }

  static Future<String?> getString(String key, {String suffix = ''}) async {
    final prefs = await _getPreferences();
    return prefs.getString(key + suffix);
  }

  static Future<void> saveInt(String key, int value, {String suffix = ''}) async {
    final prefs = await _getPreferences();
    await prefs.setInt(key + suffix, value);
  }

  static Future<int?> getInt(String key, {String suffix = ''}) async {
    final prefs = await _getPreferences();
    return prefs.getInt(key + suffix);
  }

  static Future<void> saveBool(String key, bool value, {String suffix = ''}) async {
    final prefs = await _getPreferences();
    await prefs.setBool(key + suffix, value);
  }

  static Future<bool?> getBool(String key, {String suffix = ''}) async {
    final prefs = await _getPreferences();
    return prefs.getBool(key + suffix);
  }

  static Future<bool> hasKey(String key, {String suffix = ''}) async {
    final prefs = await _getPreferences();
    return prefs.containsKey(key + suffix);
  }

  static Future<void> remove(String key, {String suffix = ''}) async {
    final prefs = await _getPreferences();
    await prefs.remove(key + suffix);
  }

  static Future<void> saveStringList(String key, List<String> value, {String suffix = ''}) async {
    final prefs = await _getPreferences();
    await prefs.setStringList(key + suffix, value);
  }

  static Future<List<String>> getStringList(String key, {String suffix = ''}) async {
    final prefs = await _getPreferences();
    return prefs.getStringList(key + suffix) ?? List.empty();
  }
}
