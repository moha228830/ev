import 'package:flutter/material.dart';

import 'package:eventate/providers/homeProvider.dart';
import 'package:provider/provider.dart';

import 'package:eventate/pages/home/home_component/category_slider.dart';

import 'package:eventate/pages/home/home_component/pages/all.dart';
import 'package:eventate/pages/home/home_component/pages/cat.dart';

import 'package:sizer/sizer.dart';

class HomeMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List cats = Provider.of<HomeProvider>(context, listen: false).home_category;
    int type = Provider.of<HomeProvider>(context, listen: true).is_all;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        // Category Slider Start
        cats.length == 0 ? CategorySlider2() : CategorySlider(cats),
        // Category Slider End
        type == 0 ? All() : Cat(),
      ],
    );
  }
}
