import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/home/home.dart';
import 'package:eventate/pages/login_signup/forgot_password.dart';
import 'package:eventate/pages/login_signup/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:eventate/config.dart';
import 'package:eventate/pages/login_signup/activation.dart';

import 'package:http/http.dart' as http;

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  var token = utils.CreateCryptoRandomString();

  // Initially password is obscure
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  String _password;

  // Toggles the password show status
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  bool _isload = false;
  final TextEditingController _newpasswordControl = new TextEditingController();
  final TextEditingController _oldpasswordControl = new TextEditingController();

  //////////////login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  my_login() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    if (tok != null) {
      try {
        if (_oldpasswordControl.text.trim().isEmpty ||
            _newpasswordControl.text.trim().isEmpty) {
          Fluttertoast.showToast(
            msg:
                AppLocalizations.of(context).translate('loginPage', 'complete'),
            backgroundColor: Theme.of(context).textTheme.headline6.color,
            textColor: Theme.of(context).appBarTheme.color,
          );
        } else if (_oldpasswordControl.text.length < 6 ||
            _oldpasswordControl.text.length > 20) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)
                .translate('loginPage', 'pass_words'),
            backgroundColor: Theme.of(context).textTheme.headline6.color,
            textColor: Theme.of(context).appBarTheme.color,
          );
        } else if (_newpasswordControl.text.length < 6 ||
            _newpasswordControl.text.length > 20) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)
                .translate('loginPage', 'pass_words'),
            backgroundColor: Theme.of(context).textTheme.headline6.color,
            textColor: Theme.of(context).appBarTheme.color,
          );
        } else {
          if (this.mounted) {
            setState(() {
              _isload = true;
            });
          }
          final response = await http.post(Config.url + "edit_pass", headers: {
            "Accept": "application/json"
          }, body: {
            "new": _newpasswordControl.text,
            "old": _oldpasswordControl.text,
            "token": tok.toString()
          });

          final _formKey = GlobalKey<FormState>();

          var prif = SharedPreferences.getInstance();

          final data = jsonDecode(response.body);

          if (data["state"] == "1") {
            SharedPreferences localStorage =
                await SharedPreferences.getInstance();
            localStorage.setString('token', data['data']["api_token"]);
            localStorage.setString('user', json.encode(data['data']["client"]));
            localStorage.setString('user_id',
                json.encode(data['data']["client"]["id"].toString()));
            Fluttertoast.showToast(
              msg: 'تمت العملية بنجاح',
              backgroundColor: Theme.of(context).textTheme.headline6.color,
              textColor: Theme.of(context).appBarTheme.color,
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
    if (this.mounted) {
      setState(() {
        _isload = false;
      });
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
          "تعديل كلمة المرور",
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
                  height: 30.0,
                ),
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          controller: _oldpasswordControl,
                          decoration: InputDecoration(
                            hintText: "كلمة المرور القديمة",
                            prefixIcon: new FlatButton(
                                onPressed: _toggle1,
                                child: _obscureText1
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.purple)),
                          ),
                          obscureText: _obscureText1,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          controller: _newpasswordControl,
                          decoration: InputDecoration(
                            hintText: "كلمة المرور الجديدة",
                            prefixIcon: new FlatButton(
                                onPressed: _toggle2,
                                child: _obscureText2
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(width: 2, color: Colors.purple)),
                          ),
                          obscureText: _obscureText2,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () {
                          my_login();
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
                                        "حفظ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Jost',
                                          fontSize: 18.0,
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
                        height: 15.0,
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
