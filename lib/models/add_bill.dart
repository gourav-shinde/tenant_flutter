// To parse this JSON data, do
//
//     final addBill = addBillFromJson(jsonString);

import 'dart:convert';

AddBill addBillFromJson(String str) => AddBill.fromJson(json.decode(str));

String addBillToJson(AddBill data) => json.encode(data.toJson());

class AddBill {
    AddBill({
        this.rent,
        this.units,
        this.pricePerUnit,
        this.waterBill,
        this.wifiCharge,
        this.total,
    });

    int rent;
    int units;
    int pricePerUnit;
    int waterBill;
    int wifiCharge;
    int total;

    factory AddBill.fromJson(Map<String, dynamic> json) => AddBill(
        rent: json["rent"],
        units: json["units"],
        pricePerUnit: json["price_per_unit"],
        waterBill: json["water_bill"],
        wifiCharge: json["wifi_charge"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "rent": rent,
        "units": units,
        "price_per_unit": pricePerUnit,
        "water_bill": waterBill,
        "wifi_charge": wifiCharge,
        "total": total,
    };
}
