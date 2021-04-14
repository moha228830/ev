import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/home/home.dart';
import 'package:eventate/pages/product_list_view/filter.dart';
import 'package:eventate/pages/product_list_view/filter_row.dart';
import 'package:eventate/pages/product_list_view/product_class.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:select_dialog/select_dialog.dart';
import 'dart:convert';
import 'dart:async' show Future, Timer;
import 'package:sizer/sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eventate/pages/product/product.dart';
import 'package:eventate/pages/product_list_view/filter_row.dart';
import 'package:eventate/functions/passDataToProducts.dart';
import 'package:eventate/providers/productsProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eventate/pages/product_list_view/se.dart';
import 'package:eventate/pages/product_list_view/get_function.dart';
import 'package:eventate/pages/product_list_view/one_product.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:eventate/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eventate/pages/product_list_view/product_class.dart';
import 'package:provider/provider.dart';
// My Own Imports
import 'package:eventate/pages/product_list_view/test.dart';
import 'package:eventate/pages/search.dart';

class ProductListView extends StatefulWidget {
  int id;
  String type;
  ProductListView(this.id, this.type);
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  int selectedRadioSort;
  int type_id = 0;
  var selected_sub_sub = "الكل";
  int sub_sub_id = 0;
  setSelectedRadioSort(int val) {
    setState(() {
      selectedRadioSort = val;
      type_id = val;
      _pagingController.refresh();
      Navigator.pop(context);
    });
  }

  //////////////////////////////////////////////////////////////////////
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Future<List<Product>> fetchCats(
      http.Client client, page, offset, id, type, keyword) async {
    if (keyword == null) {
      keyword = " ";
    }
    print(id);

    final response = await client.get(Config.url +
        'items?type=' +
        Provider.of<HomeProvider>(context, listen: false).type.toString() +
        '&sub_id=' +
        Provider.of<HomeProvider>(context, listen: false).id.toString() +
        '&page=' +
        page.toString() +
        '&offset=' +
        offset.toString() +
        "&type_id=" +
        type_id.toString() +
        "&keyword=" +
        keyword.toString());
    print(jsonDecode(response.body));

    // Use the compute function to run parseProducts in a separate isolate.
    return parseCats(response.body);
  }

// A function that converts a response body into a List<Product>.
  List<Product> parseCats(responseBody) {
    final parsed =
        jsonDecode(responseBody)["data"]["items"].cast<Map<String, dynamic>>();
    Provider.of<ProductsProvider>(context, listen: false)
        .set_releted_products(jsonDecode(responseBody)["data"]["items"]);

    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  bool _isload = false;
  final TextEditingController _codeControl = new TextEditingController();

  bool loading = true;

  static const _pageSize = 10;

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);

  String _searchTerm;

  @override
  void initState() {
    selectedRadioSort = 0;
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

    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });

    super.initState();
  }

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(pageKey) async {
    try {
      final newItems = await fetchCats(http.Client(), _pageSize, pageKey,
          widget.id, widget.type, _searchTerm);

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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "العروض",
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0.sp,
                    letterSpacing: 1.7,
                    color: Colors.white),
              ),
              // Text(
              //   '37024 ${AppLocalizations.of(context).translate('productListViewPage', 'itemsString')}',
              // style: TextStyle(
              // fontFamily: 'Jost',
              // fontWeight: FontWeight.bold,
              // fontSize: 12.0,
              // letterSpacing: 1.5,
              // color: Colors.white,
              //  ),
              // )
            ],
          ),
          titleSpacing: 0.0,
          actions: <Widget>[
            // IconButton(
            //  icon: Icon(
            //  Icons.search,
            //  ),
            //    onPressed: () {

            //   }),
            IconButton(
              icon: Badge(
                badgeContent: Text(
                  '${Provider.of<PostDataProvider>(context, listen: true).num ?? 0}',
                  style: TextStyle(color: Colors.white),
                ),
                badgeColor: Colors.grey,
                child: Icon(
                  Icons.local_grocery_store_sharp,
                  color: Colors.white,
                  size: 20.0.sp,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        curve: Curves.linear,
                        duration: Duration(milliseconds: 900),
                        type: PageTransitionType.bottomToTop,
                        child: Home(2)));
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      _sortModalBottomSheet(context);
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.sort,
                            size: 20.0.sp,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              " ترتيب حسب ",
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.7,
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 20.0,
                    width: 1.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SelectDialog.showModal(
                        context,
                        label: "اختر الفئة",
                        items: Provider.of<HomeProvider>(context, listen: false)
                            .sub_sub,
                        selectedValue: selected_sub_sub,
                        itemBuilder:
                            (BuildContext context, item, bool isSelected) {
                          return Container(
                            decoration: !isSelected
                                ? null
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                            child: ListTile(
                              onTap: () {
                                var list = Provider.of<HomeProvider>(context,
                                        listen: false)
                                    .sub_sub;
                                if (item["id"] != 0) {
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .set_sub_sub_categories(
                                          list, item["id"], "subsub");
                                } else {
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .set_sub_sub_categories(
                                          list, widget.id, "sub");
                                }
                                setState(() {
                                  selected_sub_sub = item["name"];
                                  sub_sub_id = item["id"];
                                });

                                _pagingController.refresh();

                                Navigator.pop(context);
                              },
                              selected: isSelected,
                              title: Text(
                                item["name"],
                                style: TextStyle(
                                    fontFamily: "Cairo",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0.sp),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.apps,
                            size: 20.0.sp,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              " الفئات  ",
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.7,
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1.0,
            ),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  CharacterSearchInputSliver(
                    onChanged: (searchTerm) => _updateSearchTerm(searchTerm),
                  ),
                  PagedSliverGrid<int, Product>(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 2,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width / 2) /
                              (MediaQuery.of(context).size.height / 2.83),
                    ),
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Product>(
                        itemBuilder: (context, item, index) => (loading)
                            ? Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.white,
                                    child: ProductsGridView(
                                      products: item,
                                      num: 1,
                                    )),
                              )
                            : ProductsGridView(
                                products: item,
                                num: 1,
                              )),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void _sortModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).appBarTheme.color,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)
                              .translate('productListViewPage', 'sortByString'),
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            letterSpacing: 0.7,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Divider(
                          height: 1.0,
                        ),
                        RadioListTile(
                          value: 1,
                          groupValue: selectedRadioSort,
                          title: Text(
                            "السعر من الاقل الي الاكبر",
                            style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                            ),
                          ),
                          onChanged: (val) {
                            setSelectedRadioSort(val);
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                        RadioListTile(
                          value: 2,
                          groupValue: selectedRadioSort,
                          title: Text(
                            "السعر من الاكبر الي الاقل",
                            style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                            ),
                          ),
                          onChanged: (val) {
                            setSelectedRadioSort(val);
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                        RadioListTile(
                          value: 3,
                          groupValue: selectedRadioSort,
                          title: Text(
                            "الاكثر رواجا",
                            style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                            ),
                          ),
                          onChanged: (val) {
                            setSelectedRadioSort(val);
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                        RadioListTile(
                          value: 4,
                          groupValue: selectedRadioSort,
                          title: Text(
                            "الاحدث",
                            style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                            ),
                          ),
                          onChanged: (val) {
                            setSelectedRadioSort(val);
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                        RadioListTile(
                          value: 5,
                          groupValue: selectedRadioSort,
                          title: Text(
                            "عروض الخصم",
                            style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                            ),
                          ),
                          onChanged: (val) {
                            setSelectedRadioSort(val);
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
