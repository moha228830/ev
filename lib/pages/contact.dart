import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/order_payment/payment.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:eventate/config.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';
// My Own Imports

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              launch("tel://96550909048");
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Icon(
                        Icons.phone,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          "96550909048",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch("https://wa.me/96550909048");
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Icon(
                        Icons.phone,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          " ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Container(
                        child: Text(
                      "راسلنا نحن في انتظارك دائما ",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )),
                    TextField(
                      maxLines: 8,
                      decoration: InputDecoration(
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(10), // Added th
                          border: OutlineInputBorder(),
                          hintText: 'الرسالة',
                          labelText: 'اكتب رسالتك هنا'),
                      //controller: _msgcontroller,
                    ),
                    SizedBox(height: 10.0),
                    InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.deepPurpleAccent,
                            boxShadow: [
                              BoxShadow(color: Colors.white, spreadRadius: 3),
                            ],
                          ),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 11,
                          child: Center(
                              child: // !_is2
                                  //  ?
                                  Text(
                            "ارسال",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white),
                          )
                              // : Center(
                              //  child: CircularProgressIndicator(),
                              // ),
                              ),
                        )),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            ),
          )
        ],
      )),
    )
        //: Center(
        //   child: CircularProgressIndicator(),
        // ),
        );
  }

  void _showDialog(title, body) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: new Text(title),
            content: new Text("${body}"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("انهاء"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
