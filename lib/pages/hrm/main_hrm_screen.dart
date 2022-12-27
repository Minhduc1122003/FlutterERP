import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/constant.dart';
import 'account_screen.dart';
import 'assign_screen.dart';
import 'calendar_screen.dart';
import 'work_screen.dart';

class MainHRMScreen extends StatefulWidget {
  const MainHRMScreen({Key? key}) : super(key: key);

  @override
  State<MainHRMScreen> createState() => _MainHRMScreenState();
}

class _MainHRMScreenState extends State<MainHRMScreen> {
  int selectedIndex = 0;
  static const List<Widget> widgetOptions = <Widget>[
    WorkScreen(),
    AssignScreen(),
    CalendarScreen(),
    AccountScreen()
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FBF5),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey[400],
        selectedFontSize: 12,
        unselectedFontSize: 12,

        selectedLabelStyle: TextStyle(
          color: mainColor,
        ),
        unselectedLabelStyle: TextStyle(color: Colors.grey[400]),
        iconSize: 25,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Làm việc',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconData(0xee2d, fontFamily: 'MaterialIcons')),
            label: 'Giao việc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: 'Lịch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Tài khoản',
          ),
        ],

        selectedItemColor: mainColor,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        //onTap: (){},
      ),
    );
  }
}
