import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/*
  CacheService is a special caching class that uses shared_preferences package to make use of caching responses from api or storing any configurations.
 */
class CacheService {
  // Generic setter
  static Future<void> setValue(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      // For JSON objects / maps / lists
      String jsonString = json.encode(value);
      await prefs.setString(key, jsonString);
    }
  }

  // Generic getter
  static Future<dynamic> getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);

    if (value != null) {
      try {
        // Try decoding JSON
        return json.decode(value);
      } catch (e) {
        // Not JSON, return as string
        return value;
      }
    }
    return null;
  }

  // Optional: remove a key
  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
