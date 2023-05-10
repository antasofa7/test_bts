import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final int? statusCode;
  final String? message;
  final String? errorMessage;
  final Data? data;

  const AuthModel({
    this.statusCode,
    this.message,
    this.errorMessage,
    this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        statusCode: json["statusCode"],
        message: json["message"],
        errorMessage: json["errorMessage"] ?? '',
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
  final String? token;

  const Data({
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };

  @override
  List<Object?> get props => ["token: $token"];
}
