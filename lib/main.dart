import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/Register_view.dart';
import 'package:http/http.dart' as http;
import 'package:tenant_manager/screens/change_password.dart';

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
Future<String> createToken(String username, String password) async {
  final String LoginUrl = """
https://tenant-manager-arsenel.herokuapp.com/account/user/login""";
  final response = await http
      .post(LoginUrl, body: {"username": username, "password": password});
  if (response.statusCode <= 202) {
    final String responseString = response.body;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var JsonResponse = jsonDecode(responseString);
    prefs.setString("token", JsonResponse["token"]);
    return JsonResponse["token"];
  } else {
    print(response.body);
    return "error";
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String Token_saved;
  String _error;
  bool _showPassword = false;

  @override
  void initState() {
    getToken();
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Token_saved = prefs.getString("token");
    });
    print("$Token_saved");
    if (Token_saved != null) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return TenantView(Token_saved);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    AssetImage logoimage = AssetImage("images/Arsenel_logo.png");
    Image image = Image(image: logoimage);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(32.0),
          child: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                _loading ? LinearProgressIndicator() : Container(),
                SizedBox(
                  height: 50,
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
                      labelText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Password",
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
                RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text(
                    "Login",
                    textScaleFactor: 1.5,
                  ),
                  onPressed: () async {
                    _loading = true;
                    final String username = usernameController.text;
                    final String password = passwordController.text;
                    final String token = await createToken(username, password);
                    print("received");
                    _loading = false;
                    setState(() {
                      if (token != "error") {
                        Token_saved = token;
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TenantView(Token_saved)));
                      } else {
                        _error = "error";
                      }
                    });
                  },
                ),
                FlatButton(
                  textColor: Colors.black,
                  onPressed: () {
                    print("pressed (push)");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChangePassword();
                    }));
                  },
                  child: Text(
                    "Forget Password/Username",
                    textScaleFactor: 0.8,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Token_saved == null
                    ? Container()
                    : Text("$Token_saved is saved already"),
                _error == null ? Container() : Text("Invalid Credentials"),
                FlatButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    print("pressed (push)");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Register();
                    }));
                  },
                  child: Text("Create An Account? Sign UP"),
                )
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
