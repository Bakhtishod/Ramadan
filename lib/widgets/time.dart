import 'package:flutter/material.dart';

import '../data/constants.dart';

class TimeWidget extends StatelessWidget {
  String date, fajr, iftar;

  TimeWidget(
      {Key? key, required this.date, required this.fajr, required this.iftar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: mainColor,
      elevation: 2,
      child: Container(
        margin: EdgeInsets.all(6),
        padding: EdgeInsets.only(left: 8, right: 4),
        height: 40,
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(date, style: TextStyle(fontSize: 16, fontFamily: "Roboto"),)),
            Expanded(
                flex: 1,
                child: Text(fajr, style: TextStyle(fontSize: 16, fontFamily: "Roboto"))),
            Expanded(
                flex: 1,
                child: Text(iftar, style: TextStyle(fontSize: 16, fontFamily: "Roboto"))),
          ],
        ),
      ),
    );
  }
}
