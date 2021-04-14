import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/home/home.dart';
import 'package:eventate/pages/product/releted.dart';
import 'package:eventate/pages/product_list_view/get_function.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:eventate/providers/productsProvider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:select_dialog/select_dialog.dart';
import 'package:sizer/sizer.dart';
import '../../helper.dart';

import 'package:eventate/pages/product_list_view/product_class.dart';
import 'package:eventate/pages/search.dart';
import 'package:page_transition/page_transition.dart';
import 'package:eventate/pages/product/previw.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eventate/config.dart';
import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

// My Own Imports

class ProductPage2 extends StatefulWidget {
  final Product data;

  ProductPage2({Key key, this.data}) : super(key: key);

  @override
  _ProductPage2State createState() => _ProductPage2State();
}

class _ProductPage2State extends State<ProductPage2> {
  set_fav(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setStringList(
        'favorite', Provider.of<HomeProvider>(context, listen: false).favorite);
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool favourite = false;
  int cartItem = 3;
  bool is_laad = false;
  var total;

  int qut = 1;

  coounter_increment() {
    setState(() {
      qut = qut + 1;
      total = widget.data.overPrice * qut;
    });
  }

  coounter_decrement() {
    setState(() {
      if (qut > 1) {
        qut = qut - 1;
      }
      total = widget.data.overPrice * qut;
    });
  }

  Map map = {};

  @override
  void initState() {
    total = widget.data.overPrice;
    super.initState();
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////
  add_to_cart() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    var user_id = localStorage.getString('user_id') ?? 0;
    if (tok != null) {
      if (qut == 0) {
        Fluttertoast.showToast(
          msg: 'قم بتحديد الكمية',
          backgroundColor: Theme.of(context).textTheme.headline6.color,
          textColor: Theme.of(context).appBarTheme.color,
        );
      } else {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            http.Response response =
                await http.post(Config.url + "add_carts", headers: {
              "Accept": "application/json"
            }, body: {
              "token": tok,
              "item_id": widget.data.id.toString(),
              "qut": qut.toString(),
              "type": widget.data.type.toString(),
            });

            if (response.statusCode == 200) {
              var $res = json.decode(response.body);
              if ($res["state"] == "1") {
                Provider.of<PostDataProvider>(context, listen: false)
                    .set_cat_after_api($res["data"]);

                Alert(
                  context: context,
                  type: AlertType.warning,
                  style: AlertStyle(
                    titleStyle: TextStyle(
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                        color: Colors.indigo),
                    descStyle: TextStyle(
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo"),
                  ),
                  title: "نجاح العملية",
                  desc: "تمت الاضافة الي عربة التسوق بنجاح.",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "الذهاب للشراء",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0.sp,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: Home(2)));
                      },
                      color: Colors.green,
                    ),
                    DialogButton(
                      child: Text(
                        "مواصلة التسوق",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0.sp,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.red,
                    ),
                  ],
                ).show();
              } else if ($res["state"] == "4") {
                showSimpleNotification(
                    Text(
                      "${$res["msg"]} ",
                      style: TextStyle(fontSize: 12.0.sp, fontFamily: "Cairo"),
                    ),
                    background: Colors.red);
              } else {
                showSimpleNotification(
                    Text(
                      "خطأ حاول مرة اخري ",
                      style: TextStyle(fontSize: 12.0.sp, fontFamily: "Cairo"),
                    ),
                    background: Colors.red);
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
        is_laad = false;
      });
    }
    //print(map);
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color color = Theme.of(context).textTheme.headline6.color;
    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          // Slider and Add to Wishlist Code Starts Here
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          curve: Curves.linear,
                          duration: Duration(milliseconds: 900),
                          type: PageTransitionType.bottomToTop,
                          child: PreviwPage(
                            widget.data.images,
                          )));
                },
                child: Container(
                  width: width,
                  padding: EdgeInsets.only(top: 2.0),
                  color: Theme.of(context).appBarTheme.color,
                  child: SizedBox(
                    height: (60.0.h),
                    width: width,
                    child: Carousel(
                      images: widget.data.images
                          .map((title) => NetworkImage(title["img_full_path"]))
                          .toList(),
                      dotSize: 5.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.grey,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.purple.withOpacity(0.0),
                      boxFit: BoxFit.fitHeight,
                      animationCurve: Curves.decelerate,
                      dotIncreasedColor: Colors.red,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20.0,
                right: 20.0,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.red,
                        size: 20.0.sp,
                      )),
                ),
              ),
              Positioned(
                top: 20.0,
                left: 20.0,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).appBarTheme.color,
                  elevation: 3.0,
                  onPressed: () {
                    Provider.of<HomeProvider>(context, listen: false)
                        .toggel_faforite(widget.data.id);
                    set_fav(context);
                  },
                  child: Icon(
                    Provider.of<HomeProvider>(context, listen: true)
                            .favorite_int
                            .contains(widget.data.id)
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color:Colors.red,
                  ),
                ),
              ),
            ],
          ),
          // Slider and Add to Wishlist Code Ends Here

          Divider(
            height: 1.0,
          ),
          SizedBox(
            height: 1.0.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.7.h, horizontal: 0.7.h),
            decoration: new BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(0.0),
                  topRight: const Radius.circular(0.0),
                )),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Product Title Start Here

                      // Product Title End Here

                      // Special Price badge Start Here

                      // Special Price badge Ends Here.

                      Row(
                        children: <Widget>[
                          Expanded(child: Text(" ")),
                          Expanded(
                            flex: 5,
                            child: Text(
                              '${widget.data.name}',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                                letterSpacing: 0.7,
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Text(
                                  '${widget.data.price} KWD',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                      fontSize: width / 25,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey),
                                ),
                                Text(
                                  '${widget.data.overPrice} KWD',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontSize: width / 24,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: Text(" ")),
                        ],
                      ),

                      SizedBox(
                        height: 1.0.h,
                      ),

                      Center(
                        child: Text(
                          '${widget.data.description} ',
                          style: TextStyle(
                              fontSize: 10.0.sp,
                              fontFamily: "Cairo",
                              color:
                                  Theme.of(context).textTheme.headline6.color),
                        ),
                      ),

                      // Price & Offer Row Ends Here

                      // Rating Row Starts Here
                      // RatingRow(),
                      // Rating Row Ends Here
                    ],
                  ),
                ),

                // Product Size & Color Start Here
                //  P
                //  roductSize(),

                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 20),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.blue[700])   ,

                        // color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [],
                      ),
                      width: 40.0.w,
                      // padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: coounter_increment,
                            child: Container(
                              width: 10.0.w,
                              height: 6.0.h,
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.7.h, horizontal: 0.7.h),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.0),
                                  topRight: Radius.circular(
                                    20.0,
                                  ),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1.5,
                                    color: Colors.grey[200],
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.add,
                                size: 20.0.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            width: 13.0.w,
                            height: 6.0.h,
                            padding: EdgeInsets.symmetric(
                                vertical: 0.7.h, horizontal: 0.7.h),
                            decoration: BoxDecoration(
                              //border: Border.all(color: Colors.blue[700])   ,
                              color: Theme.of(context).primaryColor,

                              // color: Colors.lightBlue,
                              // borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1.5,
                                  color: Colors.grey[200],
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              qut.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Cairo",
                                  fontSize: 13.0.sp),
                            )),
                          ),
                          InkWell(
                            onTap: coounter_decrement,
                            child: Container(
                              width: 10.0.w,
                              height: 6.0.h,
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.7.h, horizontal: 0.7.h),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Theme.of(context).primaryColor,

                                // color: Colors.lightBlue,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  topLeft: Radius.circular(
                                    20.0,
                                  ),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1.5,
                                    color: Colors.grey[200],
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: Icon(Icons.remove_outlined,
                                      size: 20.0.sp, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            width: width,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "عروض اخري",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Releted(
                    Provider.of<ProductsProvider>(context, listen: false)
                        .releted,
                    widget.data.id),
              ],
            ),
          ),

          // Product Size & Color End Here

          // Product Details Start Her
          //product detils  ////////////////////////////////////

          //endproduct detils  ////////////////////////////////////

          // Product Details Ends Here

          // Product Description Start Here

          // Product Description Ends Here
          ////////////////////////////////////////////////////////////////////////////////////

          // Similar Product Starts Here

          // Similar Product Ends Here
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 5.0,
        child: Container(
          color: Colors.white,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                minWidth: 60.0.w,
                height: 7.0.h,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0.h, horizontal: 0.0.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 0.7.h, horizontal: 2.0.w),
                    color: Colors.black,
                    child: InkWell(
                      child: is_laad
                          ? CircularProgressIndicator()
                          : Text(
                              "اضف الي حقيبة التسوق ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.0.sp,
                                fontFamily: 'Cairo',
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      onTap: () {
                        if (is_laad == false) {
                          if (this.mounted) {
                            setState(() {
                              is_laad = true;
                            });
                          }
                          // _displaySnackBarAddToCart(context);
                          add_to_cart();
                        }
                      },
                    ),
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: 40.0.w,
                height: 7.0.h,
                child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 0.7.h, horizontal: 2.0.w),
                    width: 40.0.w,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.7.h, horizontal: 4.0.w),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "${total.toStringAsFixed(2)}" + "  د.كـ ",
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 11.0.sp,
                              color: Colors.white),
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _displaySnackBarAddToCart(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
      AppLocalizations.of(context)
          .translate('productPage', 'addedToCartString'),
      style: TextStyle(fontSize: width / 25),
    )));
  }

  void _productDescriptionModalBottomSheet(context, data) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).appBarTheme.color,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate(
                              'productPage', 'productDescriptionString'),
                          style: TextStyle(
                            fontSize: width / 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Divider(
                          height: 1.0,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          data,
                          style: TextStyle(
                            fontSize: width / 25,
                            fontWeight: FontWeight.bold,
                            height: 1.45,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                          // overflow: TextOverflow.ellipsis,
                          // maxLines: 5,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
