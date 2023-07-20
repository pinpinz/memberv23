import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:member/account_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:member/main_page.dart';
import 'package:member/location_page.dart';

void main() => runApp(const StarbucksApp());
// var ip = "http://202.51.121.181:3030/ser/";

class StarbucksApp extends StatefulWidget {
  const StarbucksApp({Key? key}) : super(key: key);

  @override
  State<StarbucksApp> createState() => _StarbucksAppState();
}

class _StarbucksAppState extends State<StarbucksApp> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _kTabPages = [
      mainpage(),
      LocationPage(),
      accountpage(),
    ];
    final _kBottomNavBarItems = [
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.home_rounded,
            size: 30,
          ),
          label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.store_rounded, size: 30), label: 'Store'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.add_card_rounded, size: 30), label: 'Membership'),
    ];
    assert(_kTabPages.length == _kBottomNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      elevation: 10,
      backgroundColor: Colors.black,
      items: _kBottomNavBarItems,
      currentIndex: _currentTabIndex,
      selectedFontSize: 16,
      unselectedItemColor: Color.fromARGB(170, 245, 240, 225),
      selectedItemColor: Color.fromARGB(255, 245, 240, 225),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _kTabPages[_currentTabIndex],
        bottomNavigationBar: bottomNavBar,
      ),
    );
  }
}
