import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eventate/pages/call_center/call_center.dart';
import 'package:eventate/pages/product_list_view/get_function.dart';
import 'package:eventate/pages/profile/address.dart';
import 'package:eventate/pages/profile/balance.dart';
import 'package:eventate/pages/profile/password.dart';
import 'package:eventate/pages/profile/phone.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:eventate/pages/login_signup/signup.dart';
import 'package:eventate/pages/profile/data.dart';

import 'package:eventate/pages/login_signup/login.dart';

import 'package:eventate/pages/login_signup/activation.dart';
import 'package:eventate/pages/login_signup/changePassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eventate/pages/home/home.dart';

// My Own Imports
import 'package:eventate/AppTheme/AppStateNotifier.dart';
import 'package:eventate/pages/change_language.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/faq_and_about_app/about_app.dart';
import 'package:eventate/pages/faq_and_about_app/faq.dart';
import 'package:eventate/pages/login_signup/login.dart';
import 'package:eventate/pages/my_account/account_setting.dart';
import 'package:eventate/pages/my_orders.dart';
import 'package:eventate/pages/notification.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  String my_name;
  deleete() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove("user");
    localStorage.remove("token");
    localStorage.setString('login', "0");
    Navigator.push(context,
        PageTransition(type: PageTransitionType.rightToLeft, child: Home(0)));
  }

  deleete_activation() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove("user");
    localStorage.setString('login', "0");
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: SignupPage()));
  }

  var status = "0";
  var name = "user";
  get_shard() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var login = localStorage.getString('login');
    //var user =localStorage.getString('user');
    if (login != null) {
      if (login == "0") {
        setState(() {
          status = "0";
          // name = user["name"];
        });
      } else if (login == "1") {
        setState(() {
          status = "1";
        });
      } else if (login == "2") {
        var d = localStorage.getString('user');
        var name = jsonDecode(d)["name"] ?? "user";

        setState(() {
          status = "2";
          my_name = name;
        });
      } else {
        setState(() {
          status = "0";
        });
      }
    } else {
      var token = utils.CreateCryptoRandomString();

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var tok = localStorage.getString('token');
      var us = localStorage.getString('user_id');
      if (tok == null) {
        localStorage.setString('token', token);
        localStorage.setString('user_id', "0");
        localStorage.setString('login', "0");
        // print( tok + "moha");

      }
    }
  }

  @override
  void initState() {
    my_name = "زائر";
    get_shard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // Logout AlertDialog Start Here
    logoutDialogue() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              height: 160.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)
                        .translate('myAccountPage', 'sureDialogueString'),
                    style: TextStyle(
                      fontSize: width / 25,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: (width / 3.5),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('myAccountPage', 'closeString'),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Container(
                          width: (width / 3.5),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('myAccountPage', 'logoutString'),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).appBarTheme.color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    // Logout AlertDialog Ends Here

    return status == "no"
        ? CircularProgressIndicator()
        : ListView(
            shrinkWrap: true,
            children: <Widget>[
              Image(
                image: AssetImage('assets/ev.jpeg'),
                width: width,
                height: 220.0,
                fit: BoxFit.fill,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "${my_name}",
                    style: TextStyle(
                        fontSize: width / 24,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.headline6.color),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(7.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.lightbulb,
                      size: 30.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      width: (width - (width / 4.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "الوضع الليلي",
                            style: TextStyle(
                                fontSize: width / 25,
                                fontFamily: "Cairo",
                                color: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .color),
                          ),
                          Switch(
                            value: Provider.of<AppStateNotifier>(context,
                                    listen: false)
                                .isDarkModeOn,
                            onChanged: (boolVal) {
                              Provider.of<AppStateNotifier>(context,
                                      listen: false)
                                  .updateTheme(boolVal);
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30.0, left: 70.0),
                child: Divider(
                  height: 1.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30.0, left: 70.0),
                child: Divider(
                  height: 1.0,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: CallCenter()));
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        size: 30.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate('myAccountPage', 'callCenterString'),
                        style: TextStyle(
                            fontSize: width / 25,
                            fontFamily: "Cairo",
                            color: Theme.of(context).textTheme.headline6.color),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30.0, left: 70.0),
                child: Divider(
                  height: 1.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30.0, left: 70.0),
                child: Divider(
                  height: 1.0,
                ),
              ),
              status == "1"
                  ? Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: Activation()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.supervised_user_circle,
                                  size: 30.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  "تأكيد الحساب",
                                  style: TextStyle(
                                      fontSize: width / 25,
                                      fontFamily: "Cairo",
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 30.0, left: 70.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            deleete_activation();
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.supervised_user_circle,
                                  size: 30.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  " الرجوع للتسجيل من جديد",
                                  style: TextStyle(
                                      fontSize: width / 25,
                                      fontFamily: "Cairo",
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : status == "2"
                      ? Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: Balance()));
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.monetization_on,
                                      size: 30.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "رصيدي",
                                      style: TextStyle(
                                          fontSize: width / 25,
                                          fontFamily: "Cairo",
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 30.0, left: 70.0),
                              child: Divider(
                                height: 1.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: Address()));
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_city,
                                      size: 30.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "دفتر العناوين",
                                      style: TextStyle(
                                          fontSize: width / 25,
                                          fontFamily: "Cairo",
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 30.0, left: 70.0),
                              child: Divider(
                                height: 1.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: Data()));
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.edit,
                                      size: 30.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "تعديل الاسم",
                                      style: TextStyle(
                                          fontSize: width / 25,
                                          fontFamily: "Cairo",
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 30.0, left: 70.0),
                              child: Divider(
                                height: 1.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: Password()));
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.edit,
                                      size: 30.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "تعديل كلمة المرور",
                                      style: TextStyle(
                                          fontSize: width / 25,
                                          fontFamily: "Cairo",
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 30.0, left: 70.0),
                              child: Divider(
                                height: 1.0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: Phone()));
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.edit,
                                      size: 30.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "تعديل الهاتف والدولة",
                                      style: TextStyle(
                                          fontSize: width / 25,
                                          fontFamily: "Cairo",
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 30.0, left: 70.0),
                              child: Divider(
                                height: 1.0,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                deleete();
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_back,
                                      size: 30.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "تسجيل خروج",
                                      style: TextStyle(
                                          fontSize: width / 25,
                                          fontFamily: "Cairo",
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: LoginPage()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.supervised_user_circle,
                                  size: 30.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  "تسجيل دخول",
                                  style: TextStyle(
                                      fontSize: width / 25,
                                      fontFamily: "Cairo",
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color),
                                )
                              ],
                            ),
                          ),
                        ),
            ],
          );
  }
}
