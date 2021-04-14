import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/home/home.dart';
import 'package:eventate/pages/product_list_view/filter.dart';
import 'package:eventate/pages/product_list_view/filter_row.dart';
import 'package:eventate/pages/product_list_view/product_class.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:select_dialog/select_dialog.dart';
import 'dart:convert';
import 'dart:async' show Future, Timer;
import 'package:sizer/sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eventate/pages/product/product.dart';
import 'package:eventate/pages/product_list_view/filter_row.dart';
import 'package:eventate/functions/passDataToProducts.dart';
import 'package:eventate/providers/productsProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eventate/pages/product_list_view/se.dart';
import 'package:eventate/pages/product_list_view/get_function.dart';
import 'package:eventate/pages/product_list_view/one_product.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:eventate/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eventate/pages/product_list_view/product_class.dart';
import 'package:provider/provider.dart';
// My Own Imports
import 'package:eventate/pages/product_list_view/test.dart';
import 'package:eventate/pages/search.dart';

class ProductListView2 extends StatefulWidget {
  int id;
  String type;
  ProductListView2(this.id, this.type);
  @override
  _ProductListView2State createState() => _ProductListView2State();
}

class _ProductListView2State extends State<ProductListView2> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
            "العروض",
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: width / 25,
                  letterSpacing: 1.7,
                  color: Colors.white),
            ),
            // Text(
            //   '37024 ${AppLocalizations.of(context).translate('productListViewPage', 'itemsString')}',
            // style: TextStyle(
            // fontFamily: 'Jost',
            // fontWeight: FontWeight.bold,
            // fontSize: 12.0,
            // letterSpacing: 1.5,
            // color: Colors.white,
            //  ),
            // )
          ],
        ),
        titleSpacing: 0.0,
        actions: <Widget>[
          // IconButton(
          //  icon: Icon(
          //  Icons.search,
          //  ),
          //    onPressed: () {

          //   }),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
            child: IconButton(
              icon: Badge(
                badgeContent: Text(
                  '${Provider.of<PostDataProvider>(context, listen: true).num ?? 0}',
                  style: TextStyle(color: Colors.white),
                ),
                badgeColor: Colors.grey,
                child: Icon(
                  Icons.local_grocery_store_sharp,
                  color: Colors.white,
                  size: 20.0.sp,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        curve: Curves.linear,
                        duration: Duration(milliseconds: 900),
                        type: PageTransitionType.bottomToTop,
                        child: Home(2)));
              },
            ),
          ),
        ],
      ),
      body: Container(child: GetProducts(widget.id, widget.type)),
    );
  }
}
