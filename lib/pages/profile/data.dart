import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/home/home.dart';
import 'package:provider/provider.dart';
import 'package:eventate/pages/product_list_view/get_function.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:eventate/config.dart';
import 'package:eventate/pages/login_signup/activation.dart';

import 'package:http/http.dart' as http;

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  String name;
  var token = utils.CreateCryptoRandomString();

  // Initially password is obscure

  // Toggles the password show status

  bool _isload = false;
  String my_name = "user";
  final TextEditingController _nameControl = new TextEditingController();
  get_shard() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var d = localStorage.getString('user');
    name = jsonDecode(d)["name"] ?? " ";
    setState(() {
      my_name = name;
      _nameControl.text = my_name;
    });
    print(name);
  }

  //////////////login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  my_login() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    var login = localStorage.getString('login');

    if (tok != null && login == "2") {
      try {
        if (_nameControl.text.trim().isEmpty) {
          Fluttertoast.showToast(
            msg: "لم تقم بتعديل الاسم",
            backgroundColor: Theme.of(context).textTheme.headline6.color,
            textColor: Theme.of(context).appBarTheme.color,
          );
        } else if (_nameControl.text.length < 4) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)
                .translate('loginPage', 'name_error'),
            backgroundColor: Theme.of(context).textTheme.headline6.color,
            textColor: Theme.of(context).appBarTheme.color,
          );
        } else {
          if (this.mounted) {
            setState(() {
              _isload = true;
            });
          }
          final response = await http.post(Config.url + "edit_user",
              headers: {"Accept": "application/json"},
              body: {"name": _nameControl.text, "token": tok.toString()});

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
              msg: "${data["msg"]}",
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
    get_shard();
    _nameControl.text = name;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "تعديل الاسم",
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
                      Text("تعديل اسم المستخدم"),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          controller: _nameControl,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.perm_identity),
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
                                        " حفظ ",
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
                        height: 30.0,
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
