import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/addTenant_model.dart';
import 'package:http/http.dart' as http;

import 'logged_sandbox.dart';

class AddTenantView extends StatefulWidget {
  String Token_recieved;
  AddTenantView(this.Token_recieved);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddTenantViewState(Token_recieved);
  }
}

Future<AddTenant> addTenant(String name, String mobile, String depos, String room, String date,String Token_saved) async {
  print(Token_saved);
  final apiUrl = "https://tenant-manager-arsenel.herokuapp.com/app/tenant_views";
  String header = "TOKEN " + "$Token_saved";
  print(header);
  final addedResponse = await http.post(apiUrl,headers: {"Authorization": header}, body: {
    "name": name,
    "mobile_no": mobile,
    "start_date": date,
    "deposite": depos,
    "room_name": room,
  });

  if (addedResponse.statusCode <= 202) {
    final String addedString = addedResponse.body;

    return addTenantFromJson(addedString);
  } else {
    print(addedResponse.body);
  }
}

class AddTenantViewState extends State<AddTenantView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController depositeController = TextEditingController();
  final TextEditingController roomcontroller = TextEditingController();
  final TextEditingController dateIscontroller = TextEditingController();

  String Token_saved;
  AddTenantViewState(this.Token_saved);

  AddTenant _addTenant;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Tenant"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: ListView(
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
              format: DateFormat("yyyy-MM-dd"),
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
                onPressed: () async {
                  final String name = nameController.text;
                  final String mobile = mobileController.text;
                  final String deposite = depositeController.text;
                  final String date = dateIscontroller.text;
                  final String room_name = roomcontroller.text;
                  print(name);
                  print(mobile);
                  print(deposite);
                  print(date);
                  print(room_name);
                  final AddTenant added = await addTenant(name, mobile, deposite, room_name, date,Token_saved);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TenantView(Token_saved);
                  }));
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