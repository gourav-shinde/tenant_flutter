import 'dart:convert';

class Bill {
  int id;
  String date;
  int rent;
  int electric_units;
  int price_per_unit;
  int electric_total;
  int water_bill;
  int wifi_charge;
  int total;

  Bill(this.id, this.date, this.rent, this.electric_total, this.water_bill,
      this.wifi_charge, this.total, this.electric_units, this.price_per_unit);
}
