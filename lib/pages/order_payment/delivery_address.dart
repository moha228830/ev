import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/home/home.dart';
import 'package:eventate/pages/order_payment/payment.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:eventate/config.dart';
import 'package:sizer/sizer.dart';

import 'package:shared_preferences/shared_preferences.dart';
// My Own Imports

class Delivery extends StatefulWidget {
  double total;
  Delivery(this.total);

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  var my_phone = "";
  var name = "";
  String govern;
  var login = "0";
  double balance = 0.0;
  // Initially password is obscure
  get_shard() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var d = localStorage.getString('user');
    var my_city = localStorage.getString('city');
    var my_govern = localStorage.getString('govern');
    var my_address = localStorage.getString('address');
    var my_price = localStorage.getString('price');
    if (d != null) {
      my_phone = jsonDecode(d)["phone"] ?? " ";
      name = jsonDecode(d)["name"] ?? " ";
    }

    print(names);
    setState(() {
      _phonecontroller.text = my_phone;
      _namecontroller.text = name;
      login = localStorage.getString('login');
      price = double.parse(my_price);
      govern = my_govern;
      _citycontroller.text = my_city;
      _addresscontroller.text = my_address;

      if (names.contains(my_govern)) {
        _currentSelectedValue = my_govern;
      }
    });
    print(price);
  }

  var _currentSelectedValue;
  final _addresscontroller = TextEditingController();
  final _citycontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _namecontroller = TextEditingController();

  List governs = [];
  int len;
  bool _load = true;
  double price;
  Map map = {};
  List<String> names = [];
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 1),
        lastDate: DateTime(2024));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////
  get_carts() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != "" || token != null) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          http.Response response =
              await http.get(Config.url + "get_governs?token=" + token);

          if (response.statusCode == 200) {
            var res = json.decode(response.body);
            if (res["state"] == "1") {
              if (this.mounted) {
                setState(() {
                  governs = res["data"];
                  balance = res["msg"].toDouble();
                  // print(governs);
                  len = governs.length;
                  for (int i = 0; i < len; i++) {
                    names.add(governs[i]["name"]);
                    map[governs[i]["name"]] = governs[i]["price"];
                    if (names.contains(govern)) {
                      _currentSelectedValue = govern;
                    }
                  }
                });
              }
              //print(cartItemList.length);

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
        msg: 'اغلق التطبيق ثم اعد فتحه ',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
    }

    if (this.mounted) {
      setState(() {
        _load = false;
      });
    }
  }

  go_pay() {
    print("_namecontroller.text");
    if (_currentSelectedValue == "" ||
        _citycontroller.text == "" ||
        _addresscontroller.text == "" ||
        _namecontroller.text == "" ||
        _phonecontroller.text == "") {
      Fluttertoast.showToast(
        msg: 'اكمل البيانات ',
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    get_shard();
    _load = true;
    get_carts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "التوصيل و الحجز",
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
            fontSize: width / 24,
            letterSpacing: 1.7,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 0.0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          !_load
              ? Container(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "العنوان وتاريخ التوصيل او الحجز",
                          style: TextStyle(
                              fontSize: 12.0.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              height: 1.6),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        login != "2"
                            ? ////////////////////////////////////////////////////////////////////////////////////////////////////
                            Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: TextField(
                                      controller: _namecontroller,
                                      decoration: new InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(12.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Colors.purple)),
                                          fillColor: Colors.white,
                                          hintText: "الاسم",
                                          labelText: "الاسم"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 26.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: TextField(
                                      controller: _phonecontroller,
                                      keyboardType: TextInputType.number,
                                      decoration: new InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(12.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Colors.purple)),
                                          fillColor: Colors.white,
                                          hintText: "الهاتف",
                                          labelText: "الهاتف"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 26.0,
                                  ),
                                ],
                              )
                            : SizedBox(
                                height: 26.0,
                              ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: new InputDecoration(
                                    contentPadding: const EdgeInsets.all(12.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.purple)),
                                    fillColor: Colors.white,
                                    hintText: "محافظة/مدينة",
                                    labelText: "محافظة/مدينة"),
                                isEmpty: _currentSelectedValue == null,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: _currentSelectedValue,
                                    isDense: true,
                                    onChanged: (newValue) {
                                      if (this.mounted) {
                                        setState(() {
                                          _currentSelectedValue = newValue;
                                          price = map[newValue].toDouble();
                                          print(price);
                                          state.didChange(newValue);
                                        });
                                      }
                                    },
                                    items: names.map((value) {
                                      return DropdownMenuItem(
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
                          height: 18.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: TextField(
                            controller: _citycontroller,
                            decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.all(12.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.purple)),
                                fillColor: Colors.white,
                                hintText: "منطقة",
                                labelText: "منطقة"),
                          ),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: TextField(
                            controller: _addresscontroller,
                            decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.all(12.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.purple)),
                                fillColor: Colors.white,
                                hintText: "العنوان التفصيلي",
                                labelText:
                                    "قطعة - شارع - بناية  او عمارة وشقة"),
                          ),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: InkWell(

                                  onTap: () => _selectDate(context),
                                  child: Container(

                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey[400])),
                                      child: Center(child: Text('تاريخ التوصيل او الحجز',style: TextStyle(fontFamily: "Cairo",color: Theme.of(context).primaryColor),))),
                                ),
                              ),
                              Expanded(child: Text(" ")),
                              Expanded(
                                flex:4,
                                  child: Text(
                                    "${selectedDate.toLocal()}".split(' ')[0],
                                    style: TextStyle(
                                        fontSize: 12.0.sp, fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),
                                  )),

                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),

                        SizedBox(height: 10.0),
                        SizedBox(
                          height: 40.0,
                        ),
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20.0),
                          child: InkWell(
                            onTap: () {
                              if (go_pay()) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: PaymentPage(
                                            widget.total,
                                            price,
                                            _phonecontroller.text,
                                            _currentSelectedValue,
                                            _citycontroller.text,
                                            _addresscontroller.text,
                                            _namecontroller.text,
                                             balance,
                                            selectedDate.toLocal().toString().split(' ')[0].toString()
                                        )));
                              }
                            },
                            child: Container(
                              width: width - 40.0,
                              padding: EdgeInsets.all(15.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                "حفظ وانتقال ",
                                style: TextStyle(
                                    color: Theme.of(context).appBarTheme.color,
                                    fontFamily: 'Cairo',
                                    letterSpacing: 0.7,
                                    fontSize: width / 25,
                                    fontWeight: FontWeight.bold),
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
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontFamily: 'Cairo',
                              fontSize: 17.0,
                              letterSpacing: 0.7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                  valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),
                  minHeight: 20,
                )),
        ],
      ),
    );
  }
}
