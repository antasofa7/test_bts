import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
  final int? statusCode;
  final String? message;
  final String? errorMessage;
  final dynamic data;

  const RegisterModel({
    this.statusCode,
    this.message,
    this.errorMessage,
    this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        statusCode: json["statusCode"],
        message: json["message"],
        errorMessage: json["errorMessage"] ?? '',
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "errorMessage": errorMessage,
        "data": data,
      };

  @override
  List<Object?> get props => [
        "statusCode: $statusCode",
        "message: $message",
        "errorMessage: $errorMessage",
        "data: $data",
      ];
}
