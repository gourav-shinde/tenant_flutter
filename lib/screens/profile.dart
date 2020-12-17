import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/models/profile_model.dart';
import 'package:tenant_manager/screens/logged_sandbox.dart';
import 'package:tenant_manager/screens/payment_approval.dart';
import 'package:tenant_manager/screens/payment_request.dart';

Future<bool> putProfile(String token_saved, String link, String mobile) async {
  String apiurl =
      "https://tenant-manager-arsenel.herokuapp.com/account/user/profile";
  String header = "TOKEN " + "$token_saved";
  print(header);
  final editedResponse = await http.put(apiurl, headers: {
    "Authorization": header
  }, body: {
    "mobile_no": mobile,
    "link": link,
  });
  print(editedResponse.statusCode);
  print(editedResponse.body);
  if (editedResponse.statusCode <= 202) {
    var JsonResponse = jsonDecode(editedResponse.body);
    return true;
  } else {
    print(editedResponse.body);
    return false;
  }
}

Future<Profile> getProfile(String token_saved) async {
  String apiurl =
      "https://tenant-manager-arsenel.herokuapp.com/account/user/profile";
  String header = "TOKEN " + "$token_saved";
  print(header);
  final response = await http.get(apiurl, headers: {"Authorization": header});
  if (response.statusCode <= 202) {
    var JsonData = jsonDecode(response.body);
    print(JsonData);
    Profile profile = Profile(JsonData["username"], JsonData["email"],
        JsonData["mobile"], JsonData["link"]);
    return profile;
  } else {
    print(response.body);
    return null;
  }
}

class profileView extends StatefulWidget {
  String token_instance;
  profileView(this.token_instance);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return profileViewState(token_instance);
  }
}

class profileViewState extends State<profileView> {
  String error;
  bool isLoading = true;
  int _index = 0;
  bool _isEdit = false;
  String token_instance;
  Profile profile_instance = Profile("", "", "", "");
  profileViewState(this.token_instance);
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController linkcontroller = TextEditingController();

  void getPro(String token_instance) async {
    Profile prob = await getProfile(token_saved);
    if (prob.name == null) {
    } else {
      isLoading = false;

      setState(() {
        profile_instance = prob;
      });
      linkcontroller = TextEditingController(text: profile_instance.link);
      mobilecontroller = TextEditingController(text: profile_instance.mobile);
    }
  }

  String get token_saved => token_instance;
  void onTapFunc(int index) {
    setState(() {
      _index = index;
      if (_index == 1) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TenantView(token_saved);
        }));
      } else if (_index == 2) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PaymentRequestView(token_saved);
        }));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print("hello");
    getPro(token_instance);
    super.initState();
    print("something");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          FlatButton(
              onPressed: () {
                setState(() {
                  if (_isEdit == false) {
                    _isEdit = true;
                  } else {
                    _isEdit = false;
                  }
                });
              },
              child: _isEdit ? Icon(Icons.cancel) : Icon(Icons.edit))
        ],
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: EdgeInsets.all(15),
              child: _isEdit
                  ? Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          TextField(
                            controller: mobilecontroller,
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
                          TextField(
                            controller: linkcontroller,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.link),
                                labelText: "Merchant Payment Link",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            onPressed: () async {
                              if (!isLoading) {
                                setState(() {
                                  isLoading = true;
                                });

                                String link = linkcontroller.text;
                                String mobile = mobilecontroller.text;
                                if (mobile.length == 10) {
                                  bool success = await putProfile(
                                      token_saved, link, mobile);
                                  isLoading = false;
                                  if (success == true) {
                                    getPro(token_instance);
                                    setState(() {
                                      _isEdit = false;
                                    });
                                  } else {}
                                } else {
                                  setState(() {
                                    error = "Enter Valid Mobile Number";
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                            child: Text("Save Changes"),
                          ),
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  _isEdit = false;
                                });
                              },
                              child: Text("Cancel")),
                          Container(
                            child: error != null
                                ? Text(
                                    error,
                                    style: TextStyle(color: Colors.red),
                                  )
                                : Container(),
                          ),
                          Container(
                            child: Text(
                                "The Merchant Payment link is sent to tenants via emails when bill is generated"),
                          )
                        ],
                      ))
                  : Container(
                      child: isLoading
                          ? Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Column(
                              children: [
                                ListTile(
                                  title:
                                      Text("Name : " + profile_instance.name),
                                ),
                                ListTile(
                                  title:
                                      Text("Email : " + profile_instance.email),
                                ),
                                ListTile(
                                  title: Text(
                                      "Mobile No : " + profile_instance.mobile),
                                ),
                                ListTile(
                                  title: Text("Payment Link : " +
                                      profile_instance.link),
                                ),
                              ],
                            ),
                    ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapFunc,
        currentIndex: 0,
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
