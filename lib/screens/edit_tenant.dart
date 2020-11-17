import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/models/tenant_model.dart';

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

class editTenantState extends State<editTenant> {
  String token_saved;
  Tenant tenant_instance;
  editTenantState(this.token_saved, this.tenant_instance);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController roomController = TextEditingController();

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
          child: Column(
            children: [
              TextFormField(
                initialValue: tenant_instance.name,
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
                initialValue: tenant_instance.mobileNo,
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
                initialValue: "demo@gmail.com(pending feature)",
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
                initialValue: tenant_instance.roomName,
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
                onPressed: () {
                  print("hello");
                },
                child: Text("Save Changes"),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
