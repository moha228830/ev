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
import 'package:eventate/pages/profile/activation.dart';

import 'package:http/http.dart' as http;

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  var token = utils.CreateCryptoRandomString();
  String phone;

  // Initially password is obscure
  get_shard() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var d = localStorage.getString('user');
    var my_code = jsonDecode(d)["phone_code"].toString() ?? "000";
    var my_country = jsonDecode(d)["country"].toString() ?? "";
    var my_phone = jsonDecode(d)["phone"].toString() ?? "my";

    setState(() {
      code = my_code;
      phone = my_phone;
      _phoneControl.text = my_phone;
      if (_country.contains(my_country)) {
        _currentSelectedValue = my_country;
      }
    });
    print(d);
  }

  var _currentSelectedValue;
  String code = "000";
  List _country = [
    "الكويت",
    "مصر",
    "الامارات",
  ];

  bool _isload = false;
  final TextEditingController _phoneControl = new TextEditingController();

  //////////////login //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  my_login() async {
    print(_currentSelectedValue.toString());

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    if (tok != null) {
      try {
        if (_phoneControl.text.trim().isEmpty ||
            _currentSelectedValue.toString() == "" ||
            code == "000" ||
            code == "") {
          Fluttertoast.showToast(
            msg:
                AppLocalizations.of(context).translate('loginPage', 'complete'),
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
        } else {
          if (this.mounted) {
            setState(() {
              _isload = true;
            });
          }
          final response = await http.post(Config.url + "edit_phone", headers: {
            "Accept": "application/json"
          }, body: {
            "phone": _phoneControl.text,
            "code": code,
            "country": _currentSelectedValue.toString(),
            "token": tok.toString()
          });

          final _formKey = GlobalKey<FormState>();

          var prif = SharedPreferences.getInstance();

          final data = jsonDecode(response.body);

          if (data["state"] == "1") {
            SharedPreferences localStorage =
                await SharedPreferences.getInstance();
            return Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Activation(_phoneControl.text,
                      _currentSelectedValue.toString(), code.toString());
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
    _phoneControl.text = phone;
    get_shard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var countryDropDown = Container(
      decoration: new BoxDecoration(
        color: Colors.grey[200],
        border: Border(
          right: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      height: 45.0,
      margin: const EdgeInsets.all(3.0),
      //width: 300.0,
      child: Container(padding: EdgeInsets.all(12.0), child: Text(" ${code}+")),
    );
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "تعديل الهاتف والدولة",
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.flag),
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent, fontSize: 16.0),
                                  hintText: 'اختر الدولة',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              isEmpty: _currentSelectedValue == null,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _currentSelectedValue,
                                  isDense: true,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _currentSelectedValue = newValue;
                                      if (newValue == "الكويت") {
                                        code = "965";
                                      } else if (newValue == "مصر") {
                                        code = "002";
                                      } else if (newValue == "الامارات") {
                                        code = "975";
                                      }

                                      state.didChange(newValue);
                                    });
                                  },
                                  items: _country.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
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
                        child: new TextFormField(
                          controller: _phoneControl,

                          // validator: (value) {
                          //  if (value.isEmpty) {
                          //  return 'Please enter some text';
                          //  }
                          //   },
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.all(12.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.purple)),
                              fillColor: Colors.white,
                              prefixIcon: countryDropDown,
                              hintText: AppLocalizations.of(context)
                                  .translate('loginPage', 'phone'),
                              labelText: AppLocalizations.of(context)
                                  .translate('loginPage', 'phone')),
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
                          my_login();
                        },
                        child: Container(
                          height: 45.0,
                          width: 190.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.redAccent,
                            color:Theme.of(context).primaryColor,
                            elevation: 7.0,
                            child: GestureDetector(
                              child: Center(
                                child: !_isload
                                    ? Text(
                                        "حفظ",
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
                      SizedBox(height: 30.0),
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
