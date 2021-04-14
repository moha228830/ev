import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/product/get_similar_products.dart';
import 'package:eventate/pages/product/product_size.dart';
import 'package:eventate/pages/product/rating_row.dart';

// My Own Imports

class ProductDetails extends StatefulWidget {
  final data;

  ProductDetails({Key key, this.data}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool favourite = false;

  List sizes = [];
  List colors = [];
  String dropdownValue = 'المقاس';
  String dropdownValue2 = 'اللون';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Color color = Theme.of(context).textTheme.headline6.color;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        // Slider and Add to Wishlist Code Starts Here
        Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 2.0),
              color: Theme.of(context).appBarTheme.color,
              child: SizedBox(
                height: (height / 2.0),
                child: Hero(
                  tag: Text('${widget.data.id}'),
                  child: Carousel(
                    images: widget.data.images
                        .map((title) => NetworkImage(title["img_full_path"]))
                        .toList(),
                    dotSize: 5.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.grey,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.purple.withOpacity(0.0),
                    boxFit: BoxFit.fitHeight,
                    animationCurve: Curves.decelerate,
                    dotIncreasedColor: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20.0,
              right: 20.0,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).appBarTheme.color,
                elevation: 3.0,
                onPressed: () {
                  setState(() {
                    if (!favourite) {
                      favourite = true;
                      color = Colors.red;

                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(context).translate(
                                'productPage', 'addedtoWishlistString'),
                          ),
                        ),
                      );
                    } else {
                      favourite = false;
                      color = Colors.grey;
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(context).translate(
                                'productPage', 'removeFromWishlistString'),
                          ),
                        ),
                      );
                    }
                  });
                },
                child: Icon(
                  (!favourite)
                      ? FontAwesomeIcons.heart
                      : FontAwesomeIcons.solidHeart,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        // Slider and Add to Wishlist Code Ends Here
        SizedBox(
          height: 8.0,
        ),
        Divider(
          height: 1.0,
        ),

        Container(
          color: Theme.of(context).appBarTheme.color,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Product Title Start Here

              // Product Title End Here

              // Special Price badge Start Here

              // Special Price badge Ends Here.

              // Price & Offer Row Starts Here
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${widget.data.name}',
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jost',
                        letterSpacing: 0.7,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '\$${widget.data.overPrice}',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            '\$${widget.data.price}',
                            style: TextStyle(
                                fontSize: 14.0,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            '₹${widget.data.precentage}',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.red[700]),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // Price & Offer Row Ends Here

              // Rating Row Starts Here
              // RatingRow(),
              // Rating Row Ends Here
            ],
          ),
        ),

        // Product Size & Color Start Here
        //  P
        //  roductSize(),
        Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Text(" اختر المقاس اولا  ثم اللون")),
        Container(
          padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(5),
                  child: Text(" "),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pinkAccent,
                    boxShadow: [
                      BoxShadow(color: Colors.pinkAccent, spreadRadius: 3),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                  margin: EdgeInsets.all(5),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Colors.white,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: widget.data.images
                        .map((title) => title["img_full_path"])
                        .toList()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(5),
                  child: Text(" "),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pinkAccent,
                    boxShadow: [
                      BoxShadow(color: Colors.pinkAccent, spreadRadius: 3),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                  margin: EdgeInsets.all(5),
                  child: DropdownButton<String>(
                    value: dropdownValue2,
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Colors.white,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue2 = newValue;
                      });
                    },
                    items: <String>['اللون', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(5),
                  child: Text(" "),
                ),
              ),
            ],
          ),
        ),

        // Product Size & Color End Here

        // Product Details Start Her
        //product detils  ////////////////////////////////////

        //endproduct detils  ////////////////////////////////////

        // Product Details Ends Here

        // Product Description Start Here
        Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.only(top: 5.0),
          color: Theme.of(context).appBarTheme.color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 5.0),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate(
                            'productPage', 'productDescriptionString'),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  _productDescriptionModalBottomSheet(
                      context, widget.data.description);
                },
              ),
              Divider(
                height: 1.0,
              ),
            ],
          ),
        ),

        // Product Description Ends Here
        ////////////////////////////////////////////////////////////////////////////////////

        // Similar Product Starts Here

        // Similar Product Ends Here
      ],
    );
  }

  // Bottom Sheet for Product Description Starts Here
  void _productDescriptionModalBottomSheet(context, data) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).appBarTheme.color,
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
                          AppLocalizations.of(context).translate(
                              'productPage', 'productDescriptionString'),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Divider(
                          height: 1.0,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          data,
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            height: 1.45,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                          // overflow: TextOverflow.ellipsis,
                          // maxLines: 5,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 8.0,
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
// Bottom Sheet for Product Description Ends Here
}
