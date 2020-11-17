import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/models/bill_model.dart';

class billDetail extends StatefulWidget {
  Bill bill_instance;
  billDetail(this.bill_instance);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return billDetailState(bill_instance);
  }
}

class billDetailState extends State<billDetail> {
  Bill bill_instance;
  billDetailState(this.bill_instance);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Detail"),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Container(
          child: Column(
            children: [
              Text("Date : " + bill_instance.date),
              SizedBox(
                height: 10,
              ),
              Text("Rent : " + bill_instance.rent.toString()),
              SizedBox(
                height: 10,
              ),
              Text("Electric units : "),
              SizedBox(
                height: 10,
              ),
              Text("Price per Unit : "),
              SizedBox(
                height: 10,
              ),
              Text("Electric Total : " +
                  bill_instance.electric_total.toString()),
              SizedBox(
                height: 10,
              ),
              Text("Water bill: " + bill_instance.water_bill.toString()),
              SizedBox(
                height: 10,
              ),
              Text("Wifi Charges : " + bill_instance.wifi_charge.toString()),
              SizedBox(
                height: 10,
              ),
              Text("Wifi Charges : " + bill_instance.total.toString()),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
