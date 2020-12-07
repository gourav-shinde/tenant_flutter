import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/screens/add_tenant.dart';
import 'package:tenant_manager/screens/tenant_detail.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_manager/main.dart';

//models
import 'package:tenant_manager/models/tenant_model.dart';

class TenantView extends StatefulWidget {
  String Token_recieved;
  TenantView(this.Token_recieved);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TenantViewState(Token_recieved);
  }
}

Future<List<Tenant>> createList(String Token_saved) async {
  print(Token_saved);
  final String LoginUrl = """
https://tenant-manager-arsenel.herokuapp.com/app/tenant_views""";
  print("TOKEN $Token_saved hello");
  String header = "TOKEN " + "$Token_saved";
  print(header);
  final response = await http.get(LoginUrl, headers: {"Authorization": header});
  if (response.statusCode <= 202) {
    var JsonData;
    try {
      print("object");
      JsonData = jsonDecode(response.body);
      print("2");
    } on Exception catch (exception) {
      print("3");
      return null;
    } catch (error) {
      print("4");
      return null;
    }
    print(JsonData["tenants"]);
    List<Tenant> tenants = [];
    print("5");
    for (var u in JsonData["tenants"]) {
      Tenant obj = Tenant(u["id"], u["name"], u["mobile_no"], u["start_date"],
          u["deposite"], u["room_name"], u["balance"], u['email']);
      tenants.add(obj);
    }

    return tenants;
  } else {
    return null;
  }
}

class TenantViewState extends State<TenantView> {
  String Token_saved;
  TenantViewState(this.Token_saved);
  final TextEditingController searchController = TextEditingController();
  String searchString = "";
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
          child: FutureBuilder(
            future: createList(Token_saved),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  padding: EdgeInsets.all(100),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else
                return Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          searchString = value;
                        });
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return searchString != null &&
                                (snapshot.data[index].name)
                                    .toLowerCase()
                                    .contains(searchString.toLowerCase())
                            ? ListTile(
                                title: Text(snapshot.data[index].name),
                                trailing: snapshot.data[index].balance >= 0
                                    ? Text(
                                        " ₹ " +
                                            snapshot.data[index].balance
                                                .toString(),
                                        style: TextStyle(color: Colors.green),
                                      )
                                    : Text(
                                        " ₹ " +
                                            snapshot.data[index].balance
                                                .toString(),
                                        style: TextStyle(color: Colors.red),
                                      ),
                                onTap: () {
                                  var balance = snapshot.data[index].balance;
                                  print(snapshot.data[index].name);
                                  print(balance);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Tenant_detail(
                                            snapshot.data[index], Token_saved)),
                                  ).then((value) => setState(() {
                                        print("hello");
                                      }));
                                },
                              )
                            : Container();
                      },
                    ))
                  ],
                );
            },
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("pressed");
          print("Done");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddTenantView(Token_saved);
          }));
        },
      ),
    );
  }
}
