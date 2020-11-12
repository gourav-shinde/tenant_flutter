import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/screens/add_tenant.dart';

class TenantView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TenantViewState();
  }
}

class TenantViewState extends State<TenantView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Tenants"),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddTenantView();
          }));
        },
      ),
    );
  }
}
