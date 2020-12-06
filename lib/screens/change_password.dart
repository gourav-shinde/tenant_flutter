import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tenant_manager/models/username_request.dart';
import '../models/password_request.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChangePasswordState();
  }
}

Future<ChangePass> changePass(String email) async {
  final String passUrl =
      "https://tenant-manager-arsenel.herokuapp.com/account/user/request";
  final passChange = await http.post(passUrl, body: {
    "email": email,
  });
  if (passChange.statusCode == 200) {
    final String passChangeString = passChange.body;
    print(passChange.body);
    return changePassFromJson(passChangeString);
  } else {
    print("Error");
  }
}

Future<ChangeUser> changeUser(String email) async {
  final String passUrl =
      "https://tenant-manager-arsenel.herokuapp.com/account/user/request/username";
  final userChange = await http.post(passUrl, body: {
    "email": email,
  });
  if (userChange.statusCode == 200) {
    final String userChangeString = userChange.body;
    print(userChange.body);
    return changeUserFromJson(userChangeString);
  } else {
    print("Error");
  }
}

class ChangePasswordState extends State<ChangePassword> {
  TextEditingController emailController = TextEditingController();
  String error;

  @override
  Widget build(BuildContext context) {
    AssetImage logoimage = AssetImage("images/Arsenel_logo.png");
    Image image = Image(image: logoimage);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.all(30),
          child: ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 200,
                child: image,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail_rounded),
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        "  Reset password  ",
                        textScaleFactor: 1.0,
                      ),
                      onPressed: () async {
                        final String email = emailController.text;

                        if (email != '') {
                          final ChangePass changeP = await changePass(email);
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            print("error");
                            error = 'error';
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    width: 10.0,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        "  Request Username  ",
                        textScaleFactor: 1.0,
                      ),
                      onPressed: () async {
                        final String email = emailController.text;
                        if (email != '') {
                          final ChangeUser changeU = await changeUser(email);
                          Navigator.pop(context);
                        } else {
                          print("error");
                          setState(() {
                            error = "error";
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  error == null ? Container() : Text("Email field is empty.")
                ],
              )
            ],
          )),
    );
  }
}
