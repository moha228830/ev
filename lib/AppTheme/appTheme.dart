import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(

    primaryColor: Colors.yellow[800],
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: AppBarTheme(
      color: Colors.white,

      textTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.black,fontWeight: FontWeight.bold, fontFamily: "Cairo",fontSize: 11.0.sp
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.red,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
          color: Colors.black,fontWeight: FontWeight.bold, fontFamily: "Cairo",fontSize: 11.0.sp
      ),
    ),
    primaryColorLight: Colors.redAccent,
    bottomAppBarColor: Colors.white,
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(
              fontSize: 8.8, fontWeight: FontWeight.bold, color: Colors.red,fontFamily: "Cairo"),
      indicator: null,
      labelColor: Colors.red,
      unselectedLabelColor: Colors.black,
    ),
    cardColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.black,
      contentTextStyle: TextStyle(
        color: Colors.white,fontFamily: "Cairo"
      ),
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    cursorColor: Colors.black,
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.yellow[800],
    scaffoldBackgroundColor:Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      textTheme: TextTheme(
        headline6: TextStyle(
            color: Colors.white,fontWeight: FontWeight.bold, fontFamily: "Cairo",fontSize: 11.0.sp
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,fontWeight: FontWeight.bold, fontFamily: "Cairo",fontSize: 11.0.sp
      ),
    ),
    primaryColorLight: Colors.redAccent,
    bottomAppBarColor: Colors.black,
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(
              fontSize: 8.8, fontWeight: FontWeight.bold, color: Colors.red,fontFamily: "Cairo"),
      indicator: null,
      labelColor: Colors.red,
      unselectedLabelColor: Colors.white,
    ),
    dividerColor: Colors.grey[800],
    cardColor: Colors.black,
    dialogBackgroundColor: Colors.grey[800],
    unselectedWidgetColor: Colors.white,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.white,
      contentTextStyle: TextStyle(
        color: Colors.black,fontFamily: "Cairo"
      ),
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    cursorColor: Colors.white,
  );
}