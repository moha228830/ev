import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



class Fatora extends StatefulWidget {

  List data ;
  var item;
  Fatora(this.data,this.item);
  @override
  _FatoraState createState() => _FatoraState();
}

class _FatoraState extends State<Fatora> {
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
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "فاتورة",
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

               Container(

                width: (width - 10.0),
                child: Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          SizedBox(
                            height: 7.0,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(2, 2,6 , 2),
                            child: Row(

                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'اسم العميل :',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${ widget.item["username"]}  ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),




                          Container(
                            padding: EdgeInsets.fromLTRB(1, 2, 6, 2),
                            child: Row(

                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'المدينة :',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${ widget.item["govern"]}  ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(1, 2, 6, 2),
                            child: Row(

                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'المنطقة :',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${ widget.item["city"]}  ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(1, 2, 6, 2),
                            child: Row(

                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'القطعة :',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${ widget.item["address"]}  ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            child: Row(

                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'تاريخ الطلب  :',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${ widget.item["date2"]}  ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(6),
                            child: Row(

                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'التسليم او الحجز  :',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${ widget.item["date"]}  ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            child: Row(

                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'كود الطلب  :',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'E_${ widget.item["id"]} ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            child: Row(

                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'سعر الطلب   :',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${ widget.item["price"]}  KWD',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            child: Row(

                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'حالة الدفع   :',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 2,
                                  child:  widget.item["type"]=="cach"?
                                  widget.item["status"]==3?
                                  Text(
                                    'تم الدفع ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ):
                                  Text(
                                    'لم يتم الدفع',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ):
                                  widget.item["type"]=="balance"?
                                  Text(
                                    'تم الدفع من الرصيد ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ):
                                  widget.item["type"]=="visa"?
                                  Text(
                                    'تم الدفع ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ): widget.item["type"]=="knet"?
                                  Text(
                                    'تم الدفع',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontSize: width/24,
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ):Text(" "),
                                ),
                              ],
                            ),
                          ),



                        ],
                      ),
                    ),
                  ),
                ),
              ),


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
                                              fontSize: 12.0.sp,
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
                                                'السعر:',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontSize: 12.0.sp,
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
                                                  fontSize: 12.0.sp,
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
                                                  fontSize: 12.0.sp,
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
                                                  fontSize: 12.0.sp,
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

                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                "اجمالي السعر    ",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontFamily: "Cairo",
                                                  fontSize: 12.0.sp,
                                                ),
                                              ),
                                              Text(
                                                '${(item["price"] * item["qut"]).toStringAsFixed(2)} KW  ',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .color,
                                                  fontFamily: "Cairo",

                                                  fontSize: 12.0.sp,
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
                  backgroundColor: Theme.of(context).primaryColor,
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
