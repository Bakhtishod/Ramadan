import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ramadan/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/time.dart';

class TimeTable extends StatefulWidget {
  TimeTable({Key? key}) : super(key: key);

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  int cityIndex = 0;
  String userName = "";
  String cityName = "";

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString("name")!;
    cityName = prefs.getString("cityName")!;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString("assets/data.json"),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            var data = json.decode(snapshot.data.toString());
            return data == null
                    ? Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(mainColor),
                            strokeWidth: 10,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      )
                    : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: data[cityName][0]["times"].length,
                            itemBuilder: (BuildContext context, int index) {
                              return TimeWidget(
                                  date: data[cityName][0]["times"][index]["date"],
                                  fajr: data[cityName][0]["times"][index]["fajr"],
                                  iftar: data[cityName][0]["times"][index]
                                      ["iftar"]);
                            });
          },
        ),
      ),
    );
  }
}

