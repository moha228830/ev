import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter/material.dart';
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

final String baseUrl = "https://api.myfatoorah.com";

// You can get the API Key for regular payment or direct payment and recurring from here:
// https://myfatoorah.readme.io/docs/demo-information
final String mAPIKey =
    "bearer mzVLXxiwdZTWCAAfy6AOVB_3mIZ0zIox7n8y7Rvj1xxTKPPO6rTPW2oSWSceYl-62vRVehkAvw40jbgHsJSgjE4JSoV3wWfBkieQ59jht_-wYdwRhB37Z65ZzGjHnGOX3StEzwJFfJ7P5XDe4oMGz32Vcw9qehaRccwna_ZdmOVrysHYOSBC95CJtofAMcjVqZ3fDDApx6H6Jbg95Mq9jWLDOtdbI7cD54XfxpO5t1uVtKo4Zf0s0mQs1xSvEd9GG3FSfh1N8gMTBk0R35x05xp9RZbqHtNsEWop34G1cdpT3CiOwTTcvFoBpUgEw6shLEGc7qzLB7YD5ryiD3di-SLfuY2DtaCadG9uWnAfa3kJzwzNfts82fQgGVQDEa-ZZ0bU2RF5wd49VnhmZCMwodgnQ12JnuvmjVUtgOgALVGVqugF3m-K2WWTXtKC21VwoisVveNPydrU0qF9HlEirVFWC8m_wZJhUSa4GIHHND5quokUiQBrTPRb_CObeGNgI3Y2sRKiOHHuC3aB77jW0JQIfvBOthBKekIs9lKmjjHk-nwmoY_I1Q-wcM7oRkMiK6hohia47wRfDwWaqXzU1K0ZkKtybdd3Bc6KPgXsvfmsTbNF7KZSqkIRMX32OkiZJHAj8IwVYAobERwM8wzbwEvl5asnJ2kAFWbxTkgAnASEFYj5lTQxMP8wCddrKEVNIK6PAUclNyaEHAhancPdv8LC6L4";

// Base Url test
//final String baseUrl = "https://apitest.myfatoorah.com";

// You can get the API Key for regular payment or direct payment and recurring from here: test
// https://myfatoorah.readme.io/docs/demo-information
//final String mAPIKey = "bearer Tfwjij9tbcHVD95LUQfsOtbfcEEkw1hkDGvUbWPs9CscSxZOttanv3olA6U6f84tBCXX93GpEqkaP_wfxEyNawiqZRb3Bmflyt5Iq5wUoMfWgyHwrAe1jcpvJP6xRq3FOeH5y9yXuiDaAILALa0hrgJH5Jom4wukj6msz20F96Dg7qBFoxO6tB62SRCnvBHe3R-cKTlyLxFBd23iU9czobEAnbgNXRy0PmqWNohXWaqjtLZKiYY-Z2ncleraDSG5uHJsC5hJBmeIoVaV4fh5Ks5zVEnumLmUKKQQt8EssDxXOPk4r3r1x8Q7tvpswBaDyvafevRSltSCa9w7eg6zxBcb8sAGWgfH4PDvw7gfusqowCRnjf7OD45iOegk2iYSrSeDGDZMpgtIAzYVpQDXb_xTmg95eTKOrfS9Ovk69O7YU-wuH4cfdbuDPTQEIxlariyyq_T8caf1Qpd_XKuOaasKTcAPEVUPiAzMtkrts1QnIdTy1DYZqJpRKJ8xtAr5GG60IwQh2U_-u7EryEGYxU_CUkZkmTauw2WhZka4M0TiB3abGUJGnhDDOZQW2p0cltVROqZmUz5qGG_LVGleHU3-DgA46TtK8lph_F9PdKre5xqXe6c5IYVTk4e7yXd6irMNx4D4g1LxuD8HL4sYQkegF2xHbbN8sFy4VSLErkb9770-0af9LT29kzkva5fERMV90w";

class Visa extends StatefulWidget {
  double price;
  String govern;
  String city;
  String address;
  String phone;
  double total;
  double balance;
  var net;

  String name;
  Visa(this.total, this.price, this.phone, this.govern, this.city, this.address,
      this.name, this.balance, this.net);
  @override
  State<StatefulWidget> createState() {
    return VisaState();
  }
}

class VisaState extends State<Visa> {
  String cardNumber = '';
  String expiryDate = '';
  String expirymonth = '';
  List date;
  String expiryyear = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool _load = false;
  String _response = '';
  String _loading = "Loading...";
  void executeDirectPayment() {
    // The value 2 is the paymentMethodId of Visa/Master payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    int paymentMethod = 2;

    var request = new MFExecutePaymentRequest(paymentMethod, widget.net);

//    var mfCardInfo = new MFCardInfo(cardToken: "Put your token here");

    var mfCardInfo = new MFCardInfo(
        cardNumber: cardNumber,
        expiryMonth: expirymonth,
        expiryYear: expiryyear,
        securityCode: cvvCode.toString(),
        cardHolderName: cardHolderName.toString(),
        bypass3DS: true,
        saveToken: true);

    MFSDK.executeDirectPayment(
        context,
        request,
        mfCardInfo,
        MFAPILanguage.EN,
        (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print(invoiceId);
                    print(result.response.toJson());
                    set_orders(invoiceId, "visa");
                  })
                }
              else
                {
                  setState(() {
                    _response = result.error.message;
                    showSimpleNotification(
                        Text(
                          _response,
                          style:
                              TextStyle(fontSize: 12.0.sp, fontFamily: "Cairo"),
                        ),
                        background: Colors.red);
                    print(result.error.toJson());

                    _load = false;
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
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
            "balance": (widget.balance).toString(),
          });

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

  @override
  void initState() {
    MFSDK.init(baseUrl, mAPIKey);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Text(
            " Visa and Master Card",
            style: TextStyle(color: Colors.black),
          ),
          titleSpacing: 0.0,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ),
              ),
              !_load
                  ? InkWell(
                      onTap: () {
                        if (cardNumber == "" ||
                            cvvCode == "" ||
                            expiryyear == "" ||
                            cardHolderName == "") {
                          showSimpleNotification(
                              Text(
                                "اكمل البيانات",
                                style: TextStyle(
                                    fontSize: 12.0.sp, fontFamily: "Cairo"),
                              ),
                              background: Colors.red);
                        } else {
                          setState(() {
                            _load = true;

                            date = expiryDate.split("/");
                            expirymonth = date[0].toString();
                            expiryyear = date[1].toString();
                            cardNumber = cardNumber.replaceAll(' ', '');
                            print(cardNumber);
                            print(expiryyear);
                            executeDirectPayment();
                          });
                        }
                      },
                      child: Container(
                          width: width,
                          padding: EdgeInsets.all(15.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          child: Text(
                            "دفع ",
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
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
