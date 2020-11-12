import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTenantView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddTenantViewState();
  }
}

class AddTenantViewState extends State<AddTenantView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController depositeController = TextEditingController();
  final TextEditingController roomcontroller = TextEditingController();
  final TextEditingController dateIscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Tenant"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_box),
                  labelText: "username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_box),
                  labelText: "Mobile no",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: depositeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_box),
                  labelText: "Deposite",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            // Text(_dateTime == null ? "Nothing selected" : _dateTime.toString()),
            DateTimeField(
              format: DateFormat("dd-MM-yyyy"),
              // enabled: false,
              initialValue: DateTime.now(),
              controller: dateIscontroller,

              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_box),
                  labelText: "Date",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: roomcontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_box),
                  labelText: "Room Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
                child: Text("Create Tenant"),
                onPressed: () {
                  print("Create");
                  Navigator.pop(context);
                }),
            RaisedButton(
                child: Text("Cancel"),
                onPressed: () {
                  print("cancel");
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
