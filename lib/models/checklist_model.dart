import 'package:equatable/equatable.dart';

class CheckListsModel extends Equatable {
  final int? statusCode;
  final String? message;
  final dynamic errorMessage;
  final List<DataCheckList>? data;

  const CheckListsModel({
    this.statusCode,
    this.message,
    this.errorMessage,
    this.data,
  });

  factory CheckListsModel.fromJson(Map<String, dynamic> json) =>
      CheckListsModel(
        statusCode: json["statusCode"],
        message: json["message"],
        errorMessage: json["errorMessage"],
        data: json["data"] == null
            ? []
            : List<DataCheckList>.from(
                json["data"]!.map((x) => DataCheckList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "errorMessage": errorMessage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        "statusCode: $statusCode",
        "message: $message",
        "errorMessage: $errorMessage",
        "data: $data",
      ];
}

class DataCheckList extends Equatable {
  final int? id;
  final String? name;
  final List? items;
  final bool? checklistCompletionStatus;

  const DataCheckList({
    this.id,
    this.name,
    this.items,
    this.checklistCompletionStatus,
  });

  factory DataCheckList.fromJson(Map<String, dynamic> json) => DataCheckList(
        id: json["id"],
        name: json["name"],
        items: json["items"] ?? [],
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
