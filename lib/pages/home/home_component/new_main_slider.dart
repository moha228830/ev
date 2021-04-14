import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:eventate/pages/product_list_view/product_list_view.dart';
import 'package:eventate/pages/product_list_view/product_list_view2.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NewMainSlider extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List sliders =
        Provider.of<HomeProvider>(context, listen: false).home_sliders;

    return Container(
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          border: Border.all(color: Colors.black),
        ),
        height: 25.0.h,
        width: width,
        child: sliders.length == 0
            ? Carousel(
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotColor: Theme.of(context).primaryColor,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.transparent,
                borderRadius: true,
                dotVerticalPadding: 5.0,
                dotPosition: DotPosition.bottomRight,
                images: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      color: Colors.grey,
                      width: width / 2.6,
                      height: height / 6,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      color: Colors.grey,
                      width: width / 2.6,
                      height: height / 6,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      color: Colors.grey,
                      width: width / 2.6,
                      height: height / 6,
                    ),
                  ),
                ],
              )
            : Carousel(
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotColor: Theme.of(context).primaryColor,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.transparent,
                borderRadius: true,
                dotVerticalPadding: 5.0,
                dotPosition: DotPosition.bottomRight,
                images: sliders.map((one) {
                  return new InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              curve: Curves.linear,
                              duration: Duration(milliseconds: 700),
                              type: PageTransitionType.topToBottom,
                              child: ProductListView2(
                                one["id"],
                                "sliders",
                              )));
                    },
                    child: Image.network(
                      one["img_full_path"],
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ));
  }
}
