import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/call_center/chat.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class CallCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of(context)
              .translate('callCenterPage', 'callCenterAppBarTitleString'),
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            letterSpacing: 1.7,
          ),
        ),
        titleSpacing: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/call_center.png',
                width: 200.0,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Text(
                  AppLocalizations.of(context)
                      .translate('callCenterPage', 'happyToHalpString'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    letterSpacing: 1.7,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Text(
                  "???????? ?????? ?????? ???? ?????????????? ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                    letterSpacing: 1.7,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  launch("tel://96597244282");
                },
                child: Container(
                  height: 45.0,
                  width: 220.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.redAccent,
                    color: Theme.of(context).primaryColor,
                    child: GestureDetector(
                      child: Center(
                        child: Text(
                          "???????? ????????",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            fontSize: 16.0,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
