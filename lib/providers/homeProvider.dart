import 'package:flutter/material.dart';
import 'package:eventate/pages/product_list_view/product_list_view.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier {
  List home_category = [];
  List home_over = [];
  List home_popular = [];
  List home_new_item = [];
  List home_sliders = [];
  var item_of_slider = [];
  var sub_cat = [];
  List sub_sub = [];
  String type = "sub";
  int id;
  List favorite_int = [];
  List<String> favorite = [];

  get_faforite(list) {
    favorite = list;
    favorite_int = list.map(int.parse).toList();

    notifyListeners();
  }

  toggel_faforite(id) {
    if (favorite_int.contains(id)) {
      favorite_int.remove(id);
      favorite = [
        for (int i = 0; i < favorite_int.length; i++) favorite_int[i].toString()
      ];
    } else {
      favorite_int.add(id);
      favorite = [
        for (int i = 0; i < favorite_int.length; i++) favorite_int[i].toString()
      ];
    }

    print(favorite);
    notifyListeners();
  }

  delete_faforite() {}

  /////////////////////////////user data /////////////////////////////
  String token;
  var user_id;
  var login;

  // num in cart by token
  var num = 0;

  //get page by click on category
  int is_all = 0;

  set_data_user(tok, user, log) {
    token = tok;
    user_id = user;
    login = log;
    notifyListeners();
  }

  set_sub_sub_categories(list, val_id, val_type) {
    sub_sub = list;
    if (sub_sub[0]["id"] != 0) {
      sub_sub.insert(0, {'id': 0, 'name': 'الكل', "sub_categories": []});
    }

    id = val_id;
    type = val_type;
    notifyListeners();
  }

//عدد المنتجات بالسلة
  set_int(my_num) {
    num = my_num;
    notifyListeners();
  }

  // اضافة البيانات الرئيسية عند تحميل التطبيق
  set_data(category, over, popular, new_item,  sliders, context) {
    home_category = category;
    home_category.insert(0, {'id': 0, 'name': 'الكل', "sub_categories": []});

    home_new_item = new_item;
    home_sliders = sliders;
    home_over = over;
    home_popular = popular;

    notifyListeners();
  }

  // تحديد القسم او الكل
  set_selected_cat(val) {
    is_all = val;
    notifyListeners();
  }

  //اضافة الاقسام الفرعية عند الضغط علي الاقسام
  set_sub_cat(val) {
    if (val != sub_cat) sub_cat = val;
    notifyListeners();
  }
}
