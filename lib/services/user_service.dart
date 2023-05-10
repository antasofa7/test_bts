import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  late final SharedPreferences prefs;

  static const String token = 'TOKEN';

  Future<void> setToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(token, value);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(token) ?? '';
  }

  Future<bool?> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    var user = prefs.containsKey(token);
    return user;
  }

  Future<void> removeLocalUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(token);
  }
}
