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

Future<ChangePass> changePass(String email) async{
  final String passUrl = "https://tenant-manager-arsenel.herokuapp.com/account/user/request";
  final passChange = await http.post(passUrl,body: {
    "email": email,
  });
  if(passChange.statusCode == 200){
    final String passChangeString = passChange.body;
    print(passChange.body);
    return changePassFromJson(passChangeString);
  }else{
    print("Error");
  }
}

Future<ChangeUser> changeUser(String email) async{
  final String passUrl = "https://tenant-manager-arsenel.herokuapp.com/account/user/request/username";
  final userChange = await http.post(passUrl,body: {
    "email": email,
  });
  if(userChange.statusCode == 200){
    final String userChangeString = userChange.body;
    print(userChange.body);
    return changeUserFromJson(userChangeString);
  }else{
    print("Error");
  }
}

class ChangePasswordState extends State<ChangePassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(30),
          child: ListView(
            children: [
              SizedBox(
                height: 190,
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
              Row(children: [
                Expanded(child: RaisedButton(
                  color: Theme
                      .of(context)
                      .primaryColorDark,
                  textColor: Theme
                      .of(context)
                      .primaryColorLight,
                  child: Text(
                    "   Password Request   ",
                    textScaleFactor: 1.0,
                  ),
                  onPressed: () async {
                    final String email = emailController.text;
                    final ChangePass changeP = await changePass(email);
                    Navigator.pop(context);
                  },
                ),),
                Container(width: 10.0,),
                Expanded(child: RaisedButton(
                  color: Theme
                      .of(context)
                      .primaryColorDark,
                  textColor: Theme
                      .of(context)
                      .primaryColorLight,
                  child: Text(
                    "   User Request   ",
                    textScaleFactor: 1.0,
                  ),
                  onPressed: () async {
                    final String email = emailController.text;
                    final ChangeUser changeU= await changeUser(email);
                    Navigator.pop(context);
                  },
                ),)
              ])
            ],
          )),
    );
  }
}
