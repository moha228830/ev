import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



class Items extends StatefulWidget {

  List data ;
  Items(this.data);
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  List  cartItemList;
  int cartItem ;
  var total= 0.00;
  bool _load =true ;
  bool progres = false ;
  Map map = {};
  bool set_num = false;


  //////////////////////////////////////////////////////////////////////////////////////////////////////


  ///////////////////////////add to cart





  /////////////////////////////////////////////////////

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cartItem =  widget.data.length;

    cartItemList = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: Text(
            "تفاصيل الطلب",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: width/25,
              letterSpacing: 1.7,
              color: Colors.white ,
              fontWeight: FontWeight.bold,
            ),
          ),
          titleSpacing: 0.0,
        ),
        body:

        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: ListView(
            children: [


              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: cartItemList.length,
                itemBuilder: (context, index) {
                  final item = cartItemList[index];
                  return Container(
                    alignment: Alignment.center,

                    child: Container(
                      width: (width - 10.0),
                      child: Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SingleChildScrollView(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: width/4,
                                          height: height/8,
                                          child: Image(
                                            image:NetworkImage(item['img_full_path']),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Container(
                                      padding: EdgeInsets.all(10.0),
                                      // width: (width - 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${item['name']}',

                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                              fontSize: 15.0,
                                              fontFamily: "Cairo",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'الوحدة:',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontSize: width/26,
                                                  fontFamily: "Cairo",

                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                '${item['price']}  KWD',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontSize: width/26,
                                                  fontFamily: "Cairo",

                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'الكمية :',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontSize: width/26,
                                                  fontFamily: "Cairo",

                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                '${item['qut']}  ',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontSize: width/26,
                                                  fontFamily: "Cairo",

                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10.0),
                                      // width: (width - 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          item["color"] !=null ?
                                          Text(
                                            '${item["color"]}',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .color,
                                              fontSize: width/26,
                                              fontFamily: "Cairo",

                                              fontWeight: FontWeight.bold,
                                            ),
                                          ):Text(" "),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              item["size"] !=null?
                                              Text(
                                                'المقاس :',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontSize: width/26,
                                                  fontFamily: "Cairo",

                                                ),
                                              ):Text(" "),
                                              SizedBox(
                                                width: 10.0,
                                              ),  item["size"] !=null ?
                                              Text(
                                                '${item["size"]}',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontSize: 12.0.sp,
                                                ),
                                              ):Text(" "),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[

                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                '${(item["price"] * item["qut"]).toStringAsFixed(2)} KW  ',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontSize: width/26,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),

                  )

                  ;
                },
              ),
              Container(
                height: 20,
                child:
                progres?
                LinearProgressIndicator(
                  backgroundColor: Colors.pinkAccent,
                  valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),
                  minHeight: 20,
                ):null
                ,),

            ],
          ),
        )

    );
  }
}
