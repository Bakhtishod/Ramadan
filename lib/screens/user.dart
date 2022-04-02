import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ramadan/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String userName = "";
  String cityName = "";
  int currentRamadanDay = 0;
  bool hasStarted = true;

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
    dayOfRamadan();
  }

  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString("name")!;
    cityName = prefs.getString("cityName")!;
    setState(() {});
  }

  dayOfRamadan() {
    String month = DateFormat("MM").format(DateTime.now());
    String date = DateFormat("dd").format(DateTime.now());
    String day = DateFormat("MM-dd").format(DateTime.now());
    if(month=="05" && date == "01"){
      currentRamadanDay=30;
    } else if(month=="04" && int.parse(date)>1) {
      currentRamadanDay = int.parse(date) - 2;
    } else{
      hasStarted=false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: hasStarted==false?
              Container(
                  child: Text("Bugun Ramazon oyi emas!", style: TextStyle(fontFamily: "Roboto", color: mainColor, fontSize: 30), textAlign: TextAlign.center,)):
          Container(
            color: mainColor,
            child: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString("assets/data.json"),
        builder: (context, snapshot) {
            var data = json.decode(snapshot.data.toString());
            return Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                userName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Roboto",
                                    fontSize: 22),
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      data[cityName][0]["times"]
                                          [currentRamadanDay]["date"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: "Roboto"),
                                      // textAlign: TextAlign.right,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(cityName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily: "Roboto"))
                                    ],
                                  )
                                ],
                              ))
                        ],
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(12),
                                child: Card(
                                  shadowColor: mainColor,
                                  elevation: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    // alignment: Alignment.centerLeft,
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Saharlik",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: mainColor,
                                              fontFamily: "Roboto"),
                                        ),
                                        Divider(
                                          color: mainColor,
                                          height: 2,
                                        ),
                                        Expanded(
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                data[cityName][0]["times"]
                                                    [currentRamadanDay]["fajr"],
                                                style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    color: mainColor,
                                                    fontSize: 36),
                                                textAlign: TextAlign.center,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(12),
                                child: Card(
                                  shadowColor: mainColor,
                                  elevation: 4,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    // alignment: Alignment.centerLeft,
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Iftorlik",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: mainColor,
                                            fontFamily: "Roboto",
                                          ),
                                        ),
                                        Divider(
                                          color: mainColor,
                                          height: 2,
                                        ),
                                        Expanded(
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                data[cityName][0]["times"]
                                                    [currentRamadanDay]["iftar"],
                                                style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    color: mainColor,
                                                    fontSize: 36),
                                                textAlign: TextAlign.center,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Card(
                                shadowColor: mainColor,
                                elevation: 10,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 4, right: 4),
                                        child: Text(
                                          "Ro'za tutish (saharlik, og'iz yopish) duosi",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: mainColor,
                                              fontFamily: "Roboto"),
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Divider(
                                        color: mainColor,
                                        height: 2,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "\tNavaytu an asuma sovma shahri romazona minal fajri ilal mag‘ribi, xolisan lillahi ta’ala. Allohu akbar.\n\n\tMa’nosi: Ramazon oyining ro‘zasini subhdan to kun botguncha tutmoqni niyat qildim. Xolis Alloh uchun. Alloh Buyukdir.",
                                            style: TextStyle(fontSize: 12, fontFamily: "Roboto", color: Colors.black87),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Card(
                                shadowColor: mainColor,
                                elevation: 10,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 4, right: 4),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Iftorlik (og'iz ochish) duosi",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: mainColor,
                                              fontFamily: "Roboto"),
                                        ),
                                      ),
                                      Divider(
                                        color: mainColor,
                                        height: 2,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "\tAllohumma laka sumtu va bika aamantu va aʼlayka tavakkaltu va aʼlaa rizqika aftartu, fag‘firliy ma qoddamtu va maa axxortu birohmatika yaa arhamar roohimiyn.\n\n\tMaʼnosi: Ey Alloh, ushbu Ro‘zamni Sen uchun tutdim va Senga iymon keltirdim va Senga tavakkal qildim va bergan rizqing bilan iftor qildim. Ey mehribonlarning eng mehriboni, mening avvalgi va keyingi gunohlarimni mag‘firat qilgil.",
                                            style: TextStyle(fontSize: 12, fontFamily: "Roboto", color: Colors.black87),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                )
              ],
            );
        },
      ),
          )),
    );
  }
}
