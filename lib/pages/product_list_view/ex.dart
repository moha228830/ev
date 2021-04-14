import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future, Timer;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eventate/pages/product/product.dart';
import 'package:eventate/pages/product/product2.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';

import 'package:eventate/pages/product_list_view/product_class.dart';
import 'package:eventate/pages/product_list_view/get_function.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../../helper.dart';

class ProductsGridView extends StatefulWidget {
  var products;
  int num;

  ProductsGridView({Key key, this.products, this.num}) : super(key: key);

  @override
  _ProductsGridViewState createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  set_fav(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setStringList(
        'favorite', Provider.of<HomeProvider>(context, listen: false).favorite);
  }

  InkWell getStructuredGridCell(Product products) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.7.h, horizontal: 0.7.h),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Hero(
                tag: Text("${products.id}"),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 22.5.h,
                      width: 50.0.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(
                            10.0,
                          ),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(products.imgFullPath),
                          fit: BoxFit.fill,
                        ),
                      ),
                      margin: EdgeInsets.all(0.0),
                    ),
                  ],
                ),
              ),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: 12.0.h,
                width: 50.0.w,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      get_by_size(products.name, 20, 18, ".."),
                      style: TextStyle(
                        fontSize: 10.0.sp,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      get_by_size(products.description, 22, 20, ".."),
                      style: TextStyle(
                        fontSize: 9.0.sp,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          //  width:20.0.w ,
                          child: Text(
                            "${products.price} KWD ",
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 10.0.sp,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 7.0.w,
                        ),
                        Container(
                          child: Text(
                            "${products.overPrice} KWD ",
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontSize: 10.0.sp,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(
                      10.0,
                    ),
                  ),
                ),
                height: 5.7.h,
                width: 50.0.w,
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          " ",
                          style: TextStyle(
                              fontSize: 12.0.sp,
                              fontFamily: "Cairo",
                              color: Colors.white),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "إشتري الان",
                          style: TextStyle(
                              fontSize: 10.0.sp,
                              fontFamily: "Cairo",
                              color: Colors.white),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(0.0),
                              bottomLeft: Radius.circular(
                                10.0,
                              ),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .toggel_faforite(products.id);
                              set_fav(context);
                            },
                            child: Center(
                                child: Provider.of<HomeProvider>(context,
                                            listen: true)
                                        .favorite_int
                                        .contains(products.id)
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 25.0.sp,
                                      )
                                    : Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.white,
                                        size: 25.0.sp,
                                      )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        if (products.type == 1) {
          Navigator.push(
              context,
              PageTransition(
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 700),
                  type: PageTransitionType.rightToLeft,
                  child: ProductPage(
                    data: Product(
                      id: products.id,
                      name: products.name,
                      description: products.description,
                      price: products.price,
                      overPrice: products.overPrice,
                      brandId: products.brandId,
                      made: products.made,
                      subCategoryId: products.subCategoryId,
                      categoryId: products.categoryId,
                      qut: products.qut,
                      pay: products.pay,
                      view: products.view,
                      newItem: products.newItem,
                      popular: products.popular,
                      over: products.over,
                      subSubCategoryId: products.subSubCategoryId,
                      img: products.img,
                      activity: products.activity,
                      numItem: products.numItem,
                      imgFullPath: products.imgFullPath,
                      precentage: products.precentage,
                      images: products.images,
                      sizes: products.sizes,
                      type: products.type,
                    ),
                  )));
        } else {
          Navigator.push(
              context,
              PageTransition(
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 700),
                  type: PageTransitionType.rightToLeft,
                  child: ProductPage2(
                      data: Product(
                    id: products.id,
                    name: products.name,
                    description: products.description,
                    price: products.price,
                    overPrice: products.overPrice,
                    brandId: products.brandId,
                    made: products.made,
                    subCategoryId: products.subCategoryId,
                    categoryId: products.categoryId,
                    qut: products.qut,
                    pay: products.pay,
                    view: products.view,
                    newItem: products.newItem,
                    popular: products.popular,
                    over: products.over,
                    subSubCategoryId: products.subSubCategoryId,
                    img: products.img,
                    activity: products.activity,
                    numItem: products.numItem,
                    imgFullPath: products.imgFullPath,
                    precentage: products.precentage,
                    images: products.images,
                    sizes: products.sizes,
                    type: products.type,
                  ))));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return getStructuredGridCell(widget.products);
  }
}
