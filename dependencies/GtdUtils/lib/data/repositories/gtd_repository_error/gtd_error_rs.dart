import 'dart:convert';

class ErrorRs {
  ErrorRs({
    this.code,
    this.id,
    this.message,
  });

  String? code;
  String? id;
  String? message;

  factory ErrorRs.fromRawJson(dynamic str) => ErrorRs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorRs.fromJson(Map<String, dynamic> json) => ErrorRs(
        code: json["code"],
        id: json["id"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "id": id,
        "message": message,
      };
}
