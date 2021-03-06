import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/Category/get_category_products.dart';
import 'package:eventate/pages/product_list_view/product_list_view.dart';

class NewItem extends StatefulWidget {
  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: 295.0,
      color: Theme.of(context).appBarTheme.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)
                      .translate('categoryPage', 'newItemString'),
                  style: TextStyle(
                    fontFamily: 'Jost',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.7,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('categoryPage', 'seeMoreString'),
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.7,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          GetCategoryProducts(),
        ],
      ),
    );
  }
}
