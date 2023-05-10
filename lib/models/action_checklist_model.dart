import 'package:equatable/equatable.dart';

class ActionCheckListsModel extends Equatable {
  final int? statusCode;
  final String? message;
  final dynamic errorMessage;
  final Data? data;

  const ActionCheckListsModel({
    this.statusCode,
    this.message,
    this.errorMessage,
    this.data,
  });

  factory ActionCheckListsModel.fromJson(Map<String, dynamic> json) =>
      ActionCheckListsModel(
        statusCode: json["statusCode"],
        message: json["message"],
        errorMessage: json["errorMessage"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "errorMessage": errorMessage,
        "data": data?.toJson(),
      };

  @override
  List<Object?> get props => [
        "statusCode: $statusCode",
        "message: $message",
        "errorMessage: $errorMessage",
        "data: $data",
      ];
}

class Data extends Equatable {
  final int? id;
  final String? name;
  final dynamic items;
  final bool? checklistCompletionStatus;

  const Data({
    this.id,
    this.name,
    this.items,
    this.checklistCompletionStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        items: json["items"],
        checklistCompletionStatus: json["checklistCompletionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "items": items,
        "checklistCompletionStatus": checklistCompletionStatus,
      };

  @override
  List<Object?> get props => [
        "id: $id",
        "name: $name",
        "items: $items",
        "checklistCompletionStatus: $checklistCompletionStatus",
      ];
}
