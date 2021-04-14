import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';

import 'package:sizer/sizer.dart';
import '../../helper.dart';

import 'package:eventate/pages/product_list_view/product_class.dart';

import 'package:carousel_pro/carousel_pro.dart';

// My Own Imports

class PreviwPage extends StatelessWidget {
  final List data;

  PreviwPage(this.data);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color color = Theme.of(context).textTheme.headline6.color;
    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[

          Container(height: 5.0.h,),
          // Slider and Add to Wishlist Code Starts Here
          Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: width,
                  padding: EdgeInsets.only(top: 2.0),
                  color: Theme.of(context).appBarTheme.color,
                  child: SizedBox(
                    height: (80.0.h),
                    width: width,
                    child: Carousel(
                      images: data
                          .map((title) => NetworkImage(title["img_full_path"]))
                          .toList(),
                      dotSize: 5.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.grey,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.purple.withOpacity(0.0),
                      boxFit: BoxFit.contain,
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
                        Icons.close,
                        color: Colors.red,
                        size: 23.0.sp,
                      )),
                ),
              ),
            ],
          ),
          // Slider and Add to Wishlist Code Ends Here

          Divider(
            height: 1.0,
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
    );
  }
}
