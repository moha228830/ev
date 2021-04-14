import 'dart:async';
import 'dart:convert';

import 'package:eventate/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eventate/pages/product_list_view/product_class.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:provider/provider.dart';

Future<List<Product>> fetchProducts(
    http.Client client, id, type, page, offset, context) async {
  var fav =
      Provider.of<HomeProvider>(context, listen: false).favorite.join(',');
  print(fav);
  final response = await client.get(Config.url +
      'items?type=' +
      type +
      '&sub_id=' +
      id.toString() +
      '&page=' +
      page.toString() +
      '&offset=' +
      offset.toString() +
      "&favorite=" +
      fav.toString());
  print(json.decode(response.body));
  return parseProducts(response.body);
}

// A function that converts a response body into a List<Product>.
List<Product> parseProducts(responseBody) {
  final parsed =
      jsonDecode(responseBody)["data"]["items"].cast<Map<String, dynamic>>();
  print(parsed);

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}
