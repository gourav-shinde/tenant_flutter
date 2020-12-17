import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_manager/models/payment_request_model.dart';
import 'package:http/http.dart' as http;

class PaymentDetail extends StatefulWidget {
  String token_instance;
  PaymentRequest payment_instance;
  PaymentDetail(this.token_instance, this.payment_instance);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentDetailState(token_instance, payment_instance);
  }
}

Future<bool> approved(String token_instance, int id) async {
  String approveurl =
      "https://tenant-manager-arsenel.herokuapp.com/app/approved/" +
          id.toString();
  String header = "TOKEN " + "$token_instance";
  final response =
      await http.get(approveurl, headers: {"Authorization": header});
  if (response.statusCode <= 202) {
    return true;
  } else {
    return false;
  }
}

Future<bool> denied(String token_instance, int id) async {
  String approveurl =
      "https://tenant-manager-arsenel.herokuapp.com/app/denied/" +
          id.toString();
  String header = "TOKEN " + "$token_instance";
  final response =
      await http.get(approveurl, headers: {"Authorization": header});
  if (response.statusCode <= 202) {
    return true;
  } else {
    return false;
  }
}

class PaymentDetailState extends State<PaymentDetail> {
  String error = "";
  bool _isloading = false;
  String token_instance;
  PaymentRequest payment_instance;
  PaymentDetailState(this.token_instance, this.payment_instance);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Request"),
      ),
      body: _isloading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  ListTile(
                    title: Text(payment_instance.name),
                    trailing: Text(" ₹ " + payment_instance.amount.toString()),
                  ),
                  ListTile(
                    title:
                        Text("Description : " + payment_instance.description),
                  ),
                  // ListTile(
                  //   title: Text("https://tenant-manager-arsenel.herokuapp.com"+
                  //       payment_instance.imgUrl),
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: Colors.green,
                          onPressed: () async {
                            print("there");
                            if (!_isloading) {
                              setState(() {
                                _isloading = true;
                              });
                              bool okay = await approved(
                                  token_instance, payment_instance.id);
                              if (okay == true) {
                                Navigator.pop(context);
                              } else {
                                error = "Something unexpected occured";
                              }
                              _isloading = false;
                            }
                          },
                          child: Text("Confirmed"),
                        ),
                      ),
                      Expanded(
                          child: RaisedButton(
                        color: Colors.redAccent,
                        onPressed: () async {
                          print("hello");
                          if (!_isloading) {
                            setState(() {
                              _isloading = true;
                            });
                            bool okay = await denied(
                                token_instance, payment_instance.id);
                            if (okay == true) {
                              Navigator.pop(context);
                            } else {
                              error = "Something unexpected occured";
                            }
                            _isloading = false;
                          }
                        },
                        child: Text("Not Confirmed yet"),
                      ))
                    ],
                  ),
                  Expanded(
                      child: Container(
                    child: payment_instance.imgUrl != null
                        ? Container(
                            child: Image.network(payment_instance.imgUrl),
                          )
                        : Container(
                            child: Text("No Image attached"),
                          ),
                  ))
                  // Row(
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Expanded(
                  //             child: Container(
                  //           color: Colors.yellow,
                  //         ))
                  //         // Expanded(
                  //         //     child: payment_instance.imgUrl != null
                  //         //         ? Image.network(
                  //         //             "https://tenant-manager-arsenel.herokuapp.com" +
                  //         //                 payment_instance.imgUrl)
                  //         //         : Text("No Image attached"))
                  //       ],
                  //     )
                  //   ],
                  // )
                ],
              )),
    );
  }
}
