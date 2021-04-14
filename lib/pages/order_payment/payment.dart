import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/home/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:eventate/config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eventate/pages/product_list_view/get_function.dart';
import 'package:eventate/pages/order_payment/visa.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

//final String baseUrl = "https://api.myfatoorah.com";

// You can get the API Key for regular payment or direct payment and recurring from here:
// https://myfatoorah.readme.io/docs/demo-information
//final String mAPIKey =
  //  "bearer mzVLXxiwdZTWCAAfy6AOVB_3mIZ0zIox7n8y7Rvj1xxTKPPO6rTPW2oSWSceYl-62vRVehkAvw40jbgHsJSgjE4JSoV3wWfBkieQ59jht_-wYdwRhB37Z65ZzGjHnGOX3StEzwJFfJ7P5XDe4oMGz32Vcw9qehaRccwna_ZdmOVrysHYOSBC95CJtofAMcjVqZ3fDDApx6H6Jbg95Mq9jWLDOtdbI7cD54XfxpO5t1uVtKo4Zf0s0mQs1xSvEd9GG3FSfh1N8gMTBk0R35x05xp9RZbqHtNsEWop34G1cdpT3CiOwTTcvFoBpUgEw6shLEGc7qzLB7YD5ryiD3di-SLfuY2DtaCadG9uWnAfa3kJzwzNfts82fQgGVQDEa-ZZ0bU2RF5wd49VnhmZCMwodgnQ12JnuvmjVUtgOgALVGVqugF3m-K2WWTXtKC21VwoisVveNPydrU0qF9HlEirVFWC8m_wZJhUSa4GIHHND5quokUiQBrTPRb_CObeGNgI3Y2sRKiOHHuC3aB77jW0JQIfvBOthBKekIs9lKmjjHk-nwmoY_I1Q-wcM7oRkMiK6hohia47wRfDwWaqXzU1K0ZkKtybdd3Bc6KPgXsvfmsTbNF7KZSqkIRMX32OkiZJHAj8IwVYAobERwM8wzbwEvl5asnJ2kAFWbxTkgAnASEFYj5lTQxMP8wCddrKEVNIK6PAUclNyaEHAhancPdv8LC6L4";

// Base Url test
final String baseUrl = "https://apitest.myfatoorah.com";

// You can get the API Key for regular payment or direct payment and recurring from here: test
// https://myfatoorah.readme.io/docs/demo-information
final String mAPIKey = "bearer Tfwjij9tbcHVD95LUQfsOtbfcEEkw1hkDGvUbWPs9CscSxZOttanv3olA6U6f84tBCXX93GpEqkaP_wfxEyNawiqZRb3Bmflyt5Iq5wUoMfWgyHwrAe1jcpvJP6xRq3FOeH5y9yXuiDaAILALa0hrgJH5Jom4wukj6msz20F96Dg7qBFoxO6tB62SRCnvBHe3R-cKTlyLxFBd23iU9czobEAnbgNXRy0PmqWNohXWaqjtLZKiYY-Z2ncleraDSG5uHJsC5hJBmeIoVaV4fh5Ks5zVEnumLmUKKQQt8EssDxXOPk4r3r1x8Q7tvpswBaDyvafevRSltSCa9w7eg6zxBcb8sAGWgfH4PDvw7gfusqowCRnjf7OD45iOegk2iYSrSeDGDZMpgtIAzYVpQDXb_xTmg95eTKOrfS9Ovk69O7YU-wuH4cfdbuDPTQEIxlariyyq_T8caf1Qpd_XKuOaasKTcAPEVUPiAzMtkrts1QnIdTy1DYZqJpRKJ8xtAr5GG60IwQh2U_-u7EryEGYxU_CUkZkmTauw2WhZka4M0TiB3abGUJGnhDDOZQW2p0cltVROqZmUz5qGG_LVGleHU3-DgA46TtK8lph_F9PdKre5xqXe6c5IYVTk4e7yXd6irMNx4D4g1LxuD8HL4sYQkegF2xHbbN8sFy4VSLErkb9770-0af9LT29kzkva5fERMV90w";

class PaymentPage extends StatefulWidget {
  double price;
  String govern;
  String city;
  String address;
  String phone;
  double total;
  double balance;
  var date;

  String name;
  PaymentPage(this.total, this.price, this.phone, this.govern, this.city,
      this.address, this.name, this.balance,this.date);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selectedRadioPayment;
  bool _load = false;
  bool load_intial = true;
  double net = 0.0;
  double remind = 0.0;
  String _response = '';
  String _loading = "Loading...";
  var myPaymentMethods = [];
  void executeRegularPayment() {
    // The value 1 is the paymentMethodId of KNET payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    int paymentMethod = 1;
    print(net);
    var request = new MFExecutePaymentRequest(paymentMethod, net);

    MFSDK.executePayment(
        context,
        request,
        MFAPILanguage.EN,
        (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print(invoiceId);
                    print(result.response.toJson());
                    _response = result.response.toJson().toString();
                    set_orders(invoiceId, "knet");
                  })
                }
              else
                {
                  setState(() {
                    showSimpleNotification(
                        Text(
                          "فشل عملية الدفع حاول مرة اخري",
                          style:
                              TextStyle(fontSize: 12.0.sp, fontFamily: "Cairo"),
                        ),
                        background: Colors.red);
                    print(result.error.toJson());
                    _response = result.error.message;
                    _load = false;
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
  }

  void executeDirectPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Visa(
              widget.total,
              widget.price,
              widget.phone,
              widget.govern,
              widget.city,
              widget.address,
              widget.name,
              (widget.balance - remind),
              net)),
    );
  }

  void initiatePayment() {
    var request = new MFInitiatePaymentRequest(net, MFCurrencyISO.KUWAIT_KWD);

    MFSDK.initiatePayment(
        request,
        MFAPILanguage.EN,
        (MFResult<MFInitiatePaymentResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    load_intial = false;

                    print(result.response.toJson());
                    myPaymentMethods =
                        result.response.toJson()["PaymentMethods"];
                  })
                }
              else
                {
                  setState(() {
                    load_intial = false;

                    print(result.error.toJson());
                    _response = result.error.message;
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
  }

  get_net() {
    double net2 = (widget.total + widget.price) - widget.balance;
    if (net2 == 0) {
      setState(() {
        net = 0.0;
        remind = 0.0;
      });
    }
    if (net2 > 0) {
      setState(() {
        net = net2;
        remind = 0.0;
      });
    }
    if (net2 < 0) {
      setState(() {
        net = 0.0;
        remind = (net2).abs();
      });
    }
    print(widget.name);
    print((widget.balance - remind).toString());
  }

  set_orders(invoiceId, type) async {
    setState(() {
      _load = true;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    var user;
    var d;
    if (tok != null) {
      d = localStorage.getString('user');

      if (d != null) {
        user = jsonDecode(d)["id"];
      } else {
        user = 0;
      }

      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          http.Response response =
              await http.post(Config.url + "add_orders", headers: {
            "Accept": "application/json"
          }, body: {
            "phone": widget.phone,
            "type": type.toString(),
            "inovic_id": invoiceId.toString(),
            "username": widget.name,
            "name": widget.govern,
            "city": widget.city,
            "address": widget.address,
            "token": tok,
            "user_id": user.toString(),
            "price": widget.price.toString(),
            "total": widget.total.toString(),
            "balance": (widget.balance - remind).toString(),
                "date":widget.date.toString(),
          });
          print(response.body);

          if (response.statusCode == 200) {
            // print((widget.balance - remind).toString());

            var res = json.decode(response.body);
            if (res["state"] == "1") {
              Provider.of<PostDataProvider>(context, listen: false)
                  .set_cat_after_api(0);
              showSimpleNotification(
                  Text(
                    "تمت العملية بنجاح  ",
                    style: TextStyle(fontSize: 12.0.sp, fontFamily: "Cairo"),
                  ),
                  background: Colors.green);

              Future.delayed(const Duration(seconds: 2), () {
                if (this.mounted) {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home(1)),
                    );
                  });
                }
              });
            } else {
              showSimpleNotification(
                  Text(
                    "مشكلة بالشبكة اثناء حفظ الطلب في حسابك تواصل مع احفظ رقم الفاتورة وتواصل مع خدمة  العملاء لحل المشكلة كود الفاتورة  ${invoiceId}",
                    style: TextStyle(fontSize: 12.0.sp, fontFamily: "Cairo"),
                  ),
                  background: Colors.green);
            }
          }
        } else {
          showSimpleNotification(
              Text(
                "no internet  ",
                style: TextStyle(fontSize: 12.0.sp, fontFamily: "Cairo"),
              ),
              background: Colors.red);
        }
      } on SocketException {
        showSimpleNotification(
            Text(
              "no internet  ",
              style: TextStyle(fontSize: 12.0.sp, fontFamily: "Cairo"),
            ),
            background: Colors.red);
      }
    } else {
      showSimpleNotification(
          Text(
            'خطأ غير متوقع اغلق التطبيق ثم اعد فتحة من البداية',
            style: TextStyle(fontSize: 12.0.sp, fontFamily: "Cairo"),
          ),
          background: Colors.red);
    }
    if (this.mounted) {
      setState(() {
        _load = false;
      });
    }
  }

  check_orders(execute(), type) async {
    setState(() {
      _load = true;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    var user;
    var d;
    if (tok != null) {
      d = localStorage.getString('user');
      if (d != null) {
        user = jsonDecode(d)["id"];
      } else {
        user = 0;
      }

      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          http.Response response =
              await http.post(Config.url + "check_orders", headers: {
            "Accept": "application/json"
          }, body: {
            "phone": widget.phone,
            "username": widget.name,
            "name": widget.govern,
            "city": widget.city,
            "address": widget.address,
            "token": tok,
            "user_id": user.toString(),
            "price": widget.price.toString(),
            "total": widget.total.toString(),
            "balance": (widget.balance - remind).toString(),
          });

          if (response.statusCode == 200) {
            // print((widget.balance - remind).toString());

            var res = json.decode(response.body);
            if (res["state"] == "1") {
              if (type == "cach" || type == "balance") {
                set_orders(0, type);
              } else {
                if (type == "visa") {
                  setState(() {
                    _load = false;
                  });
                }
                execute();
              }
              print(res);
            } else {
              showSimpleNotification(
                  Text(
                    "${res["msg"]}  ",
                    style: TextStyle(fontSize: 12.0.sp, fontFamily: "Cairo"),
                  ),
                  background: Colors.red);
              setState(() {
                _load = false;
              });
            }
          }
        } else {
          showSimpleNotification(
              Text(
                "no internet  ",
                style: TextStyle(fontSize: 12.0.sp, fontFamily: "Cairo"),
              ),
              background: Colors.red);
          setState(() {
            _load = false;
          });
        }
      } on SocketException {
        showSimpleNotification(
            Text(
              "no internet  ",
              style: TextStyle(fontSize: 12.0.sp, fontFamily: "Cairo"),
            ),
            background: Colors.red);
        setState(() {
          _load = false;
        });
      }
    } else {
      showSimpleNotification(
          Text(
            'خطأ غير متوقع اغلق التطبيق ثم اعد فتحة من البداية',
            style: TextStyle(fontSize: 12.0.sp, fontFamily: "Cairo"),
          ),
          background: Colors.red);
      setState(() {
        _load = false;
      });
    }
  }

  @override
  void initState() {


    super.initState();
    if (mAPIKey.isEmpty) {
      setState(() {
        _response =
            "Missing API Key.. You can get it from here: https://myfatoorah.readme.io/docs/demo-information";
      });
      return;
    }

    // TODO, don't forget to init the MyFatoorah Plugin with the following line



    get_net();
    selectedRadioPayment = 100;
    _load = false;
  }

  setSelectedRadioPayment(int val) {
    if (this.mounted) {
      setState(() {
        selectedRadioPayment = val;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
         "تاكيد الطلب",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Cairo',
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
          Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "سيتم التواصل معك من قبل الادارة",
                  style: TextStyle(
                      fontSize: 11.0.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      height: 1.6),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: height / 9,
                  width: width,
                  child: Center(
                      child: Container(
                    margin: EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {},
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            width: 120.0,
                            height: height / 10,
                            alignment: Alignment.center,
                            child: Text(
                              "  الطلب :  ${widget.total.toStringAsFixed(2)}" +
                                  " KWD",
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                fontFamily: 'Cairo',
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).appBarTheme.color,
                              ),
                            ),
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {},
                          child: Container(
                            color: Colors.black,
                            width: 120.0,
                            height: height / 10,
                            alignment: Alignment.center,
                            child: Text(
                              "  ضريبة وتوصيل :  ${widget.price}" + " KWD",
                              style: TextStyle(
                                fontSize: 9.0.sp,
                                fontFamily: 'Cairo',
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  )),
                ),
                widget.balance != 0.0
                    ? Container(
                        color: Theme.of(context).appBarTheme.color,
                        width: width,
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "  رصيدك  :  ${(widget.balance)}" + " KWD",
                          style: TextStyle(
                            fontSize: 11.0.sp,
                            fontFamily: 'Cairo',
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Divider(
                        height: 1.0,
                      ),
                Divider(
                  height: 1.0,
                ),
                Container(
                  height: height / 10,
                  width: width,
                  child: Center(
                      child: Container(
                    margin: EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {},
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            width: 120.0,
                            height: height / 10,
                            alignment: Alignment.center,
                            child: Text(
                              "  عليك دفع :  ${(net).toStringAsFixed(2)}" +
                                  " KWD",
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                fontFamily: 'Cairo',
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).appBarTheme.color,
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  )),
                ),
                widget.balance != 0.0
                    ? Container(
                        color: Theme.of(context).appBarTheme.color,
                        width: width,
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "  يتبقي من رصيدك  :  ${(remind).toStringAsFixed(2)}" +
                              " KWD",
                          style: TextStyle(
                            fontSize: 11.0.sp,
                            fontFamily: 'Cairo',
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Divider(
                        height: 1.0,
                      ),
                SizedBox(
                  height: 2.0.h,
                ),

                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: !_load
                      ? InkWell(
                          onTap: () {
                            //set_orders  ();
                            if (selectedRadioPayment == 1) {
                              check_orders(executeRegularPayment, "knet");
                            }
                            if (selectedRadioPayment == 2) {
                              check_orders(executeDirectPayment, "visa");
                            }
                            if (selectedRadioPayment == 100) {
                              if (net > 0) {
                                check_orders(executeRegularPayment, "cach");
                              } else {
                                check_orders(executeRegularPayment, "balance");
                              }
                            }
                          },
                          child: Container(
                              width: width - 40.0,
                              padding: EdgeInsets.all(15.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Text(
                                "تأكيد ",
                                style: TextStyle(
                                  color: Theme.of(context).appBarTheme.color,
                                  fontFamily: 'Cairo',
                                  fontSize: width / 24,
                                  letterSpacing: 0.7,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        )
                      : CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // user defined function for Logout Dialogue
  void _showDialog() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 5.0,
          backgroundColor: Theme.of(context).appBarTheme.color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Container(
            height: 250.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Theme.of(context).appBarTheme.color,
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 5.0),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 50.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                net == 0
                    ? Text(
                        "الدفع من رصيدي بالتطبيق",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          letterSpacing: 0.7,
                          fontSize: 11.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)
                            .translate('paymentPage', 'congratulationsString'),
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          letterSpacing: 0.7,
                          fontSize: 11.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                      ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "تم تاكيد الطلب بنجاح",
                  style: TextStyle(
                    fontSize: 11.0.sp,
                    fontFamily: "Cairo",
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (this.mounted) {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home(1)),
          );
        });
      }
    });
  }
}
