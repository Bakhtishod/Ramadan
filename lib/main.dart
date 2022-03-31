import 'package:flutter/material.dart';
import 'package:ramadan/data/constants.dart';
import 'package:ramadan/screens/home.dart';
import 'package:ramadan/screens/intro.dart';
import 'package:ramadan/screens/login.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    title: "Ramazon 2022",
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    home: IntroScreen(),
  ));
}
