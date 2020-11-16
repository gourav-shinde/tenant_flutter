// To parse this JSON data, do
//
//     final changePass = changePassFromJson(jsonString);

import 'dart:convert';

ChangePass changePassFromJson(String str) => ChangePass.fromJson(json.decode(str));

String changePassToJson(ChangePass data) => json.encode(data.toJson());

class ChangePass {
  ChangePass({
    this.status,
  });

  String status;

  factory ChangePass.fromJson(Map<String, dynamic> json) => ChangePass(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}