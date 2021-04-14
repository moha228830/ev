import 'package:flutter/material.dart';
import 'package:eventate/functions/localizations.dart';

class BestForYou extends StatefulWidget {
  List data;
  BestForYou(this.data);
  @override
  _BestForYouState createState() => _BestForYouState();
}

class _BestForYouState extends State<BestForYou> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 205.0,
      color: Theme.of(context).appBarTheme.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 10),
          ),
          Container(
            width: width,
            height: 150.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(width: 10.0),
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.data == null ? 0 : widget.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map cat = widget.data[index];

                    return SingleChildScrollView(
                      child: Row(
                        children: [
                          SizedBox(width: 10.0),
                          Container(
                            height: 150.0,
                            width: 120.0,
                            child: InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 1.5,
                                      color: Colors.grey,
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/category_grid/bags.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Text(
                                  '${cat["name"]}',
                                  style: TextStyle(
                                    fontFamily: 'Jost',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    letterSpacing: 1.5,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: 10.0),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(width: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
