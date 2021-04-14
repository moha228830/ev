import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/Category/category.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:provider/provider.dart';
import 'dart:async' show Future, Timer;
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class CategorySlider extends StatefulWidget {
  List data;
  CategorySlider(this.data);

  @override
  _CategorySliderState createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  bool _shimmer = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int type = Provider.of<HomeProvider>(context, listen: true).is_all;
    var prov = Provider.of<HomeProvider>(context, listen: false);

    return Container(
      width: width,
      height: 8.0.h,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.0.h, horizontal: 0.0.h),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: widget.data == null ? 0 : widget.data.length,
              itemBuilder: (BuildContext context, int index) {
                Map cat = widget.data[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        prov.set_selected_cat(cat["id"]);

                        prov.set_sub_cat(cat["sub_categories"]);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: type == cat["id"]
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).bottomAppBarColor,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  width / 20, 0.5.w, width / 20, 0.5.w),
                              child: Text(
                                "${cat["name"]}",
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                  fontSize: width / 25,
                                  color: type == cat["id"]
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategorySlider2 extends StatefulWidget {
  @override
  _CategorySlider2State createState() => _CategorySlider2State();
}

class _CategorySlider2State extends State<CategorySlider2> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: 90.0,
      child: Container(
        margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 5.0),
            SingleChildScrollView(
              child: Row(
                children: [
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: width / 4,
                          height: height / 17,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(width / 20,
                                height / 80, width / 20, height / 80),
                            child: Text(
                              "${""}",
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: width / 4,
                          height: height / 17,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(width / 20,
                                height / 80, width / 20, height / 80),
                            child: Text(
                              "${""}",
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: width / 4,
                          height: height / 17,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(width / 20,
                                height / 80, width / 20, height / 80),
                            child: Text(
                              "${""}",
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: width / 4,
                          height: height / 17,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(width / 20,
                                height / 80, width / 20, height / 80),
                            child: Text(
                              "${""}",
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: width / 4,
                          height: height / 17,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(width / 20,
                                height / 80, width / 20, height / 80),
                            child: Text(
                              "${""}",
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.0),
                ],
              ),
            ),
            SizedBox(width: 5.0),
          ],
        ),
      ),
    );
  }
}
