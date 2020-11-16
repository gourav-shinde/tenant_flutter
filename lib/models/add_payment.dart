// To parse this JSON data, do
//
//     final addPayment = addPaymentFromJson(jsonString);

import 'dart:convert';

AddPayment addPaymentFromJson(String str) => AddPayment.fromJson(json.decode(str));

String addPaymentToJson(AddPayment data) => json.encode(data.toJson());

class AddPayment {
    AddPayment({
        this.id,
        this.date,
        this.amount,
    });

    int id;
    DateTime date;
    int amount;

    factory AddPayment.fromJson(Map<String, dynamic> json) => AddPayment(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "amount": amount,
    };
}
