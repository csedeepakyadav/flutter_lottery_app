import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:starlottery/Lottery/LotteryFull.dart';
import 'package:starlottery/model/LotteryModel.dart';

class SchemeList extends StatelessWidget {
  final List<Schemes> _schemeList = [
    Schemes(
        id: 0,
        scheme: 5,
        winnigAmountFrom: 50,
        winnigAmountTo: 100,
        participants: 100,
        winners: 25),
    Schemes(
        id: 0,
        scheme: 10,
        winnigAmountFrom: 100,
        winnigAmountTo: 100,
        participants: 100,
        winners: 25),
    Schemes(
        id: 0,
        scheme: 20,
        winnigAmountFrom: 100,
        winnigAmountTo: 200,
        participants: 100,
        winners: 40),
    Schemes(
        id: 0,
        scheme: 30,
        winnigAmountFrom: 200,
        winnigAmountTo: 300,
        participants: 100,
        winners: 40),
    Schemes(
        id: 0,
        scheme: 40,
        winnigAmountFrom: 300,
        winnigAmountTo: 400,
        participants: 100,
        winners: 40),
    Schemes(
        id: 0,
        scheme: 50,
        winnigAmountFrom: 500,
        winnigAmountTo: 500,
        participants: 100,
        winners: 40),
    Schemes(
        id: 0,
        scheme: 100,
        winnigAmountFrom: 2000,
        winnigAmountTo: 2500,
        participants: 100,
        winners: 25),
    Schemes(
        id: 0,
        scheme: 500,
        winnigAmountFrom: 5000,
        winnigAmountTo: 5000,
        participants: 100,
        winners: 25),
    Schemes(
        id: 0,
        scheme: 1000,
        winnigAmountFrom: 10000,
        winnigAmountTo: 10000,
        participants: 100,
        winners: 15),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      // physics: ClampingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      itemCount: _schemeList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 10, left: 8, right: 8),
          child: NeumorphicButton(
            margin: EdgeInsets.only(top: 12),
            onClick: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          LotteryFull(sinlgeScheme: _schemeList[index])));
            },
            style: NeumorphicStyle(
                shape: NeumorphicShape.convex, border: NeumorphicBorder()),
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Column(
                    children: <Widget>[
                      Text('Scheme'),
                      Card(
                          color: Colors.white,
                          shape: CircleBorder(),
                          child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "₹ ${_schemeList[index].scheme.toString()}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ))),
                    ],
                  ),
                ),
                SizedBox(),
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Column(
                    children: <Widget>[
                      _schemeList[index].winnigAmountFrom !=
                              _schemeList[index].winnigAmountTo
                          ? Row(
                              children: <Widget>[
                                Text(
                                  'Winning Amount : ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                Text(
                                  " ₹ ${_schemeList[index].winnigAmountFrom} - ${_schemeList[index].winnigAmountTo}",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 18),
                                ),
                              ],
                            )
                          : Row(
                              children: <Widget>[
                                Text(
                                  'Winning Amount : ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                Text(
                                  " ₹ ${_schemeList[index].winnigAmountFrom}",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 18),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Total Winners will be: ',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          Text(
                            " ${_schemeList[index].winners}",
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
