import 'package:flutter/material.dart';
import 'package:tenant_manager/Register_view.dart';
import 'package:tenant_manager/tokenModel.dart';
import 'package:http/http.dart' as http;

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
      home: Register(),
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
Future<Token>createToken(String username,String password) async{
  final String LoginUrl="""
https://tenant-manager-arsenel.herokuapp.com/account/user/login""";
  final response = await http.post(LoginUrl,body:{
    "username":username,
    "password":password
  });

  if(response.statusCode <=202){
    final String responseString =response.body;
    return tokenFromJson(responseString);
  }
  else{
    return null;
  }

}

class _MyHomePageState extends State<MyHomePage> {
  Token _token;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding:EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )
              ),
            ),
            TextField(
              controller: passwordController,
            ),
            SizedBox(height: 32,),
            _token==null?Container():
                Text("Token is ${_token.token} is received"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final String username =usernameController.text;
          final String password=passwordController.text;
          final Token token =await createToken(username, password);
          setState(() {
            _token=token;
          });

        },

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
