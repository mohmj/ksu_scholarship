import 'package:flutter/material.dart';

// import 'package:bottom_bar/bottom_bar.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;
import 'package:ksu_scholarship/screens/home_screen.dart';
import 'package:ksu_scholarship/screens/profile_screen.dart';
import 'package:ksu_scholarship/screens/setting_screen.dart';

class MotherScreen extends StatefulWidget {
  static const String id = "mother_screen_ss";

  @override
  _MotherScreenState createState() => _MotherScreenState();
}

class _MotherScreenState extends State<MotherScreen> {
  int _currentTab = 1;
  final List<Widget> _screens = [
    SettingScreen(),
    HomeScreen(),
    ProfileScreen(),
  ];

  final PageStorageBucket _bucket = PageStorageBucket();
  Widget _currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: _currentScreen,
        bucket: _bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color.primaryColor,
        onPressed: () {
          setState(() {
            _currentScreen = HomeScreen();
            _currentTab = 1;
          });
        },
        child: Icon(
          Icons.home,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentScreen = SettingScreen();
                      _currentTab = 0;
                    });
                  },
                  child: Icon(
                    Icons.settings,
                    color: _currentTab == 0 ? color.primaryColor : Colors.grey,
                  ),
                ),
              ),
              Expanded(child: Container()),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentScreen = ProfileScreen();
                      _currentTab = 2;
                    });
                  },
                  child: Icon(
                    Icons.person,
                    color: _currentTab == 2 ? color.primaryColor : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
