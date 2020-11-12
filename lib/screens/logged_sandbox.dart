import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/screens/add_tenant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_manager/main.dart';

//models
import 'package:tenant_manager/models/tenant_model.dart';

class TenantView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TenantViewState();
  }
}

Future<List<Tenant>> createList(String Token_saved) async {
  final String LoginUrl = """
https://tenant-manager-arsenel.herokuapp.com/app/tenant_views""";
  print("TOKEN $Token_saved");
  String header = "TOKEN " + "$Token_saved";
  print(header);
  final response = await http.get(LoginUrl, headers: {"Authorization": header});
  var JsonData = response.body;
  print(JsonData);
}

class TenantViewState extends State<TenantView> {
  static String Token_saved;
  @override
  void initState() {
    getToken();
    print("Print $Token_saved");
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Token_saved = prefs.getString("token");
    });
    print("$Token_saved");
    if (Token_saved == null) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyHomePage();
      }));
    } else {
      createList(Token_saved);
    }
  }

  //to delete token in
  resettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", null);
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
            onPressed: () {
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
