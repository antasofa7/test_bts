import 'package:equatable/equatable.dart';

class CheckListItemsModel extends Equatable {
  final int? statusCode;
  final String? message;
  final dynamic errorMessage;
  final List<DataCheckListItem>? data;

  const CheckListItemsModel({
    this.statusCode,
    this.message,
    this.errorMessage,
    this.data,
  });

  factory CheckListItemsModel.fromJson(Map<String, dynamic> json) =>
      CheckListItemsModel(
        statusCode: json["statusCode"],
        message: json["message"],
        errorMessage: json["errorMessage"],
        data: json["data"] == null
            ? []
            : List<DataCheckListItem>.from(
                json["data"]!.map((x) => DataCheckListItem.fromJson(x))),
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

class DataCheckListItem extends Equatable {
  final int? id;
  final String? name;
  final List? items;
  final bool? itemCompletionStatus;

  const DataCheckListItem({
    this.id,
    this.name,
    this.items,
    this.itemCompletionStatus,
  });

  factory DataCheckListItem.fromJson(Map<String, dynamic> json) =>
      DataCheckListItem(
        id: json["id"],
        name: json["name"],
        items: json["items"] ?? [],
        itemCompletionStatus: json["itemCompletionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "items": items,
        "itemCompletionStatus": itemCompletionStatus,
      };

  @override
  List<Object?> get props => [
        "id: $id",
        "name: $name",
        "items: $items",
        "itemCompletionStatus: $itemCompletionStatus",
      ];
}
