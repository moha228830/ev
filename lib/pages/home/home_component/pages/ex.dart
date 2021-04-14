import 'package:flutter/material.dart';
import 'package:eventate/pages/product_list_view/product_list_view.dart';
import 'package:eventate/pages/product_list_view/product_list_view2.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CatGridView extends StatefulWidget {
  var cats;

  CatGridView({Key key, this.cats}) : super(key: key);

  @override
  _CatGridViewState createState() => _CatGridViewState();
}

class _CatGridViewState extends State<CatGridView> {
  getStructuredGridCell(products) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
        onTap: () {
          Provider.of<HomeProvider>(context, listen: false)
              .set_sub_sub_categories(
                  widget.cats["sub"], widget.cats["id"], "sub");
          Navigator.push(
              context,
              PageTransition(
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 700),
                  type: PageTransitionType.topToBottom,
                  child: ProductListView(widget.cats["id"], "sub")));
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              Center(
                child: Container(
                  height: 20.0.h,
                  width: 45.0.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black),
                    image: DecorationImage(
                      image: NetworkImage(widget.cats["img_full_path"]),
                      fit: BoxFit.fill,
                    ),

                    //color: Colors.blue[700 ]
                  ),
                ),
              ),
              Center(
                  child: Text("${widget.cats["name"]}",
                      style: Theme.of(context).textTheme.headline6))
            ]),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return getStructuredGridCell(widget.cats);
  }
}
