import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/models/bill_model.dart';
import 'package:tenant_manager/models/payment_model.dart';

import 'package:tenant_manager/models/tenant_model.dart';

class Tenant_detail extends StatefulWidget {
  Tenant tenant_instance;
  String token_saved;
  Tenant_detail(this.tenant_instance, this.token_saved);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return tenant_detail_state(tenant_instance, token_saved);
  }
}

// Awaiting lists

Future<List<Bill>> createBillList(
    Tenant tenant_instance, String token_saved) async {
  final String LoginUrl =
      "https://tenant-manager-arsenel.herokuapp.com/app/bill_views/" +
          tenant_instance.id.toString();
  print("TOKEN $token_saved hello");
  String header = "TOKEN " + "$token_saved";
  print(header);
  final response = await http.get(LoginUrl, headers: {"Authorization": header});
  var JsonData = jsonDecode(response.body);
  print(JsonData);
  print(JsonData["bills"]);
  List<Bill> bills = [];
  for (var u in JsonData["bills"]) {
    Bill obj = Bill(u["id"], u["date"], u["rent"], u["electric_total"],
        u["water_bill"], u["wifi_charge"], u["total"]);
    bills.add(obj);
  }
  return bills;
}

Future<List<Payment>> createPayemntList(
    Tenant tenant_instance, String token_saved) async {
  final String LoginUrl =
      "https://tenant-manager-arsenel.herokuapp.com/app/payment_views/" +
          tenant_instance.id.toString();
  print("TOKEN $token_saved hello");
  String header = "TOKEN " + "$token_saved";
  print(header);
  final response = await http.get(LoginUrl, headers: {"Authorization": header});
  var JsonData = jsonDecode(response.body);
  print(JsonData);
  print(JsonData["payments"]);
  List<Payment> payments = [];
  for (var u in JsonData["payments"]) {
    Payment obj = Payment(u["id"], u["date"], u["amount"]);
    payments.add(obj);
  }
  return payments;
}

class tenant_detail_state extends State<Tenant_detail> {
  bool _isbill = true;
  Tenant tenant_instance;
  String token_saved;
  tenant_detail_state(this.tenant_instance, this.token_saved);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(tenant_instance.name),
        actions: [
          FlatButton(
              onPressed: () {
                print("edit pressed");
              },
              child: Icon(Icons.edit))
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                color: Colors.grey[100],
                child: Column(
                  children: [
                    Text(
                      tenant_instance.name,
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      "Mobile No : " + tenant_instance.mobileNo.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(tenant_instance.roomName),
                    Text("Deposite : " + tenant_instance.deposite.toString()),
                    Text("Check in : " + tenant_instance.startDate.toString()),
                    tenant_instance.balance >= 0
                        ? Text(
                            tenant_instance.balance.toString(),
                            style: TextStyle(color: Colors.green, fontSize: 25),
                          )
                        : Text(
                            tenant_instance.balance.toString(),
                            style: TextStyle(color: Colors.red, fontSize: 25),
                          ),
                  ],
                ),
              ),
            ),
            _isbill
                ? Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              print("Bills");
                              setState(() {
                                _isbill = true;
                              });
                            },
                            child: Text(
                              "Bills",
                              style: TextStyle(fontSize: 17),
                            ),
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              print("Payments");
                              setState(() {
                                _isbill = false;
                              });
                            },
                            child: Text(
                              "Payments",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: FlatButton(
                              onPressed: () {
                                print("Bills");
                                setState(() {
                                  _isbill = true;
                                  // tenant_instance.balance = 50;
                                });
                              },
                              child: Text(
                                "Bills",
                                style: TextStyle(fontSize: 17),
                              )),
                        ),
                        Expanded(
                          child: FlatButton(
                            color: Colors.blue,
                            onPressed: () {
                              print("Payments");
                              setState(() {
                                _isbill = false;
                              });
                            },
                            child: Text(
                              "Payments",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

            // list body

            _isbill
                ? Container(
                    height: 400,
                    color: Colors.grey[50],
                    child: FutureBuilder(
                      future: createBillList(tenant_instance, token_saved),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: Text("Loading"),
                            ),
                          );
                        } else
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title:
                                    Text(snapshot.data[index].date.toString()),
                                trailing:
                                    Text(snapshot.data[index].total.toString()),
                                onTap: () {
                                  print("pressed");
                                },
                              );
                            },
                          );
                      },
                    ),
                  )
                : Container(
                    height: 400,
                    color: Colors.grey[50],
                    child: FutureBuilder(
                      future: createPayemntList(tenant_instance, token_saved),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: Text("Loading"),
                            ),
                          );
                        } else
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                    snapshot.data[index].datetime.toString()),
                                trailing: Text(
                                    snapshot.data[index].amount.toString()),
                                onTap: () {
                                  print("pressed");
                                },
                              );
                            },
                          );
                      },
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("add");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
