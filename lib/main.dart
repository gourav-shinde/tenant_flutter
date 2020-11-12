import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/Register_view.dart';
import 'package:tenant_manager/tokenModel.dart';
import 'package:http/http.dart' as http;

// screens
import 'package:tenant_manager/screens/logged_sandbox.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      // home: MyHomePage(title: 'Tenant Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// ignore: missing_return
Future<Token> createToken(String username, String password) async {

  final String LoginUrl = """
https://tenant-manager-arsenel.herokuapp.com/account/user/login""";
  final response = await http
      .post(LoginUrl, body: {"username": username, "password": password});

  if (response.statusCode <= 202) {
    final String responseString = response.body;
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var JsonResponse=jsonDecode(responseString);
    prefs.setString("token", JsonResponse["token"]);
    return tokenFromJson(responseString);
  } else {
    return null;
  }
}



class _MyHomePageState extends State<MyHomePage> {
  bool _loading=false;
  Token _token;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static String Token_saved;
  @override
  void initState(){
    getToken();
  }
  getToken()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    setState(() {
      Token_saved = prefs.getString("token");
    });
    print("$Token_saved");
    if(Token_saved!=null){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return TenantView();
      }));

    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            _loading ? LinearProgressIndicator(

            ):Container(),
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
              controller: passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
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
            RaisedButton(
              color: Theme.of(context).primaryColorDark,
              textColor: Theme.of(context).primaryColorLight,
              child: Text(
                "Login",
                textScaleFactor: 1.5,
              ),
              onPressed: () async {
                _loading=true;
                final String username = usernameController.text;
                final String password = passwordController.text;
                final Token token = await createToken(username, password);
                print("received");
                setState(() {
                  _token = token;
                });
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TenantView();
                }));
              },
            ),
            SizedBox(
              height: 32,
            ),
            Token_saved ==null?Container():Text("$Token_saved is saved already"),
            _token == null
                ? Container()
                : Text("Token is ${_token.token} is received"),
            FlatButton(
              color: Colors.white,
              textColor: Colors.black,
              onPressed: () {
                print("pressed (push)");
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Register();
                }));
              },
              child: Text("Create An Account? Sign UP"),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
