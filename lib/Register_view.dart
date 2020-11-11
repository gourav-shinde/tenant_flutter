import 'dart:convert';

import 'package:tenant_manager/main.dart';
import 'package:tenant_manager/tokenModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

Future<String> registerOn(
    String username, String email, String password, String password2) async {
  final String LoginUrl = """
https://tenant-manager-arsenel.herokuapp.com/account/user/register""";
  final response = await http.post(LoginUrl, body: {
    "username": username,
    "email": email,
    "password": password,
    "password2": password2
  });

  if (response.statusCode <= 202) {
    debugPrint("Successfully Created");
    debugPrint(response.body);
    return "Activate your Account From Email";
  } else if (response.statusCode == 400) {
    Map map = jsonDecode(response.body);
    String temporaryt = "";
    map.forEach((k, v) {
      print(v.runtimeType);
      if (v is List) {
        print(v[0].runtimeType);
        temporaryt = temporaryt + k + " " + v[0] + "\n";
      } else {
        temporaryt = temporaryt + k + " " + v + "\n";
      }
      print("$k $v");
    });
    return temporaryt;
  } else {
    debugPrint("Failed to create Account");
    return "OOps Something Unexpected happened!";
  }
}

class RegisterState extends State<Register> {
  String response_output;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController Repassword1Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 190,
            ),
            TextField(
              controller: usernameController,
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
              controller: emailController,
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
            TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: passwordController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: Repassword1Controller,
              decoration: InputDecoration(
                  labelText: "Re password",
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              color: Theme.of(context).primaryColorDark,
              textColor: Theme.of(context).primaryColorLight,
              child: Text(
                "Register",
                textScaleFactor: 1.5,
              ),
              onPressed: () async {
                final String username = usernameController.text;
                final String email = emailController.text;
                final String password = passwordController.text;
                final String password2 = Repassword1Controller.text;
                final String response =
                    await registerOn(username, email, password, password2);

                setState(() {
                  response_output = response;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            response_output == null ? Container() : Text(response_output),
            FlatButton(
              color: Colors.white,
              textColor: Colors.black,
              onPressed: () {
                print("pressed");
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyHomePage();
                }));
              },
              child: Text("Already an Account? Sign In"),
            )
          ],
        ),
      ),
    );
  }
}
