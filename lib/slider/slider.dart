import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/home/home.dart';
import 'package:page_transition/page_transition.dart';

import 'package:sizer/sizer.dart';

import 'package:eventate/pages/product_list_view/product_class.dart';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:url_launcher/url_launcher.dart';

// My Own Imports

class MySlider extends StatelessWidget {
  final List data;

  MySlider(this.data);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
          SizedBox(
            height: 2.0.h,
          ),

          // Slider and Add to Wishlist Code Starts Here
          Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: 90.0.w,
                  padding: EdgeInsets.only(top: 2.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.color,
                    borderRadius: BorderRadius.circular(0.0),
                    //border: Border.all(color:Colors.grey),
                  ),
                  child: SizedBox(
                    height: (74.0.h),
                    width: width,
                    child: Carousel(
                      images: data
                          .map((title) => InkWell(
                                child: Container(
                                  decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                    image: new NetworkImage(
                                        title["img_full_path"]),
                                    fit: BoxFit.fill,
                                  )),
                                ),
                                onTap: () {
                                  launch("${title["link"]}");
                                },
                              ))
                          .toList(),
                      dotSize: 5.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.grey,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.purple.withOpacity(0.0),
                      boxFit: BoxFit.fill,
                      animationCurve: Curves.decelerate,
                      dotIncreasedColor: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 8.0.h,
          ),
          Container(
            height: 13.0.h,
            color: Colors.white,
            // padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 21.0.h),
            child: Center(
              child: Container(
                height: 8.0.h,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            curve: Curves.linear,
                            duration: Duration(milliseconds: 400),
                            type: PageTransitionType.bottomToTop,
                            child: Home(0)));
                  },
                  child: Center(
                    child: Container(
                      width: 70.0.w,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                          child: Text(
                        "تخطي",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Cairo",
                            fontSize: 14.0.sp),
                      )),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Slider and Add to Wishlist Code Ends Here

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
    );
  }
}
