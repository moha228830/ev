import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/product_list_view/filter.dart';
import 'package:eventate/pages/product_list_view/product_class.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:eventate/providers/productsProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FilterRow extends StatefulWidget {
  @override
  _FilterRowState createState() => _FilterRowState();
}

class _FilterRowState extends State<FilterRow> {
  int selectedRadioSort;

  @override
  void initState() {
    super.initState();
    selectedRadioSort = 0;
  }

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);
  setSelectedRadioSort(int val, type, context) {
    selectedRadioSort =
        Provider.of<ProductsProvider>(context, listen: false).type_id;

    Provider.of<ProductsProvider>(context, listen: false).set_type_id(type);
    Navigator.pop(context, _pagingController.refresh());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                        color: Theme.of(context).textTheme.headline6.color,
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
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child: Filter()));
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
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
                            setSelectedRadioSort(val, val, context);
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
                            setSelectedRadioSort(val, val, context);
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
                            setSelectedRadioSort(val, val, context);
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                        RadioListTile(
                          value: 4,
                          groupValue: selectedRadioSort,
                          title: Text(
                            "الاحدث وصولا",
                            style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                            ),
                          ),
                          onChanged: (val) {
                            setSelectedRadioSort(val, val, context);
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),
                        RadioListTile(
                          value: 4,
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
                            setSelectedRadioSort(val, val, context);
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
