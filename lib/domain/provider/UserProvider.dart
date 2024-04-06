import 'package:shared_preferences/shared_preferences.dart';

class UserProvider {

  final tokenKey = "auth_token";

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

}

