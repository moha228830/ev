import 'dart:async';
import 'dart:convert';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:eventate/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eventate/pages/product_list_view/product_class.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future, Timer;
import 'package:sizer/sizer.dart';

import 'package:eventate/pages/product_list_view/filter_row.dart';
import 'package:eventate/functions/passDataToProducts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eventate/pages/favorite/get_function.dart';
import 'package:eventate/pages/product_list_view/one_product.dart';

import 'dart:async';
import 'package:http/http.dart' as http;

class GetFavorite extends StatefulWidget {
  @override
  _GetFavoriteState createState() => _GetFavoriteState();
}

class _GetFavoriteState extends State<GetFavorite> {
  bool loading = true, all = true, men = false, women = false;
  static const _pageSize = 6;
  int num = 0;
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      if (this.mounted) {
        setState(() {
          loading = false;
        });
      }
    });
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await fetchProducts(
          http.Client(), 1, "favorite", _pageSize, pageKey, context);
      setState(() {
        num = newItems.length;
      });
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => PagedGridView<int, Product>(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: (MediaQuery.of(context).size.width / 2) /
              (MediaQuery.of(context).size.height / 2.79),
        ),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Product>(
          itemBuilder: (context, item, index) => (loading)
              ? Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.white,
                    child: ProductsGridView(products: item, num: num),
                  ),
                )
              : Column(
                  children: [
                    //SizedBox(height: 2.0.h,),
                    Expanded(child: ProductsGridView(products: item, num: num)),
                  ],
                ),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
