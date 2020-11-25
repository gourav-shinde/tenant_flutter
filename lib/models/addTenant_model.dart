// To parse this JSON data, do
//
//     final addTenant = addTenantFromJson(jsonString);

import 'dart:convert';

AddTenant addTenantFromJson(String str) => AddTenant.fromJson(json.decode(str));

String addTenantToJson(AddTenant data) => json.encode(data.toJson());

class AddTenant {
    AddTenant({
        this.id,
        this.name,
        this.mobileNo,
        this.email,
        this.startDate,
        this.deposite,
        this.roomName,
        this.balance,
        this.active,
    });

    int id;
    String name;
    String mobileNo;
    String email;
    DateTime startDate;
    int deposite;
    String roomName;
    int balance;
    bool active;

    factory AddTenant.fromJson(Map<String, dynamic> json) => AddTenant(
        id: json["id"],
        name: json["name"],
        mobileNo: json["mobile_no"],
        email: json["email"],
        startDate: DateTime.parse(json["start_date"]),
        deposite: json["deposite"],
        roomName: json["room_name"],
        balance: json["balance"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile_no": mobileNo,
        "email": email,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "deposite": deposite,
        "room_name": roomName,
        "balance": balance,
        "active": active,
    };
}
