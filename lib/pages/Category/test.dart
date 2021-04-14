import 'package:flutter/material.dart';

import 'package:eventate/pages/Category/item_popular.dart';
import 'package:eventate/pages/Category/new_item.dart';
import 'package:eventate/pages/Category/sub_category.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future, Timer;
import 'package:flutter/services.dart' show rootBundle;
import 'package:eventate/functions/passDataToProducts.dart';
import 'package:eventate/pages/product/product.dart';
import 'package:eventate/pages/product_list_view/product_class.dart';
import 'package:eventate/pages/product_list_view/product_list_view.dart';
import 'package:shimmer/shimmer.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  var data;

  CategoryPage({Key key, @required this.categoryName, this.data})
      : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List subsub = [];
  bool _shimmer = true;
  List over = [];
  List new_item = [];
  List popular = [];
  String cat_name = "اختر الفئة";
  int id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: ListView(
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
                        itemCount: widget.data == null ? 0 : widget.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map cat = widget.data[index];

                          return SingleChildScrollView(
                            child: Row(
                              children: [
                                SizedBox(width: 10.0),
                                Container(
                                  height: height / 6.5,
                                  width: width / 3.3,
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
                  Container(
                    color: Colors.pinkAccent,
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.fromLTRB(10.0, 0, 10, 0),
                    child: Text(" ${cat_name} ",
                        style: TextStyle(
                            color: Colors
                                .white, //Theme.of(context).textTheme.headline6.color,
                            fontSize: width / 24,
                            fontWeight: FontWeight.bold)),
                  ),
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
                          child: Text(" الكل ",
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
                                  padding: EdgeInsets.all(10.0),
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

          // Item Discount Start
          Container(
            width: width,
            height: height / 2.2,
            color: Theme.of(context).appBarTheme.color,
            child: Column(
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
                        " وصل حديثا",
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: width / 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                (_shimmer)
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.white,
                        child: Container(
                          height: height / 2.7,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: new_item.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                Map cat = new_item[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: InkWell(
                                    child: Container(
                                      margin: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).appBarTheme.color,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 0.7,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Hero(
                                              tag: Text("${cat["id"]}"),
                                              child: Stack(
                                                children: <Widget>[
                                                  Container(
                                                    height: height / 4,
                                                    width: width / 1.8,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      image: DecorationImage(
                                                        image: NetworkImage(cat[
                                                            "img_full_path"]),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    margin: EdgeInsets.all(6.0),
                                                  ),
                                                  Positioned(
                                                    top: 0.0,
                                                    left: 0.0,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      margin:
                                                          EdgeInsets.all(6.0),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.pinkAccent,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                            10.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Text(
                                                          "${cat["precentage"]} - %",
                                                          style: TextStyle(
                                                            fontSize:
                                                                width / 28,
                                                            color: Colors.white,
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(
                                                  right: 6.0, left: 6.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    cat["name"],
                                                    style: TextStyle(
                                                      fontSize: width / 25,
                                                      fontFamily: 'Jost',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 0.6,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .color,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        "${cat["over_price"]} KW ",
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        style: TextStyle(
                                                          fontSize: width / 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6
                                                                  .color,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        width: 7.0,
                                                      ),
                                                      Text(
                                                        "${cat["price"]} KW ",
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        style: TextStyle(
                                                            fontSize:
                                                                width / 30,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: Colors.grey),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.center,
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
                                    onTap: () {},
                                  ),
                                );
                              }),
                        ),
                      )
                    : Container(
                        height: height / 2.7,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: new_item.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              Map cat = new_item[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: InkWell(
                                  child: Container(
                                    margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).appBarTheme.color,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 0.7,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          Hero(
                                            tag: Text("${cat["id"]}"),
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  height: height / 4,
                                                  width: width / 1.8,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          cat["img_full_path"]),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  margin: EdgeInsets.all(6.0),
                                                ),
                                                Positioned(
                                                  top: 0.0,
                                                  left: 0.0,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    margin: EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.pinkAccent,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                          10.0,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                        "${cat["precentage"]} - %",
                                                        style: TextStyle(
                                                          fontSize: width / 28,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                right: 6.0, left: 6.0),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  cat["name"],
                                                  style: TextStyle(
                                                    fontSize: width / 25,
                                                    fontFamily: 'Jost',
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0.6,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .color,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "${cat["over_price"]} KW ",
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: TextStyle(
                                                        fontSize: width / 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .color,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      width: 7.0,
                                                    ),
                                                    Text(
                                                      "${cat["price"]} KW ",
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: TextStyle(
                                                          fontSize: width / 30,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: Colors.grey),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
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
                                    if (cat["type"] == 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductPage(
                                            data: Product(
                                              id: cat["id"],
                                              name: cat["name"],
                                              description: cat["description"],
                                              price: cat["price"].toDouble(),
                                              overPrice:
                                                  cat["over_price"].toDouble(),
                                              brandId: cat["brand_id"],
                                              made: cat["made"],
                                              subCategoryId:
                                                  cat["subCategory_id"],
                                              categoryId: cat["category_id"],
                                              qut: cat["qut"],
                                              pay: cat["pay"],
                                              view: cat["view"],
                                              newItem: cat["new"],
                                              popular: cat["popular"],
                                              over: cat["over"],
                                              subSubCategoryId:
                                                  cat["subSubCategory_id"],
                                              img: cat["img"],
                                              activity: cat["activity"],
                                              numItem: cat["new"],
                                              imgFullPath: cat["img_full_path"],
                                              precentage: cat["precentage"],
                                              images: cat["images"],
                                              sizes: cat["sizes"],
                                              type: cat["type"],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {}
                                  },
                                ),
                              );
                            }),
                      ),
              ],
            ),
          ),
          // Item Discount End

          SizedBox(height: 10.0),

          // Item Popular Start
          Container(
            width: width,
            height: height / 2.2,
            color: Theme.of(context).appBarTheme.color,
            child: Column(
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
                        "الاكثر مبيعا",
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: width / 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                (_shimmer)
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.white,
                        child: Container(
                          height: height / 2.7,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: popular.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                Map cat = popular[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: InkWell(
                                    child: Container(
                                      margin: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).appBarTheme.color,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 0.7,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Hero(
                                              tag: Text("${cat["id"]}"),
                                              child: Stack(
                                                children: <Widget>[
                                                  Container(
                                                    height: height / 4,
                                                    width: width / 1.8,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      image: DecorationImage(
                                                        image: NetworkImage(cat[
                                                            "img_full_path"]),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    margin: EdgeInsets.all(6.0),
                                                  ),
                                                  Positioned(
                                                    top: 0.0,
                                                    left: 0.0,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      margin:
                                                          EdgeInsets.all(6.0),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.pinkAccent,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                            10.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Text(
                                                          "${cat["precentage"]} - %",
                                                          style: TextStyle(
                                                            fontSize:
                                                                width / 28,
                                                            color: Colors.white,
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(
                                                  right: 6.0, left: 6.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    cat["name"],
                                                    style: TextStyle(
                                                      fontSize: width / 25,
                                                      fontFamily: 'Jost',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 0.6,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .color,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        "${cat["over_price"]} KW ",
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        style: TextStyle(
                                                          fontSize: width / 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6
                                                                  .color,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        width: 7.0,
                                                      ),
                                                      Text(
                                                        "${cat["price"]} KW ",
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        style: TextStyle(
                                                            fontSize:
                                                                width / 30,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: Colors.grey),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.center,
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
                                    onTap: () {},
                                  ),
                                );
                              }),
                        ),
                      )
                    : Container(
                        height: height / 2.7,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: popular.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              Map cat = popular[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: InkWell(
                                  child: Container(
                                    margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).appBarTheme.color,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 0.7,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          Hero(
                                            tag: Text("${cat["id"]}"),
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  height: height / 4,
                                                  width: width / 1.8,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          cat["img_full_path"]),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  margin: EdgeInsets.all(6.0),
                                                ),
                                                Positioned(
                                                  top: 0.0,
                                                  left: 0.0,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    margin: EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.pinkAccent,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                          10.0,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                        "${cat["precentage"]} - %",
                                                        style: TextStyle(
                                                          fontSize: width / 28,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                right: 6.0, left: 6.0),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  cat["name"],
                                                  style: TextStyle(
                                                    fontSize: width / 25,
                                                    fontFamily: 'Jost',
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0.6,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .color,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "${cat["over_price"]} KW ",
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: TextStyle(
                                                        fontSize: width / 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .color,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      width: 7.0,
                                                    ),
                                                    Text(
                                                      "${cat["price"]} KW ",
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: TextStyle(
                                                          fontSize: width / 30,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: Colors.grey),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
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
                                    if (cat["type"] == 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductPage(
                                            data: Product(
                                              id: cat["id"],
                                              name: cat["name"],
                                              description: cat["description"],
                                              price: cat["price"].toDouble(),
                                              overPrice:
                                                  cat["over_price"].toDouble(),
                                              brandId: cat["brand_id"],
                                              made: cat["made"],
                                              subCategoryId:
                                                  cat["subCategory_id"],
                                              categoryId: cat["category_id"],
                                              qut: cat["qut"],
                                              pay: cat["pay"],
                                              view: cat["view"],
                                              newItem: cat["new"],
                                              popular: cat["popular"],
                                              over: cat["over"],
                                              subSubCategoryId:
                                                  cat["subSubCategory_id"],
                                              img: cat["img"],
                                              activity: cat["activity"],
                                              numItem: cat["new"],
                                              imgFullPath: cat["img_full_path"],
                                              precentage: cat["precentage"],
                                              images: cat["images"],
                                              sizes: cat["sizes"],
                                              type: cat["type"],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {}
                                  },
                                ),
                              );
                            }),
                      ),
              ],
            ),
          ),
          // Item Popular End

          SizedBox(height: 10.0),
          Container(
            width: width,
            height: height / 2.2,
            color: Theme.of(context).appBarTheme.color,
            child: Column(
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
                          fontFamily: 'Jost',
                          fontSize: width / 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                (_shimmer)
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.white,
                        child: Container(
                          height: height / 2.7,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: over.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                Map cat = over[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: InkWell(
                                    child: Container(
                                      margin: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).appBarTheme.color,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 0.7,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Hero(
                                              tag: Text("${cat["id"]}"),
                                              child: Stack(
                                                children: <Widget>[
                                                  Container(
                                                    height: height / 4,
                                                    width: width / 1.8,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      image: DecorationImage(
                                                        image: NetworkImage(cat[
                                                            "img_full_path"]),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    margin: EdgeInsets.all(6.0),
                                                  ),
                                                  Positioned(
                                                    top: 0.0,
                                                    left: 0.0,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      margin:
                                                          EdgeInsets.all(6.0),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.pinkAccent,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                            10.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Text(
                                                          "${cat["precentage"]} - %",
                                                          style: TextStyle(
                                                            fontSize:
                                                                width / 28,
                                                            color: Colors.white,
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(
                                                  right: 6.0, left: 6.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    cat["name"],
                                                    style: TextStyle(
                                                      fontSize: width / 25,
                                                      fontFamily: 'Jost',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 0.6,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .color,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        "${cat["over_price"]} KW ",
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        style: TextStyle(
                                                          fontSize: width / 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6
                                                                  .color,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        width: 7.0,
                                                      ),
                                                      Text(
                                                        "${cat["price"]} KW ",
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        style: TextStyle(
                                                            fontSize:
                                                                width / 30,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: Colors.grey),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.center,
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
                                    onTap: () {},
                                  ),
                                );
                              }),
                        ),
                      )
                    : Container(
                        height: height / 2.7,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: over.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              Map cat = over[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: InkWell(
                                  child: Container(
                                    margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).appBarTheme.color,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 0.7,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          Hero(
                                            tag: Text("${cat["id"]}"),
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  height: height / 4,
                                                  width: width / 1.8,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          cat["img_full_path"]),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  margin: EdgeInsets.all(6.0),
                                                ),
                                                Positioned(
                                                  top: 0.0,
                                                  left: 0.0,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    margin: EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.pinkAccent,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                          10.0,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                        "${cat["precentage"]} - %",
                                                        style: TextStyle(
                                                          fontSize: width / 28,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                right: 6.0, left: 6.0),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  cat["name"],
                                                  style: TextStyle(
                                                    fontSize: width / 25,
                                                    fontFamily: 'Jost',
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0.6,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .color,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "${cat["over_price"]} KW ",
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: TextStyle(
                                                        fontSize: width / 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .color,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      width: 7.0,
                                                    ),
                                                    Text(
                                                      "${cat["price"]} KW ",
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: TextStyle(
                                                          fontSize: width / 30,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: Colors.grey),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
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
                                    if (cat["type"] == 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductPage(
                                            data: Product(
                                              id: cat["id"],
                                              name: cat["name"],
                                              description: cat["description"],
                                              price: cat["price"].toDouble(),
                                              overPrice:
                                                  cat["over_price"].toDouble(),
                                              brandId: cat["brand_id"],
                                              made: cat["made"],
                                              subCategoryId:
                                                  cat["subCategory_id"],
                                              categoryId: cat["category_id"],
                                              qut: cat["qut"],
                                              pay: cat["pay"],
                                              view: cat["view"],
                                              newItem: cat["new"],
                                              popular: cat["popular"],
                                              over: cat["over"],
                                              subSubCategoryId:
                                                  cat["subSubCategory_id"],
                                              img: cat["img"],
                                              activity: cat["activity"],
                                              numItem: cat["new"],
                                              imgFullPath: cat["img_full_path"],
                                              precentage: cat["precentage"],
                                              images: cat["images"],
                                              sizes: cat["sizes"],
                                              type: cat["type"],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {}
                                  },
                                ),
                              );
                            }),
                      ),
              ],
            ),
          ),
          // New Item Start

          // New Item End
        ],
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
