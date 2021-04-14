import 'dart:io';
import 'package:eventate/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/home/home.dart';
import 'package:eventate/pages/login_signup/signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// My Own Import
import 'package:eventate/pages/login_signup/forgot_password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DateTime currentBackPressTime;
  bool _isload = false;
  final TextEditingController _phoneControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  //////////////login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  my_login() async {
    try {
      if (_passwordControl.text.trim().isEmpty ||
          _phoneControl.text.trim().isEmpty) {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate('loginPage', 'complete'),
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      } else if (_phoneControl.text.length < 8) {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context)
              .translate('loginPage', 'phone_error'),
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      } else if (_passwordControl.text.length < 6 ||
          _passwordControl.text.length > 20) {
        Fluttertoast.showToast(
          msg:
              AppLocalizations.of(context).translate('loginPage', 'pass_words'),
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      } else {
        if (this.mounted) {
          setState(() {
            _isload = true;
          });
        }
        final response = await http.post(Config.url + "login", headers: {
          "Accept": "application/json"
        }, body: {
          "phone": _phoneControl.text,
          "password": _passwordControl.text,
        });
        _isload = false;

        final _formKey = GlobalKey<FormState>();

        var prif = SharedPreferences.getInstance();

        final data = jsonDecode(response.body);

        if (data["state"] == "1") {
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          localStorage.setString('token', data['data']["api_token"]);
          localStorage.setString('user', json.encode(data['data']["client"]));
          localStorage.setString(
              'user_id', json.encode(data['data']["client"]["id"].toString()));

          localStorage.setString('login', "2");

          return Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Home(0);
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
  }

  ///end ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).primaryColor,
        title: Text(
          "تسجيل دخول",
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
      body: WillPopScope(
        child: ListView(
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
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _phoneControl,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)
                                  .translate('loginPage', 'phone'),
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: TextField(
                            controller: _passwordControl,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)
                                  .translate('loginPage', 'passwordString'),
                              prefixIcon: Icon(Icons.vpn_key),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            obscureText: true,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: ForgotPasswordPage()));
                          },
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('loginPage', 'forgotPasswordString'),
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontFamily: 'Jost',
                              fontSize: 16.0,
                              letterSpacing: 0.7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        InkWell(
                          onTap: () {
                            my_login();
                          },
                          child: Container(
                            height: 45.0,
                            width:
                                (myLocale.languageCode == 'ru') ? 180.0 : 140.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.redAccent,
                              color: Theme.of(context).primaryColor,
                              elevation: 7.0,
                              child: GestureDetector(
                                child: Center(
                                  child: _isload
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'loginPage', 'loginString'),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Jost',
                                            fontSize: 16.0,
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
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
                                    child: SignupPage()));
                          },
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('loginPage', 'createAccountString'),
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontFamily: 'Jost',
                              fontSize: 17.0,
                              letterSpacing: 0.7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 50.0),
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
                              color:
                                  Theme.of(context).textTheme.headline6.color,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
