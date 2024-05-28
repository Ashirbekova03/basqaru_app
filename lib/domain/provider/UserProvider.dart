import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {

  final tokenKey = "auth_token";
  final notificationKey = "notification_key";
  final langKey = "lang_key";

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString(tokenKey);
    } on Exception catch(_) {
      return null;
    }
  }

  Future<dynamic> setAuthToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    if (token != null) {
      await prefs.setString(tokenKey, token);
    } else {
      await prefs.remove(tokenKey);
    }
  }

  Future<String> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString(langKey) ?? "en";
    } on Exception catch(_) {
      return "en";
    }
  }

  Future<dynamic> setLang(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(langKey, lang);
  }

  Future<bool> getNotification() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getBool(notificationKey) ?? true;
    } on Exception catch(_) {
      return true;
    }
  }

  Future<dynamic> setNotification(bool isOn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(notificationKey, isOn);
  }

}

