import 'package:flutter/material.dart';

import 'package:eventate/pages/Category/item_popular.dart';
import 'package:eventate/pages/Category/new_item.dart';
import 'package:eventate/pages/Category/sub_category.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:eventate/pages/product_list_view/test.dart';

import 'dart:async' show Future, Timer;
import 'package:flutter/services.dart' show rootBundle;
import 'package:eventate/functions/passDataToProducts.dart';
import 'package:eventate/pages/product/product.dart';
import 'package:eventate/pages/product_list_view/product_class.dart';
import 'package:eventate/pages/product_list_view/product_list_view.dart';
import 'package:eventate/pages/product_list_view/product_list_view2.dart';

import 'package:shimmer/shimmer.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  List data;

  CategoryPage({Key key, @required this.categoryName, this.data})
      : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List selected = [];
  List subsub = [];
  bool _shimmer = true;
  List over = [];
  List new_item = [];
  List popular = [];
  String cat_name = "اختر الفئة";
  int id;

  get_select_first() {
    print(widget.data[0]["category_id"]);
    widget.data.forEach((value) {
      if (selected.length == 0) {
        selected.add(1);
      } else {
        selected.add(0);
      }
      print(selected);
    });
  }

  get_select(i) {
    widget.data.forEach((value) {
      if (selected.length == i) {
        selected.add(1);
      } else {
        selected.add(0);
      }
      print(selected);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_select_first();
    subsub = widget.data[0]["sub"] ?? [];
    over = widget.data[0]["over"] ?? [];
    popular = widget.data[0]["popular"] ?? [];
    new_item = widget.data[0]["new"] ?? [];
    cat_name = widget.data[0]["name"] ?? [];
    id = widget.data[0]["id"];
    Timer(const Duration(seconds: 2), () {
      if (this.mounted) {
        setState(() {
          _shimmer = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String categoryName = widget.categoryName;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          categoryName,
          style: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.bold,
            fontSize: width / 24,
            letterSpacing: 1.7,
            color: Colors.white,
          ),
        ),
        titleSpacing: 0.0,
      ),
      body: Container(
        color: Theme.of(context).appBarTheme.color,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            // Best for You Start
            //////////////////////////////////////////////////////////////////
            Container(
              width: width,
              height: height / 4.5,
              color: Theme.of(context).appBarTheme.color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
                  ),
                  Container(
                    width: width,
                    height: height / 5.5,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(width: 10.0),
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount:
                              widget.data == null ? 0 : widget.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map cat = widget.data[index];

                            return SingleChildScrollView(
                              child: Row(
                                children: [
                                  SizedBox(width: 10.0),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    height: height / 6.5,
                                    width: width / 3.3,
                                    color: selected[index] == 1
                                        ? Colors.pinkAccent
                                        : null,
                                    child: InkWell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1.5,
                                              color: Colors.grey,
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                cat["img_full_path"]),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        // child: Text(
                                        //  '${cat["name"]}',
                                        //  style: TextStyle(
                                        // fontFamily: 'Jost',
                                        // fontWeight: FontWeight.bold,
                                        //fontSize: width/24,
                                        //   letterSpacing: 1.5,
                                        // color: Colors.white,
                                        // ),
                                        //  ),
                                      ),
                                      onTap: () {
                                        if (this.mounted) {
                                          setState(() {
                                            selected = [];
                                            get_select(index);
                                            subsub = cat["sub"];
                                            over = cat["over"];
                                            new_item = cat["new"];
                                            popular = cat["popular"];
                                            cat_name = cat["name"];
                                            id = cat["id"];
                                            //  print(id);
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Best for You End
            ////////////////////////////////////////////////////////////////////////////

            Divider(
              color: Colors.grey,
            ),
            SizedBox(height: 10.0),

// Item Discount Start
            // Sub Category Start
            Center(
              child: Container(
                width: width,
                height: height / 13,
                color: Theme.of(context).appBarTheme.color,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(width: 10.0),
                    SingleChildScrollView(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductListView(id, "sub"),
                            ),
                          );
                        },
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2.0,
                                  spreadRadius: 1.0,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.fromLTRB(5.0, 0, 5, 0),
                            child: Text(" كل عناصر  ${cat_name}  ",
                                style: TextStyle(
                                    color: Colors
                                        .black, //Theme.of(context).textTheme.headline6.color,
                                    fontSize: width / 24,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: subsub == null ? 0 : subsub.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map cat = subsub[index];

                        return SingleChildScrollView(
                          child: Row(
                            children: [
                              SizedBox(width: 10.0),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductListView(cat["id"], "subsub"),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 2.0,
                                          spreadRadius: 1.0,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    margin: EdgeInsets.fromLTRB(5.0, 0, 5, 0),
                                    child: Text("${cat["name"]}",
                                        style: TextStyle(
                                            color: Colors
                                                .black, //Theme.of(context).textTheme.headline6.color,
                                            fontSize: width / 24,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 10.0),
                  ],
                ),
              ),
            ),
            // Sub Category End
            SizedBox(width: 10.0),

            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              color: Colors.blueGrey,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
                child: Text(
                  " كل منتجات  ${categoryName}",
                  style: TextStyle(
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.bold,
                    fontSize: width / 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Card(
              child: Container(
                  width: width - 10,
                  child: GetProducts(widget.data[0]["category_id"], "all")),
            ),
          ],
        ),
      ),
    );
  }
}

class Products {
  int productId;
  String productImage;
  String productTitle;
  String productPrice;
  String productOldPrice;
  String offerText;
  String uniqueId;

  Products(this.productId, this.productImage, this.productTitle,
      this.productPrice, this.productOldPrice, this.offerText, this.uniqueId);
}
