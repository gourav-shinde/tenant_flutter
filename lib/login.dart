import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tenant Manager'),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.only(top: 30.0, left: 25.0, right: 25.0),
          child: ListView(
            children: [
              Padding(padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
              child:Text(
                "Log In",
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 45.0,
                  color: Colors.black87,
                ),
              )),

              Container(width: 20.0,),

              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        child: Text('Log In'),
                        color: Colors.deepPurple,
                        onPressed: () {},
                      ),
                    ),

                    Container(width: 20.0,),

                    Expanded(
                      child: RaisedButton(
                        child: Text('Sign Up'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
