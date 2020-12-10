import 'dart:convert';
import 'package:flutter/cupertino.dart';
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
    String username, String email, String password, String password2,String mobile) async {
  final String LoginUrl = """
https://tenant-manager-arsenel.herokuapp.com/account/user/register""";
  final response = await http.post(LoginUrl, body: {
    "username": username,
    "email": email,
    "password": password,
    "password2": password2,
    "mobile_no":mobile
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
  bool _isSuccess=false;
  bool _isloading=false;
  bool _moberror=false;
  String response_output;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController Repassword1Controller = TextEditingController();

  bool _showPassword = false;
  bool _showRePassword = false;
  @override
  Widget build(BuildContext context) {
    AssetImage logoimage = AssetImage("images/Arsenel_logo.png");
    Image image = Image(image: logoimage);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isSuccess ?
          Padding(
            padding: EdgeInsets.all(32.0),
            child: Container(
              child:Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  child: image,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Center(
                    child:Text("Activate Your account from Email"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    print("pressed (pop)");
                    Navigator.pop(context);
                  },
                  child: Text("Sign In"),
                )
              ],
            ),)
          )
          :Padding(
          padding: EdgeInsets.all(32.0),
          child: _isloading?
          Padding(
            padding: EdgeInsets.all(32),
            child: Container(
              child: Center(
                child:CircularProgressIndicator(),
              ),
            ),
          ):Form(
            // padding: EdgeInsets.all(32),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  child: image,
                ),
                SizedBox(
                  height: 10,
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
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_android),
                      labelText: "Google Pay Mobile no.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
                SizedBox(
                  height: 10,
                  child: _moberror?Text("Check mobile number",style: TextStyle(color: Colors.red),):Container(),
                ),
                TextField(
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: passwordController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "password",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        child: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  obscureText: !_showPassword,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: Repassword1Controller,
                  decoration: InputDecoration(
                      labelText: "Re password",
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showRePassword = !_showRePassword;
                          });
                        },
                        child: Icon(
                          _showRePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  obscureText: !_showRePassword,
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
                    setState(() {
                      _isloading=true;
                    });
                    final String username = usernameController.text;
                    final String email = emailController.text;
                    final String password = passwordController.text;
                    final String password2 = Repassword1Controller.text;
                    final String mobile=mobileController.text;
                    String response;
                    if (mobile.length==10)
                    {
                                response = await registerOn(
                                    username,
                                    email,
                                    password,
                                    password2,
                                    mobile);
                    }
                    else{
                      setState(() {

                      });
                    }

                              setState(() {
                      _isloading=false;
                      response_output = response;
                      if(response_output =="Activate your Account From Email"){
                        setState(() {
                          _isSuccess=true;
                        });
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                response_output == null ? Container() : Text(response_output,style: TextStyle(color: Colors.red),),
                FlatButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    print("pressed (pop)");
                    Navigator.pop(context);
                  },
                  child: Text("Already an Account? Sign In"),
                )
              ],
            ),
          )),
    );
  }
}
