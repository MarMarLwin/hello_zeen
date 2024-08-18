import 'package:shared_preferences/shared_preferences.dart';

import 'app_constant.dart';

class LocalStorageManager {
  LocalStorageManager();
  static Future<String> getAccessToken() async {
    final Future<SharedPreferences> preference =
        SharedPreferences.getInstance();

    final SharedPreferences prefs = await preference;

    var accessToken = prefs.getString(AppConstant.accessToken);

    return accessToken ?? '';
  }

  static Future<void> savePreferenceData(String key, String value) async {
    final Future<SharedPreferences> preference =
        SharedPreferences.getInstance();

    final SharedPreferences prefs = await preference;

    prefs.setString(key, value);
  }

  static Future<String?> getPreferenceData(String key) async {
    final Future<SharedPreferences> preference =
        SharedPreferences.getInstance();

    final SharedPreferences prefs = await preference;

    var value = prefs.getString(key);
    return value;
  }

  static Future<void> clearTokens() async {
    final Future<SharedPreferences> preference =
        SharedPreferences.getInstance();

    final SharedPreferences prefs = await preference;

    prefs.setString(AppConstant.accessToken, '');
  }
}
