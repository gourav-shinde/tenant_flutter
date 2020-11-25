// To parse this JSON data, do
//
//     final editTenant = editTenantFromJson(jsonString);

import 'dart:convert';

EditTenant editTenantFromJson(String str) => EditTenant.fromJson(json.decode(str));

String editTenantToJson(EditTenant data) => json.encode(data.toJson());

class EditTenant {
    EditTenant({
        this.success,
    });

    String success;

    factory EditTenant.fromJson(Map<String, dynamic> json) => EditTenant(
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
    };
}
