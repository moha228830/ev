import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';

class AboutApp extends StatefulWidget {
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "عن كوشا",
          style: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            letterSpacing: 1.7,
          ),
        ),
        titleSpacing: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'MYSTORE Ecommerce App UI in Flutter',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'MYSTORE is a multipurpose ecommerce app ui template. MYSTORE is built in flutter. Flutter is a Hybrid App Development Platform. So, MYSTORE Compatible with Android and iOs both.',
                    style: TextStyle(fontSize: 15.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'MYSTORE is a developed by Render Code. We are expert flutter developer team.',
                    style: TextStyle(fontSize: 15.0, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Thanks for Installing our App',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                ),
                Divider(
                  height: 1.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'render_code',
                    style: TextStyle(fontSize: 15.0, color: Colors.blue),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
