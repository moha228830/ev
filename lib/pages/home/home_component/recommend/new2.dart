import 'package:flutter/material.dart';
import 'package:eventate/pages/product/product.dart';
import 'package:eventate/pages/product/product2.dart';
import 'package:eventate/pages/product_list_view/get_function.dart';
import 'package:eventate/pages/product_list_view/product_class.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class New2 extends StatelessWidget {
  List data;
  New2(this.data);
  final categoryList = [
    {'title': 'cusa', 'image': 'assets/deal_of_the_day/null.png'},
    {'title': 'cusa', 'image': 'assets/deal_of_the_day/null.png'},
    {'title': 'cusa', 'image': 'assets/category_grid/brand3.jpg'},
    {'title': 'cusa', 'image': 'assets/deal_of_the_day/null.png'}
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var new_item = data;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.white,
      child: Container(
        height: 245.0,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              Map cat = categoryList[index];
              return Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: InkWell(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.color,
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
                            tag: Text("${cat["title"]}"),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 170.0,
                                  width: 170.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      image: AssetImage(cat["image"]),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  margin: EdgeInsets.all(6.0),
                                ),
                                Positioned(
                                  top: 0.0,
                                  left: 0.0,
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    margin: EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(
                                          10.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(cat["title"],
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: 6.0, left: 6.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  cat["title"],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Jost',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.6,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      cat["title"],
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 7.0,
                                    ),
                                    Text(
                                      cat["title"],
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
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
    );
  }
}
