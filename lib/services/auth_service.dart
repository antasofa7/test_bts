import 'dart:convert';

import 'package:my_apps/models/auth_model.dart';
import 'package:my_apps/models/register_model.dart';
import 'package:my_apps/services/user_service.dart';
import 'package:my_apps/utils/constans.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<dynamic> register(
      {required String email,
      required String password,
      required String username}) async {
    try {
      var body = {"email": email, "password": password, "username": username};

      final response = await http.post(Uri.parse('${baseUrl}register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        return RegisterModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        return RegisterModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> login(
      {required String username, required String password}) async {
    try {
      var body = {'username': username, 'password': password};

      var response = await http.post(Uri.parse('${baseUrl}login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        var model = AuthModel.fromJson(jsonDecode(response.body));
        UserService().setToken(model.data?.token! ?? '');
        return model;
      } else {
        return AuthModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    UserService().removeLocalUser();
  }
}
