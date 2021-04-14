import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/product_list_view/product_list_view.dart';
import 'package:eventate/pages/product_list_view/product_list_view2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class DealOfTheDay extends StatefulWidget {
  var brands;
  DealOfTheDay(this.brands);
  @override
  _DealOfTheDayState createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "افضل الماركات ",
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                fontSize: 15.0.sp,
                letterSpacing: 1.5,
                color: Theme.of(context).textTheme.headline6.color,
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              height: 8.0.h,
              child: widget.brands.length == 0
                  ? ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListView()));
                          },
                          child: Container(
                            color: Colors.grey,
                            width: 30.0.w,
                            height: 7.0.h,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        InkWell(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListView()));
                          },
                          child: Container(
                            color: Colors.grey,
                            width: 30.0.w,
                            height: 7.0.h,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        InkWell(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListView()));
                          },
                          child: Container(
                            color: Colors.grey,
                            width: 30.0.w,
                            height: 7.0.h,
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: widget.brands.length,
                      itemBuilder: (context, index) {
                        final item = widget.brands[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.0.h, horizontal: 1.0.h),
                              decoration: BoxDecoration(
                                color: Theme.of(context).bottomAppBarColor,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          curve: Curves.linear,
                                          duration: Duration(milliseconds: 700),
                                          type: PageTransitionType.bottomToTop,
                                          child: ProductListView2(
                                            item["id"],
                                            "brands",
                                          )));
                                },
                                child: Container(
                                  child: Image.network(
                                    item["img_full_path"],
                                    width: 20.0.w,
                                    height: 7.0.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.0.w,
                            )
                          ],
                        );
                      },
                    ),
            ),
            SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}
