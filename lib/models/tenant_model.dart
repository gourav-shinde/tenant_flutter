import 'dart:convert';

class Tenant {
  int id;
  String name;
  String mobileNo;
  String startDate;
  int deposite;
  String roomName;
  int balance;
  String email;

  Tenant(
    this.id,
    this.name,
    this.mobileNo,
    this.startDate,
    this.deposite,
    this.roomName,
    this.balance,
    this.email,
  );
}
