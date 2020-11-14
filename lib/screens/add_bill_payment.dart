import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/models/tenant_model.dart';

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

class add_bill_state extends State<add_bill_payment> {
  String token_saved;
  Tenant tenant_instance;
  bool _isbill;
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
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_box),
                          labelText: "rent",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_box),
                          labelText: "Electricity units",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_box),
                          labelText: "price per units",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_box),
                          labelText: "water bill",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_box),
                          labelText: "wifi charges",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text("Create Bill"),
                    ),
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.all(35),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_box),
                          labelText: "Amount",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text("Add Payment"),
                    )
                  ],
                ),
              ));
  }
}
