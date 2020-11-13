import 'dart:convert';

AddTenant addTenantFromJson(String str) => AddTenant.fromJson(json.decode(str));

String addTenantToJson(AddTenant data) => json.encode(data.toJson());

class AddTenant {
  AddTenant({
    this.id,
    this.name,
    this.mobileNo,
    this.startDate,
    this.deposite,
    this.roomName,
    this.balance,
  });

  int id;
  String name;
  String mobileNo;
  DateTime startDate;
  int deposite;
  String roomName;
  int balance;

  factory AddTenant.fromJson(Map<String, dynamic> json) => AddTenant(
    id: json["id"],
    name: json["name"],
    mobileNo: json["mobile_no"],
    startDate: DateTime.parse(json["start_date"]),
    deposite: json["deposite"],
    roomName: json["room_name"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile_no": mobileNo,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "deposite": deposite,
    "room_name": roomName,
    "balance": balance,
  };
}