// To parse this JSON data, do
//
//     final changeUser = changeUserFromJson(jsonString);

import 'dart:convert';

ChangeUser changeUserFromJson(String str) => ChangeUser.fromJson(json.decode(str));

String changeUserToJson(ChangeUser data) => json.encode(data.toJson());

class ChangeUser {
    ChangeUser({
        this.status,
    });

    String status;

    factory ChangeUser.fromJson(Map<String, dynamic> json) => ChangeUser(
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
    };
}
