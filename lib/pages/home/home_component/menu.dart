import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/Category/category.dart';

class HomeCategoryMenu extends StatefulWidget {
  @override
  _HomeCategoryMenuState createState() => _HomeCategoryMenuState();
}

class _HomeCategoryMenuState extends State<HomeCategoryMenu> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0.0),
          alignment: Alignment.center,
          color: Theme.of(context).appBarTheme.color,
          width: width,
          child: GridView.count(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            crossAxisCount: 3,
            childAspectRatio: ((width) / 200),
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        categoryName: AppLocalizations.of(context)
                            .translate('homePage', 'cameraString'),
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.photo_camera,
                      size: 25.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      AppLocalizations.of(context)
                          .translate('homePage', 'cameraString'),
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        letterSpacing: 1.5,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        categoryName: AppLocalizations.of(context)
                            .translate('homePage', 'foodMenuString'),
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.free_breakfast,
                      size: 25.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      AppLocalizations.of(context)
                          .translate('homePage', 'foodMenuString'),
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        letterSpacing: 1.5,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        categoryName: AppLocalizations.of(context)
                            .translate('homePage', 'fashionMenuString'),
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.tshirt,
                      size: 22.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      AppLocalizations.of(context)
                          .translate('homePage', 'fashionMenuString'),
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        letterSpacing: 1.5,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        categoryName: AppLocalizations.of(context)
                            .translate('homePage', 'headphonesMenuString'),
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.headphones,
                      size: 22.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      AppLocalizations.of(context)
                          .translate('homePage', 'headphonesMenuString'),
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        letterSpacing: 1.5,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        categoryName: AppLocalizations.of(context)
                            .translate('homePage', 'computerMenuString'),
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.laptop,
                      size: 22.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      AppLocalizations.of(context)
                          .translate('homePage', 'computerMenuString'),
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        letterSpacing: 1.5,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        categoryName: AppLocalizations.of(context)
                            .translate('homePage', 'booksMenuString'),
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.book,
                      size: 22.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      AppLocalizations.of(context)
                          .translate('homePage', 'booksMenuString'),
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        letterSpacing: 1.5,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
