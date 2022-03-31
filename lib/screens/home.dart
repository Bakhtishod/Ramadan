import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ramadan/data/constants.dart';
import 'package:ramadan/data/constants.dart';
import 'package:ramadan/data/constants.dart';
import 'package:ramadan/screens/timetable.dart';
import 'package:ramadan/screens/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor,
      child: SafeArea(
        child: Scaffold(
          body: _selectedIndex == 0
              ? UserScreen()
              : TimeTable(),
          bottomNavigationBar: FloatingNavbar(
              backgroundColor: mainColor,
              selectedItemColor: mainColor,
              elevation: 30,
              onTap: (int val) => setState(() => _selectedIndex = val),
              currentIndex: _selectedIndex,
              items: [
                FloatingNavbarItem(icon: Icons.home, title: 'Bosh sahifa'.toUpperCase()),
                FloatingNavbarItem(icon: Icons.list_alt, title: 'Ramazon taqvimi'.toUpperCase()),
              ],
            ),
          ),
        ),
    );
  }
}
