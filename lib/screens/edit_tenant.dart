import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/models/tenant_model.dart';
import 'package:http/http.dart' as http;

class editTenant extends StatefulWidget {
  String token_saved;
  Tenant tenant_instance;

  editTenant(this.token_saved, this.tenant_instance);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return editTenantState(token_saved, tenant_instance);
  }
}

Future<Tenant> editedTenant(String token_saved, Tenant tenant_instance,
    String name, String email, String mobile, String room) async {
  print(token_saved);
  final apiUrl =
      "https://tenant-manager-arsenel.herokuapp.com/app/tenant_views/" +
          tenant_instance.id.toString();
  String header = "TOKEN " + "$token_saved";
  print(header);
  final editedResponse = await http.put(apiUrl, headers: {
    "Authorization": header
  }, body: {
    "name": name,
    "email": email,
    "mobile_no": mobile,
    "deposite": tenant_instance.deposite.toString(),
    "room_name": room,
  });

  if (editedResponse.statusCode <= 202) {
    var JsonResponse = jsonDecode(editedResponse.body);
    // print("##############################");
    // print(JsonResponse);
    Tenant returnResponse = Tenant(
        tenant_instance.id,
        name,
        mobile,
        tenant_instance.startDate,
        tenant_instance.deposite,
        room,
        tenant_instance.balance,
        email);
    return returnResponse;
  } else {
    // print(editedResponse.body);
    return null;
  }
}

class editTenantState extends State<editTenant> {
  String token_saved;
  Tenant tenant_instance;
  String _error;
  bool _isloading = false;
  TextEditingController nameController;
  TextEditingController mobileController;
  TextEditingController emailController;
  TextEditingController roomController;

  editTenantState(this.token_saved, this.tenant_instance) {
    nameController = TextEditingController(text: tenant_instance.name);
    mobileController = TextEditingController(text: tenant_instance.mobileNo);
    emailController = TextEditingController(text: tenant_instance.email);
    roomController = TextEditingController(text: tenant_instance.roomName);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit " + tenant_instance.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Container(
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                // initialValue: tenant_instance.name,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: mobileController,
                // initialValue: tenant_instance.mobileNo,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_android),
                    labelText: "Mobile no.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                // initialValue: tenant_instance.,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: roomController,
                // initialValue: tenant_instance.roomName,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.meeting_room),
                    labelText: "RoomName",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () async {
                  if (!_isloading) {
                    _isloading = true;
                    final String name = nameController.text;
                    final String mobile = mobileController.text;
                    final String room_name = roomController.text;
                    final String email = emailController.text;
                    // final int deposite=tenant_instance.deposite;
                    print(name);
                    print(mobile);
                    print(email);
                    print(room_name);
                    if (mobile.length == 10) {
                      Tenant edited = await editedTenant(token_saved,
                          tenant_instance, name, email, mobile, room_name);
                      if (edited != null) {
                        Navigator.pop(context, edited);
                      } else {
                        setState(() {
                          _error = "error";
                        });
                      }
                    } else {
                      setState(() {
                        _error = "error";
                      });
                      _isloading = false;
                    }
                  }
                },
                child: Text("Save Changes"),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context, tenant_instance);
                },
                child: Text("Cancel"),
              ),
              _error == null
                  ? Container()
                  : Text("Mobile no. must be of 10 digits only"),
            ],
          ),
        ),
      ),
    );
  }
}
