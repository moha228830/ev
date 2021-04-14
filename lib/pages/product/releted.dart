import 'package:flutter/material.dart';
import 'package:eventate/pages/product/product.dart';
import 'package:eventate/pages/product/product2.dart';
import 'package:eventate/pages/product_list_view/get_function.dart';
import 'package:eventate/pages/product_list_view/product_class.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Releted extends StatefulWidget {
  List data;
  int id;
  Releted(this.data, this.id);
  @override
  _ReletedState createState() => _ReletedState();
}

class _ReletedState extends State<Releted> {
  List all = [];
  List some = [];
  set_fav(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setStringList(
        'favorite', Provider.of<HomeProvider>(context, listen: false).favorite);
  }

  @override
  void initState() {
    //  print(widget.data);
    all = widget.data.where((item) => item["id"] != widget.id).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var new_item = all;
    return Container(
      height: height / 2.2,
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
                    color: Theme.of(context).appBarTheme.color,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.grey[300]),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Hero(
                          tag: Text("${cat["id"]}"),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: height / 3.1,
                                width: width / 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: NetworkImage(cat["img_full_path"]),
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
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(
                                        10.0,
                                      ),
                                    ),
                                  ),
                                  child: Text("${cat["precentage"]} - %",
                                      style: TextStyle(
                                        fontSize: width / 28,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              Positioned(
                                top: 2.0,
                                right: 2.0,
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
                                              size: 20.0.sp,
                                            )
                                          : Icon(
                                              Icons.favorite_border_outlined,
                                              color: Colors.pinkAccent,
                                              size: 20.0.sp,
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
                                cat["name"],
                                style: TextStyle(
                                  fontSize: 11.0.sp,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "${cat["over_price"]} KWD ",
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      fontSize: width / 24,
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
                                    "${cat["price"]} KWD ",
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        fontSize: width / 30,
                                        decoration: TextDecoration.lineThrough,
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
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage2(
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
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          }),
    );
  }
}
