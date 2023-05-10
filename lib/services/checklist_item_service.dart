import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_apps/models/action_checklist_model.dart';
import 'package:my_apps/services/user_service.dart';
import 'package:my_apps/utils/constans.dart';

import '../models/checklist_item_model.dart';

class ChecklistItemService {
  Future<dynamic> get({required int id}) async {
    try {
      String token = await UserService().getToken();
      final response = await http.get(
        Uri.parse('${baseUrl}checklist/$id/item'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        return CheckListItemsModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getDetail({required int id, required int idItem}) async {
    try {
      String token = await UserService().getToken();
      final response = await http.get(
        Uri.parse('${baseUrl}checklist/$id/item/$idItem'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        return CheckListItemsModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> save({required int id, required String itemName}) async {
    try {
      String token = await UserService().getToken();
      var body = {"itemName": itemName};
      final response =
          await http.post(Uri.parse('${baseUrl}checklist/$id/item'),
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

  Future<dynamic> updateName(
      {required int id, required int idItem, required String itemName}) async {
    try {
      String token = await UserService().getToken();
      var body = {"itemName": itemName};
      final response = await http.put(
          Uri.parse('${baseUrl}checklist/$id/item/rename/$idItem'),
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

  Future<dynamic> updateStatus({required int id, required int idItem}) async {
    try {
      String token = await UserService().getToken();
      final response = await http.put(
        Uri.parse('${baseUrl}checklist/$id/item/$idItem'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      ActionCheckListsModel models =
          ActionCheckListsModel.fromJson(jsonDecode(response.body));

      if (models.errorMessage == null) {
        return models;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete({required int id, required int idItem}) async {
    try {
      String token = await UserService().getToken();
      final response = await http.delete(
        Uri.parse('${baseUrl}checklist/$id/item/$idItem'),
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
