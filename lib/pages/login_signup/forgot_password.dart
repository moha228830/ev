import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/home/home.dart';
import 'package:eventate/pages/login_signup/changePassword.dart';
import 'package:eventate/pages/login_signup/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:eventate/config.dart';

import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  var token = utils.CreateCryptoRandomString();

  // Initially password is obscure

  // Toggles the password show status

  bool _isload = false;
  final TextEditingController _phoneControl = new TextEditingController();

  //////////////login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  my_activate() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    if (tok != null) {
      try {
        if (_phoneControl.text.trim().isEmpty) {
          Fluttertoast.showToast(
            msg:
                AppLocalizations.of(context).translate('loginPage', 'complete'),
            backgroundColor: Theme.of(context).textTheme.headline6.color,
            textColor: Theme.of(context).appBarTheme.color,
          );
        } else {
          if (this.mounted) {
            setState(() {
              _isload = true;
            });
          }
          final response = await http.post(Config.url + "send_code",
              headers: {"Accept": "application/json"},
              body: {"phone": _phoneControl.text, "token": tok.toString()});

          final _formKey = GlobalKey<FormState>();

          var prif = SharedPreferences.getInstance();

          final data = jsonDecode(response.body);

          if (data["state"] == "1") {
            return Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ChangePassword();
                },
              ),
            );
          } else {
            Fluttertoast.showToast(
              msg: '${data["msg"]}',
              backgroundColor: Theme.of(context).textTheme.headline6.color,
              textColor: Theme.of(context).appBarTheme.color,
            );
            //01155556624
            if (this.mounted) {
              setState(() {
                _isload = false;
              });
            }
          }
          // _showDialog (data["state"],m);

        }
      } on SocketException catch (_) {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate('loginPage', 'no_net'),
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'خطأ غير متوقع اغلق التطبيق ثم اعد فتحة من البداية',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }
  }

  ///end ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "نسيت كلمة المرور",
          style: TextStyle(
            fontFamily: 'Jost',
            color: Colors.white,
            fontSize: width / 24,
            letterSpacing: 1.7,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  width: width - 40.0,
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 20.0, right: 10.0, left: 10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.color,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1.5,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("بعد ارسال رقم هاتفك افحص رسائل sms في جهازك"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _phoneControl,
                          decoration: InputDecoration(
                            hintText: "رقم الهاتف",
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.purple)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          my_activate();
                        },
                        child: Container(
                          height: 45.0,
                          width: 190.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.redAccent,
                            color: Theme.of(context).primaryColor,
                            elevation: 7.0,
                            child: GestureDetector(
                              child: Center(
                                child: !_isload
                                    ? Text(
                                        "ارسال",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Jost',
                                          fontSize: 16.0,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Home(0)));
                        },
                        child: Text(
                          "الرئيسية",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline6.color,
                            fontFamily: 'Jost',
                            fontSize: 17.0,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
