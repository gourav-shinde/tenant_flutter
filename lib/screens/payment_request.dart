import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/models/payment_request_model.dart';
import 'package:tenant_manager/screens/payment_approval.dart';
import 'package:tenant_manager/screens/profile.dart';
import 'package:tenant_manager/screens/logged_sandbox.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_manager/main.dart';

//models

class PaymentRequestView extends StatefulWidget {
  String token_instance;
  PaymentRequestView(this.token_instance);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentRequestViewState(token_instance);
  }
}

Future<List<PaymentRequest>> createList(String Token_saved) async {
  print(Token_saved);
  final String getrequests = """
https://tenant-manager-arsenel.herokuapp.com/app/paymentlist""";
  // print("TOKEN $Token_saved hello");
  String header = "TOKEN " + "$Token_saved";
  // print(header);
  final response =
      await http.get(getrequests, headers: {"Authorization": header});
  if (response.statusCode <= 202) {
    var JsonData;
    try {
      JsonData = jsonDecode(response.body);
    } on Exception catch (exception) {
      return null;
    } catch (error) {
      return null;
    }
    // print(JsonData["tenants"]);
    List<PaymentRequest> requests = [];
    // print("5");
    for (var u in JsonData) {
      PaymentRequest obj = PaymentRequest(
          u["id"], u["description"], u["amount"], u["img"], u["tenant_name"]);
      requests.add(obj);
    }

    return requests;
  } else {
    return null;
  }
}

class PaymentRequestViewState extends State<PaymentRequestView> {
  String token_instance;
  PaymentRequestViewState(this.token_instance);
  String get token_saved => token_instance;
  int _index = 1;
  void onTapFunc(int index) {
    setState(() {
      _index = index;
      if (_index == 0) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return profileView(token_saved);
        }));
      } else if (_index == 1) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TenantView(token_saved);
        }));
      }
    });
  }

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
        title: Text("Requests"),
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
            future: createList(token_instance),
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
                    Expanded(
                        child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data[index].name),
                          trailing: Text(
                              " ₹ " + snapshot.data[index].amount.toString()),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentDetail(
                                      token_instance, snapshot.data[index])),
                            ).then((value) => setState(() {
                                  print("hello");
                                }));
                          },
                        );
                      },
                    ))
                  ],
                );
            },
          )),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapFunc,
        currentIndex: 2,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text("Profile")),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("Tenant")),
          BottomNavigationBarItem(
              icon: Icon(Icons.payment), title: Text("Payment"))
        ],
      ),
    );
  }
}
