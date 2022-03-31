import 'package:flutter/material.dart';
import 'package:ramadan/screens/home.dart';
import 'package:ramadan/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import '../data/constants.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool userExists = false;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  checkUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("name")) userExists=true;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SplashScreen(
        seconds: 2,
        loadingText: Text(
          "Ramazon 2022",
          style: TextStyle(color: mainColor, fontFamily: "Roboto", fontSize: 34),
        ),

        image: Image.asset("assets/images/logo.png"),
        loaderColor: mainColor,
        photoSize: 140,
        navigateAfterSeconds: userExists==false?LogInScreen():HomeScreen(),
      ),

    );
  }
}
