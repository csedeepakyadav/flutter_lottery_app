import 'package:flutter/material.dart';
import 'package:starlottery/model/LotteryModel.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LotteryFull extends StatefulWidget {
  final Schemes sinlgeScheme;
  LotteryFull({this.sinlgeScheme});

  @override
  _LotteryFullState createState() => _LotteryFullState();
}

class _LotteryFullState extends State<LotteryFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: NeumorphicTheme.baseColor(context),
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Purchase Price :',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Neumorphic(
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        depth: 8,
                        lightSource: LightSource.topLeft,
                        color: Colors.white),
                    child: Container(
                        padding: EdgeInsets.all(25),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "₹ ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.sinlgeScheme.scheme.toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total Winners Wil Be :',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text(
                    " ${widget.sinlgeScheme.winners.toString()}",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Winning Price : ',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text(
                    " ₹ ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  widget.sinlgeScheme.winnigAmountFrom ==
                          widget.sinlgeScheme.winnigAmountTo
                      ? Text(
                          " ${widget.sinlgeScheme.winnigAmountFrom}",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          " ${widget.sinlgeScheme.winnigAmountFrom} -  ${widget.sinlgeScheme.winnigAmountTo}",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                NeumorphicButton(
                    margin: EdgeInsets.only(top: 12),
                    onClick: () {},
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      //border: NeumorphicBorder()
                    ),
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Buy Ticket",
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
