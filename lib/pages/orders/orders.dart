import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:eventate/config.dart';
import 'package:eventate/pages/orders/items.dart';
import 'package:sizer/sizer.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

// My Own Import
import 'package:eventate/pages/home/home.dart';
import 'package:eventate/pages/orders/fatora.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List cartItemList = [];
  int cartItem = 0;
  var total = 0.00;
  bool _load = true;
  bool progres = false;
  Map map = {};
  bool set_num = false;

  check_fatora(type, status) {
    if (type == "cach") {
      if (status != 3) {
        return false;
      }
    } else {
      return true;
    }
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////

  get_carts() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    var user = localStorage.getString('user_id');
    if (tok != null) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          http.Response response =
              await http.post(Config.url + "my_orders", headers: {
            "Accept": "application/json"
          }, body: {
            "token": tok,
            "user_id": user,
          });

          print(response.body);

          if (response.statusCode == 200) {
            var res = json.decode(response.body);
            if (res["state"] == "1") {
              if (this.mounted) {
                setState(() {
                  cartItemList = res["data"];
                  cartItem = cartItemList.length;

                  _load = false;
                });
              }
              print(cartItemList.length);

              //  print(tok);

            } else {
              Fluttertoast.showToast(
                msg: '${res["msg"]}',
                backgroundColor: Theme.of(context).textTheme.headline6.color,
                textColor: Theme.of(context).appBarTheme.color,
              );
            }
          }
        } else {
          Fluttertoast.showToast(
            msg: 'no internet ',
            backgroundColor: Theme.of(context).textTheme.headline6.color,
            textColor: Theme.of(context).appBarTheme.color,
          );
        }
      } on SocketException {
        Fluttertoast.showToast(
          msg: 'no internet ',
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

  add_to_cart(item_id, color, size, qut, id, newValue) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    if (tok != null) {
      var data = "token=" +
          tok +
          "&item_id=" +
          item_id +
          "&size=" +
          size +
          "&color=" +
          color +
          "&qut=" +
          newValue;
      try {
        if (this.mounted) {
          setState(() {
            progres = true;
          });
        }
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          http.Response response =
              await http.get(Config.url + "add_carts_cart?" + data);

          if (response.statusCode == 200) {
            var $res = json.decode(response.body);
            if ($res["state"] == "1") {
              if (this.mounted) {
                setState(() {
                  _load = true;
                  total = 0.00;
                  get_carts();
                });
              }

              Fluttertoast.showToast(
                msg: ' تمت العملية بنجاح ',
                backgroundColor: Theme.of(context).textTheme.headline6.color,
                textColor: Theme.of(context).appBarTheme.color,
              );
            } else if ($res["state"] == "4") {
              if (this.mounted) {
                setState(() {
                  map[id] = qut;
                  print(qut);
                });
              }
              Fluttertoast.showToast(
                msg: $res["msg"],
                backgroundColor: Theme.of(context).textTheme.headline6.color,
                textColor: Theme.of(context).appBarTheme.color,
              );
            } else {
              if (this.mounted) {
                setState(() {
                  map[id] = qut;
                });
              }
              Fluttertoast.showToast(
                msg: 'خطأ حاول مرة اخري',
                backgroundColor: Theme.of(context).textTheme.headline6.color,
                textColor: Theme.of(context).appBarTheme.color,
              );
            }
          }
        } else {
          Fluttertoast.showToast(
            msg: 'no internet ',
            backgroundColor: Theme.of(context).textTheme.headline6.color,
            textColor: Theme.of(context).appBarTheme.color,
          );
        }
      } on SocketException {
        Fluttertoast.showToast(
          msg: 'no internet ',
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
        _load = false;
        progres = false;
      });
    }
    //print(map);
  }

  ///////////////////////////add to cart

  delete(index) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    if (tok != null) {
      var data = "token=" + tok + "&id=" + index;
      try {
        if (this.mounted) {
          setState(() {
            progres = true;
          });
        }
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          http.Response response =
              await http.get(Config.url + "delet_from_cart?" + data);

          if (response.statusCode == 200) {
            var $res = json.decode(response.body);
            if ($res["state"] == "1") {
              if (this.mounted) {
                setState(() {
                  _load = true;
                  total = 0.00;
                  get_carts();
                });
              }

              Fluttertoast.showToast(
                msg: ' تمت العملية بنجاح ',
                backgroundColor: Theme.of(context).textTheme.headline6.color,
                textColor: Theme.of(context).appBarTheme.color,
              );
            } else if ($res["state"] == "4") {
              Fluttertoast.showToast(
                msg: $res["msg"],
                backgroundColor: Theme.of(context).textTheme.headline6.color,
                textColor: Theme.of(context).appBarTheme.color,
              );
            } else {
              Fluttertoast.showToast(
                msg: 'خطأ حاول مرة اخري',
                backgroundColor: Theme.of(context).textTheme.headline6.color,
                textColor: Theme.of(context).appBarTheme.color,
              );
            }
          }
        } else {
          Fluttertoast.showToast(
            msg: 'no internet ',
            backgroundColor: Theme.of(context).textTheme.headline6.color,
            textColor: Theme.of(context).appBarTheme.color,
          );
        }
      } on SocketException {
        Fluttertoast.showToast(
          msg: 'no internet ',
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
        _load = false;
        progres = false;
      });
    }
    //print(map);
  }

  /////////////////////////////////////////////////////

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    progres = false;
    cartItem;
    set_num;
    get_carts();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: !_load
            ? (cartItem == 0)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/empty_bag.png',
                          height: 170.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "يسعدنا انجاز طلبك الاول ",
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home(0)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  right: 15.0,
                                  left: 15.0),
                              child: Text(
                                "تسوق الان",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'Jost',
                                  fontSize: 16.0,
                                  letterSpacing: 0.8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: ListView(
                      children: [
                        Container(
                          child: progres
                              ? LinearProgressIndicator(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  valueColor: AlwaysStoppedAnimation(
                                      Colors.purpleAccent),
                                  minHeight: 20,
                                )
                              : null,
                        ),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: cartItemList.length,
                          itemBuilder: (context, index) {
                            final item = cartItemList[index];
                            return Container(
                              alignment: Alignment.center,
                              child: Container(
                                width: (width - 10.0),
                                child: Card(
                                  elevation: 3.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              item["status"] == 1
                                                  ? Container(
                                                      width: width - 50,
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              40, 10, 40, 10),
                                                      color: Colors.black,
                                                      child: Text(
                                                        'جاري تاكيد الطلب ',
                                                        style: TextStyle(
                                                            fontFamily: "Cairo",
                                                            color: Colors.white,
                                                            fontSize:
                                                                width / 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    )
                                                  : item["status"] == 2
                                                      ? Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(40, 10,
                                                                  40, 10),
                                                          color: Colors.red,
                                                          child: Text(
                                                            'تم تاكيد الطلب ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    width / 24,
                                                                fontFamily:
                                                                    "Cairo",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                          ),
                                                        )
                                                      : item["status"] == 3
                                                          ? Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          40,
                                                                          10,
                                                                          40,
                                                                          10),
                                                              color:
                                                                  Colors.green,
                                                              child: Text(
                                                                'انتهاء الطلب',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        "Cairo",
                                                                    fontSize:
                                                                        width /
                                                                            24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                              ),
                                                            )
                                                          : Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          40,
                                                                          10,
                                                                          40,
                                                                          10),
                                                              color:
                                                                  Colors.grey,
                                                              child: Text(
                                                                '   ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        width /
                                                                            24,
                                                                    fontFamily:
                                                                        "Cairo",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                              ),
                                                            ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    'تاريخ الطلب  :',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .color,
                                                        fontSize: width / 24,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${item["date2"]}  ',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .color,
                                                        fontSize: width / 24,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    'التسليم او الحجز  :',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .color,
                                                        fontSize: width / 24,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${item["date"]}  ',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .color,
                                                        fontSize: width / 24,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    'كود الطلب  :',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .color,
                                                        fontSize: width / 24,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'E_${item["id"]} ',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .color,
                                                        fontSize: width / 24,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    'سعر الطلب   :',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .color,
                                                        fontSize: width / 24,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    '${item["price"]}  KWD',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .color,
                                                        fontSize: width / 24,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0,
                                                right: 8.0,
                                                left: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 7,
                                                  child: InkWell(
                                                    onTap: () {
                                                      print(item["items"]);
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type: PageTransitionType
                                                                  .rightToLeft,
                                                              child: Items(item[
                                                                  "items"])));
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color:
                                                        Theme.of(context).primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: !_load
                                                          ? Text(
                                                              "تفاصيل الطلب ",
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .appBarTheme
                                                                    .color,
                                                                fontFamily:
                                                                    "Cairo",
                                                                fontSize:
                                                                    width / 24,
                                                                letterSpacing:
                                                                    0.7,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            )
                                                          : CircularProgressIndicator(
                                                              backgroundColor:
                                                                  Colors.blue,
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(child: Text(" ")),
                                                item["status"] != 1
                                                    ? Expanded(
                                                        flex: 5,
                                                        child: InkWell(
                                                          onTap: () {
                                                            print(
                                                                item["items"]);
                                                            Navigator.push(
                                                                context,
                                                                PageTransition(
                                                                    type: PageTransitionType
                                                                        .rightToLeft,
                                                                    child: Fatora(
                                                                        item[
                                                                            "items"],
                                                                        item)));
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Theme.of(context).primaryColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            child: !_load
                                                                ? Text(
                                                                    "الفاتورة ",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .appBarTheme
                                                                          .color,
                                                                      fontFamily:
                                                                          "Cairo",
                                                                      fontSize:
                                                                          width /
                                                                              24,
                                                                      letterSpacing:
                                                                          0.7,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  )
                                                                : CircularProgressIndicator(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .blue,
                                                                  ),
                                                          ),
                                                        ),
                                                      )
                                                    : Expanded(
                                                        child: Text(" ")),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                          height: 20,
                          child: progres
                              ? LinearProgressIndicator(
                                  backgroundColor:Theme.of(context).primaryColor,
                                  valueColor: AlwaysStoppedAnimation(
                                      Colors.purpleAccent),
                                  minHeight: 20,
                                )
                              : null,
                        ),
                      ],
                    ),
                  )
            : Center(
                child: Container(
                    child: CircularProgressIndicator(), width: 32, height: 32),
              ));
  }
}
