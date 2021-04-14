import 'package:flutter/material.dart';
import 'package:eventate/pages/product_list_view/product_list_view.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProductsProvider with ChangeNotifier {
  int type_id = 0;
  List releted = [];

  set_type_id(val) {
    type_id = val;
    notifyListeners();
  }

  set_releted_products(list) {
    if (list.length > 0) {
      if (list.length > 6) {
        List l = list.take(6).toList();
        releted = l;
      } else {
        releted = list;
      }
    }
  }
}
