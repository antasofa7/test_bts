import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_apps/models/action_checklist_model.dart';
import 'package:my_apps/services/user_service.dart';
import 'package:my_apps/utils/constans.dart';

import '../models/checklist_model.dart';

class ChecklistService {
  Future<dynamic> get() async {
    try {
      String token = await UserService().getToken();
      final response = await http.get(
        Uri.parse('${baseUrl}checklist'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        return CheckListsModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> save({required String name}) async {
    try {
      String token = await UserService().getToken();
      var body = {"name": name};
      final response = await http.post(Uri.parse('${baseUrl}checklist'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(body));

      ActionCheckListsModel models =
          ActionCheckListsModel.fromJson(jsonDecode(response.body));

      if (models.errorMessage == null) {
        return models;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete({required int id}) async {
    try {
      String token = await UserService().getToken();
      final response = await http.delete(
        Uri.parse('${baseUrl}checklist/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      ActionCheckListsModel models =
          ActionCheckListsModel.fromJson(jsonDecode(response.body));

      if (models.errorMessage == null) {
        return models;
      } else if (models.statusCode == 400) {
        return models;
      }
    } catch (e) {
      rethrow;
    }
  }
}
