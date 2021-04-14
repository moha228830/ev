import 'package:flutter/material.dart';
import 'dart:async' show Future, Timer;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eventate/config.dart';
import 'package:eventate/pages/product/product2.dart';
import 'package:eventate/pages/product_list_view/product_list_view2.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eventate/pages/product/product.dart';
import 'package:eventate/pages/home/home_component/recommend/new1.dart';
import 'package:eventate/pages/home/home_component/recommend/new2.dart';
import 'package:eventate/pages/home/home_component/recommend/new3.dart';

import 'package:eventate/pages/product_list_view/product_class.dart';
import 'package:eventate/pages/product_list_view/product_list_view.dart';
// My Own Import
import 'package:eventate/pages/home/home_component/category_slider.dart';
import 'package:eventate/pages/home/home_component/deal_of_the_day.dart';
import 'package:eventate/pages/home/home_component/new_main_slider.dart';
import 'package:eventate/pages/home/home_component/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sizer/sizer.dart';

class All extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List over = Provider.of<HomeProvider>(context, listen: false).home_over;
    List popular =
        Provider.of<HomeProvider>(context, listen: false).home_popular;
    List new_item =
        Provider.of<HomeProvider>(context, listen: false).home_new_item;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Main Slider Start
          // MainSlider(),
          NewMainSlider(),
          // Main Slider End
          // SizedBox(height: 5.0,),
          //Divider(),

          // Menu End
          SizedBox(
            height: 1.0.h,
          ),

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
                        "احدث العروض",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  curve: Curves.linear,
                                  duration: Duration(milliseconds: 500),
                                  type: PageTransitionType.rightToLeft,
                                  child: ProductListView2(
                                    1,
                                    "new",
                                  )));
                        },
                        child: Text(
                          "شاهد المزيد ",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.7,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.0.h),

                // get new items
                new_item.length == 0 ? New2(new_item) : New1(new_item),
              ],
            ),
          ),
          // Item Discount End

          // Item Popular Start
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
                        "الاكثر طلبا",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  curve: Curves.linear,
                                  duration: Duration(milliseconds: 500),
                                  type: PageTransitionType.rightToLeft,
                                  child: ProductListView2(
                                    1,
                                    "popular",
                                  )));
                        },
                        child: Text(
                          "شاهد المزيد ",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.7,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                popular.length == 0 ? New2(popular) : New1(new_item),
              ],
            ),
          ),
          // Item Popular End

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
                        "عروض الخصم",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  curve: Curves.linear,
                                  duration: Duration(milliseconds: 500),
                                  type: PageTransitionType.rightToLeft,
                                  child: ProductListView2(
                                    1,
                                    "over",
                                  )));
                        },
                        child: Text(
                          "شاهد المزيد ",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.7,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                over.length == 0 ? New2(over) : New1(over),
              ],
            ),
          ),
         // DealOfTheDay(brands),
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
                        "اخترنا لك",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  curve: Curves.linear,
                                  duration: Duration(milliseconds: 500),
                                  type: PageTransitionType.rightToLeft,
                                  child: ProductListView2(
                                    1,
                                    "popular",
                                  )));
                        },
                        child: Text(
                          "شاهد المزيد ",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.7,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                new_item.length == 0 ? New2(popular) : New3(new_item),
              ],
            ),
          ),

          // New Item Start

          // Recommended Products Start

          // Recommended Products Ends
        ],
      ),
    );
  }
}
