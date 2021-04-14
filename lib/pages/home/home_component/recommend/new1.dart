import 'package:flutter/material.dart';
import 'package:eventate/pages/product/product.dart';
import 'package:eventate/pages/product/product2.dart';
import 'package:eventate/pages/product_list_view/get_function.dart';
import 'package:eventate/pages/product_list_view/product_class.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../helper.dart';

class New1 extends StatelessWidget {
  List data;
  New1(this.data);
  set_fav(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setStringList(
        'favorite', Provider.of<HomeProvider>(context, listen: false).favorite);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var new_item = data;
    return Container(
      height: 37.4.h,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: new_item.length,
          itemBuilder: (BuildContext ctxt, int index) {
            Map cat = new_item[index];
            return Padding(
              padding: const EdgeInsets.all(0),
              child: InkWell(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 0.6.h, horizontal: 0.4.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //borderRadius: BorderRadius.circular(10.0),
                    // border: Border.all(color: Colors.black,
                    // ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Hero(
                          tag: Text("${cat["id"]}"),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 24.0.h,
                                width: 47.0.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(
                                      0.0,
                                    ),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(cat["img_full_path"]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                margin: EdgeInsets.all(0.0),
                              ),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  margin: EdgeInsets.all(0.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(
                                        0.0,
                                      ),
                                    ),
                                  ),
                                  child: Text("${cat["precentage"]} - %",
                                      style: TextStyle(
                                        fontSize: 8.0.sp,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              Positioned(
                                top: 0.0,
                                right: 0.0,
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<HomeProvider>(context,
                                            listen: false)
                                        .toggel_faforite(cat["id"]);
                                    set_fav(context);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(2.0),
                                      margin: EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Provider.of<HomeProvider>(context,
                                                  listen: true)
                                              .favorite_int
                                              .contains(cat["id"])
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
                          height: 12.0.h,
                          width: 46.0.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                " " + get_by_size(cat["name"], 22, 22, ".."),
                                style: TextStyle(
                                  fontSize: 10.0.sp,
                                  fontFamily: 'Cairo',
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
                              Text(
                                " " +
                                    get_by_size(
                                        cat["description"], 24, 24, ".."),
                                style: TextStyle(
                                  fontSize: 9.0.sp,
                                  fontFamily: 'Cairo',
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 0.5.w,
                                  ),
                                  Container(
                                    //  width:20.0.w ,

                                    child: Text(
                                      "${cat["price"]} KWD ",
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          fontSize: 10.0.sp,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.0.w,
                                  ),
                                  Container(
                                    child: Text(
                                      "${cat["over_price"]} KWD ",
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        fontSize: 10.0.sp,
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
                        PageTransition(
                            curve: Curves.linear,
                            duration: Duration(milliseconds: 500),
                            type: PageTransitionType.rightToLeft,
                            child: ProductPage(
                              data: Product(
                                id: cat["id"],
                                name: cat["name"],
                                description: cat["description"],
                                price: cat["price"].toDouble(),
                                overPrice: cat["over_price"].toDouble(),
                                brandId: cat["brand_id"],
                                made: cat["made"],
                                subCategoryId: cat["subCategory_id"],
                                categoryId: cat["category_id"],
                                qut: cat["qut"],
                                pay: cat["pay"],
                                view: cat["view"],
                                newItem: cat["new"],
                                popular: cat["popular"],
                                over: cat["over"],
                                subSubCategoryId: cat["subSubCategory_id"],
                                img: cat["img"],
                                activity: cat["activity"],
                                numItem: cat["new"],
                                imgFullPath: cat["img_full_path"],
                                precentage: cat["precentage"],
                                images: cat["images"],
                                sizes: cat["sizes"],
                                type: cat["type"],
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
                                id: cat["id"],
                                name: cat["name"],
                                description: cat["description"],
                                price: cat["price"].toDouble(),
                                overPrice: cat["over_price"].toDouble(),
                                brandId: cat["brand_id"],
                                made: cat["made"],
                                subCategoryId: cat["subCategory_id"],
                                categoryId: cat["category_id"],
                                qut: cat["qut"],
                                pay: cat["pay"],
                                view: cat["view"],
                                newItem: cat["new"],
                                popular: cat["popular"],
                                over: cat["over"],
                                subSubCategoryId: cat["subSubCategory_id"],
                                img: cat["img"],
                                activity: cat["activity"],
                                numItem: cat["new"],
                                imgFullPath: cat["img_full_path"],
                                precentage: cat["precentage"],
                                images: cat["images"],
                                sizes: cat["sizes"],
                                type: cat["type"],
                              ),
                            )));
                  }
                },
              ),
            );
          }),
    );
  }
}
