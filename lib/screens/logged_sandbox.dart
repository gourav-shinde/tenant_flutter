import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/screens/add_tenant.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_manager/main.dart';

class TenantView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TenantViewState();
  }
}

class TenantViewState extends State<TenantView> {
  resettoken()async {
    print("hello");
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setString("token",null);
    print("cleared variable");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Tenants"),
        actions: <Widget>[
          FlatButton(
              onPressed: (){
              print("Logout");
              resettoken();
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyHomePage();
              }));
              print("cleared");
              },
              child: Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("Tenant 1"),
            ),
            ListTile(
              title: Text("Tenant 2"),
            ),
            ListTile(
              title: Text("Tenant 3"),
            ),
            ListTile(
              title: Text("Tenant 4"),
            ),
            ListTile(
              title: Text("Tenant 5"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("pressed");
          print("Done");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddTenantView();
          }));
        },
      ),
    );
  }
}
