import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:eventate/AppTheme/AppStateNotifier.dart';
import 'package:eventate/AppTheme/appTheme.dart';
import 'package:eventate/AppTheme/my_behaviour.dart';
import 'package:eventate/functions/change_language.dart';
import 'package:eventate/functions/localizations.dart';
import 'package:eventate/pages/home/home.dart';
import 'package:eventate/pages/order_payment/myfatorah.dart';
import 'package:eventate/providers/homeProvider.dart';
import 'package:eventate/providers/productsProvider.dart';
import 'package:eventate/slider/slider.dart';

import 'package:sizer/sizer.dart';
import 'package:eventate/pages/product_list_view/get_function.dart';
import './custom_animation.dart';

import 'package:eventate/config.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer_util.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppStateNotifier()),
          ChangeNotifierProvider(create: (context) => PostDataProvider()),
          ChangeNotifierProvider(create: (context) => HomeProvider()),
          ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ],
        child: MyApp(
          appLanguage: appLanguage,
        ),
      ),
    );
    configLoading();
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(//return LayoutBuilder
        builder: (context, constraints) {
      return OrientationBuilder(//return OrientationBuilder
          builder: (context, orientation) {
        //initialize SizerUtil()
        SizerUtil().init(constraints, orientation); //initialize SizerUtil
        return Consumer<AppStateNotifier>(
          builder: (context, appState, child) {
            return ChangeNotifierProvider<AppLanguage>(
              create: (_) => appLanguage,
              child: Consumer<AppLanguage>(builder: (context, model, child) {
                return OverlaySupport.global(
                    child: MaterialApp(
                  title: 'MyStore',
                  debugShowCheckedModeBanner: false,
                  locale: model.appLocal,
                  supportedLocales: [
                    Locale('en', 'US'),
                    Locale('hi', ''),
                    Locale('ar', ''),
                    Locale('zh', ''),
                    Locale('id', ''),
                    Locale('ru', ''),
                  ],
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode:
                      appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
                  builder: EasyLoading.init(
                    builder: (context, child) {
                      return ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: child,
                      );
                    },
                  ),
                  home: MyHomePage(),
                ));
              }),
            );
          },
        );
      });
    });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool progress = true;
  bool load = true;
  @override
  initState() {
    myTimer();
    fetchCats(context);

    super.initState();
  }

  myTimer() {
    Timer(const Duration(seconds: 7), () {
      if (load == true) {
        EasyLoading.show(status: 'بطئ الاتصال بالشبطة جاري الاتصال.....');
      } else {
        EasyLoading.dismiss();
      }
    });
  }

  Future fetchCats(context) async {
    try {
      final response = await http.get(Config.url + "categories");

      if (jsonDecode(response.body)["state"] == "1") {
        print("yes");
        List category = json.decode(response.body)["data"]["categories"];
        List over = json.decode(response.body)["data"]["over"];
        List popular = json.decode(response.body)["data"]["popular"];
        List new_item = json.decode(response.body)["data"]["new"];
        List sliders = json.decode(response.body)["data"]["sliders"];
        List images = json.decode(response.body)["data"]["images"];
        Provider.of<HomeProvider>(context, listen: false).set_data(
            category, over, popular, new_item,  sliders, context);
        Provider.of<ProductsProvider>(context, listen: false)
            .set_releted_products(over);

        print(jsonDecode(response.body)["msg"]);
        setState(() {
          load = false;
        });
        EasyLoading.dismiss();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MySlider(images),
          ),
        );
      } else {
        print("no");
        setState(() {
          load = false;
        });
        EasyLoading.dismiss();
        Alert(
          context: context,
          type: AlertType.info,
          style: AlertStyle(
            titleStyle: TextStyle(
                fontSize: 12.0.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Cairo",
                color: Colors.indigo),
            descStyle: TextStyle(
                fontSize: 12.0.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Cairo"),
          ),
          title: "خطأ بالشبكة",
          desc:
              'لديك مشكلة في الاتصال بالانترنت تأكد من الاتصال بالانترنت وحاول مرة اخري',
          buttons: [
            DialogButton(
              child: Text(
                "اعادة تحميل",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0.sp,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Navigator.pop(context);
                Navigator.push(
                    context,
                    PageTransition(
                        curve: Curves.linear,
                        duration: Duration(milliseconds: 400),
                        type: PageTransitionType.bottomToTop,
                        child: MyHomePage()));
              },
              color: Colors.lightBlue,
            ),
          ],
        ).show();
      }
    } on SocketException catch (_) {
      print("no internet");
      setState(() {
        load = false;
      });
      EasyLoading.dismiss();
      Alert(
        context: context,
        type: AlertType.info,
        style: AlertStyle(
          titleStyle: TextStyle(
              fontSize: 12.0.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Cairo",
              color: Colors.indigo),
          descStyle: TextStyle(
              fontSize: 12.0.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Cairo"),
        ),
        title: "خطأ بالشبكة",
        desc:
            'لديك مشكلة في الاتصال بالانترنت تأكد من الاتصال بالانترنت وحاول مرة اخري',
        buttons: [
          DialogButton(
            child: Text(
              "اعادة تحميل",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0.sp,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 400),
                      type: PageTransitionType.bottomToTop,
                      child: MyHomePage()));
            },
            color: Colors.lightBlue,
          ),
        ],
      ).show();
    } // Use the compute function to run parseProducts in a separate isolate.

    // return parseCats(response.body);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // var appLanguage = Provider.of<AppLanguage>(context);

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/e2.png"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}
