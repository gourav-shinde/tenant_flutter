import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/models/add_bill.dart';
import 'package:tenant_manager/models/add_payment.dart';
import 'package:tenant_manager/models/tenant_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:tenant_manager/main.dart';

class add_bill_payment extends StatefulWidget {
  String token_saved;
  Tenant tenant_instance;
  bool _isbill;
  add_bill_payment(this.tenant_instance, this.token_saved, this._isbill);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return add_bill_state(tenant_instance, token_saved, _isbill);
  }
}

Future<AddBill> addBill(Tenant tenant_instance, String token_saved, String rent,String units, String perUnit, String water, String wifi) async {
  final String billUrl =
      "https://tenant-manager-arsenel.herokuapp.com/app/bill_views/" +
          tenant_instance.id.toString();
  String header = "TOKEN " + "$token_saved";
  final response = await http.post(billUrl, headers: {"Authorization": header}, body: {
    "rent": rent,
    "units": units,
    "price_per_unit": perUnit,
    "water_bill": water,
    "wifi_charge": wifi,
  });

  if (response.statusCode <=202) {
    final String responseString = response.body;
    print(response.body);
    return addBillFromJson(responseString);
  }else{
    print("Error");
  }
}

Future<AddPayment> addPayment(Tenant tenant_instance, String token_saved, String amount) async {
  final String payUrl =
      "https://tenant-manager-arsenel.herokuapp.com/app/payment_views/" +
          tenant_instance.id.toString();
  String header = "TOKEN " + "$token_saved";
  final response2 = await http.post(payUrl, headers: {"Authorization": header}, body: {
    "amount":amount,
  });

  if (response2.statusCode <=202) {
    final String response2String = response2.body;
    print(response2.body);
    return addPaymentFromJson(response2String);
  }else{
    print("Error");
  }
}


class add_bill_state extends State<add_bill_payment> {
  String token_saved;
  Tenant tenant_instance;
  bool _isbill;
  String _error;
  add_bill_state(this.tenant_instance, this.token_saved, this._isbill);
  final TextEditingController rentController = TextEditingController();
  final TextEditingController unitnameController = TextEditingController();
  final TextEditingController price_pernameController = TextEditingController();
  final TextEditingController water_Controller = TextEditingController();
  final TextEditingController wifiController = TextEditingController();
  final TextEditingController ammountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: _isbill
            ? AppBar(
                title: Text("Add bill to " + tenant_instance.name),
              )
            : AppBar(
                title: Text("Add Payment to " + tenant_instance.name),
              ),
        body: _isbill
            ? Container(
                padding: EdgeInsets.all(35),
                child: ListView(
                  children: [
                    TextField(
                      controller: rentController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.attach_money),
                          labelText: "Rent",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: unitnameController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.electrical_services),
                          labelText: "Electricity units",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: price_pernameController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lightbulb),
                          labelText: "Price per units",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: water_Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.water_damage_outlined),
                          labelText: "Water bill",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: wifiController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.wifi),
                          labelText: "Wifi charges",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () async{
                        final String rent =rentController.text;
                        final String units =unitnameController.text;
                        final String per_unit =price_pernameController.text;
                        final String water =water_Controller.text;
                        final String wifi =wifiController.text;

                        if (rent!=''&&units!=''&&per_unit!=''&&water!=''&&wifi!='') {
                          final AddBill add = await addBill(tenant_instance, token_saved, rent, units, per_unit, water, wifi);
                          Navigator.pop(context);
                        }else{
                          print("error");
                          setState(() {
                            _error="error";
                          });
                          
                        }
                        
                      },
                      child: Text("Create Bill"),
                    ),
                    _error == null ? Container() : Text("All fields must be filled"),
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.all(35),
                child: ListView(
                  children: [
                    TextField(
                      controller: ammountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.attach_money),
                          labelText: "Amount",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () async{
                        final String amount=ammountController.text;

                        if (amount!='') {
                          final AddPayment pay= await addPayment(tenant_instance, token_saved, amount);
                          Navigator.pop(context);
                        }else{
                          print("error");
                          setState(() {
                             _error="error";
                          });
                        }
                        
                      },
                      child: Text("Add Payment"),
                    ),
                    _error == null ? Container() : Text("All fields must be filled"),
                  ],
                ),
              ));
  }
}
