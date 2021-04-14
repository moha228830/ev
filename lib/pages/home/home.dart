import 'dart:io';
import 'package:badges/badges.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/contact.dart';
import 'package:eventate/pages/orders/orders.dart';
import 'package:eventate/pages/product_list_view/get_function.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';
import 'package:sizer/sizer.dart';
import 'package:eventate/providers/homeProvider.dart';

// My Own Imports
import 'package:eventate/pages/home/home_main.dart';
import 'package:eventate/pages/favorite/faforite.dart';

import 'package:eventate/pages/my_account/my_account.dart';
import 'package:eventate/pages/my_cart.dart';
import 'package:eventate/pages/notification.dart';
import 'package:eventate/pages/search.dart';
import 'package:eventate/pages/wishlist.dart';

class Home extends StatefulWidget {
  int index;
  Home(this.index);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex;
  var num = "!";
  var token = utils.CreateCryptoRandomString();
  var user_id;
  DateTime currentBackPressTime;
  @override
  void initState() {
    m();
    super.initState();
    currentIndex = widget.index ?? 0;
    set_token_not_register();
  }

  set_token_not_register() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var tok = localStorage.getString('token');
    var login = localStorage.getString('login');
    var d = localStorage.getString('user');
    if (d != null) {
      user_id = jsonDecode(d)["id"] ?? "0";
    } else {
      user_id = "0";
    }

    //if(login=="2"){
    //var data_user = localStorage.getString('user_id');
    //print(data_user);
    //}

    if (tok == null) {
      localStorage.setString('token', token);
      localStorage.setString('user_id', "0");
      localStorage.setString('login', "0");
      Provider.of<HomeProvider>(context, listen: false)
          .set_data_user(token, 0, "0");
      localStorage.setStringList('favorite', []);
      // print( tok + "moha");

    } else {
      var fav = localStorage.getStringList('favorite');

      Provider.of<HomeProvider>(context, listen: false).get_faforite(fav);
      print(Provider.of<HomeProvider>(context, listen: false).favorite);
      print(fav);
      Provider.of<HomeProvider>(context, listen: false)
          .set_data_user(tok, user_id, login);
      Provider.of<PostDataProvider>(context, listen: false).cat_num(tok);
    }
    print(tok);
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  String m() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    var n = data.size.shortestSide;
    print(n);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var n = Provider.of<PostDataProvider>(context, listen: true).num == null
        ? 0
        : Provider.of<PostDataProvider>(context, listen: true).num;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Padding(
          padding: const EdgeInsets.all(0),
          child: Center(
            child:
           Image.asset("assets/eeev-logo-whait.png",height: 10.0.h,width: 40.0.w,),
          ),
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
              badgeContent: n == null
                  ? Text(
                      '0',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      '${n}',
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,

        currentIndex: currentIndex,
        onTap: changePage,
        // borderRadius: BorderRadius.vertical(
        //  top: Radius.circular(
        //  16)), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home,
                size: 20.0.sp,
                color: currentIndex == 0
                    ? Theme.of(context).primaryColor
                    : Colors.black),
            title: Text(
              'الرئيسية',
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: currentIndex == 0
                      ? Theme.of(context).primaryColor
                      : Colors.black),
            ),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.list_alt,
                size: 20.0.sp,
                color: currentIndex == 1
                    ? Theme.of(context).primaryColor
                    : Colors.black),
            title: Text(
              'طلباتي',
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: currentIndex == 1
                      ? Theme.of(context).primaryColor
                      : Colors.black),
            ),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,
                size: 20.0.sp,
                color: currentIndex == 2
                    ? Theme.of(context).primaryColor
                    : Colors.black),
            title: Text(
              'السلة',
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: currentIndex == 2
                      ? Theme.of(context).primaryColor
                      : Colors.black),
            ),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
                size: 20.0.sp,
                color: currentIndex == 3
                    ? Theme.of(context).primaryColor
                    : Colors.black),
            title: Text(
              'مفضلتي',
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: currentIndex == 3
                      ? Theme.of(context).primaryColor
                      : Colors.black),
            ),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person,
                size: 20.0.sp,
                color: currentIndex == 4
                    ? Theme.of(context).primaryColor
                    : Colors.black),
            title: Text(
              'حسابي',
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0.sp,
                  color: currentIndex == 4
                      ? Theme.of(context).primaryColor
                      : Colors.black),
            ),
          )
        ],
      ),
      body: WillPopScope(
        child: (currentIndex == 0)
            ? HomeMain()
            : (currentIndex == 1)
                ? Order()
                : (currentIndex == 2)
                    ? MyCart()
                    : (currentIndex == 3)
                        ? GetFavorite()
                        : (currentIndex == 4)
                            ? MyAccount()
                            : HomeMain(),
        onWillPop: onWillPop,
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)
            .translate('homePage', 'exitToastString'),
        backgroundColor: Theme.of(context).textTheme.headline6.color,
        textColor: Theme.of(context).appBarTheme.color,
      );
      return Future.value(false);
    }
    exit(0);
    return Future.value(true);
  }
}

class utils {
  static final Random _random = Random.secure();

  static String CreateCryptoRandomString([int length = 32]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }
}
