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
        margin: EdgeInsets.symmetric(vertical: 0.75.h, horizontal: 0.1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0.0),
          //  border: Border.all(color: Colors.white,),
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
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(
                            0.0,
                          ),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(products.imgFullPath),
                          fit: BoxFit.fill,
                        ),
                      ),
                      margin: EdgeInsets.all(0.0),
                    ),
                    Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: InkWell(
                        onTap: () {
                          Provider.of<HomeProvider>(context, listen: false)
                              .toggel_faforite(products.id);
                          set_fav(context);
                        },
                        child: Container(
                            padding: EdgeInsets.all(2.0),
                            margin: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child:
                                Provider.of<HomeProvider>(context, listen: true)
                                        .favorite_int
                                        .contains(products.id)
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.pinkAccent,
                                        size: 16.0.sp,
                                      )
                                    : Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.pinkAccent,
                                        size: 16.0.sp,
                                      )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: 10.5.h,
                width: 48.0.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      " " + get_by_size(products.name, 23, 23, ".."),
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
                      " " + get_by_size(products.description, 25, 25, ".."),
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
                    // SizedBox(height: 1.0.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 0.5.w,
                        ),
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
                          width: 3.0.w,
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
