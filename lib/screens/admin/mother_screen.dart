import 'package:flutter/material.dart';

// import 'package:bottom_bar/bottom_bar.dart';
import 'package:ksu_scholarship/constant/colors.dart' as color;
import 'package:ksu_scholarship/screens/admin/home_screen.dart';
import 'package:ksu_scholarship/screens/admin/setting_screen.dart';

class AdminMotherScreen extends StatefulWidget {
  static const String id = "admin_mother_screen";

  @override
  _AdminMotherScreenState createState() => _AdminMotherScreenState();
}

class _AdminMotherScreenState extends State<AdminMotherScreen> {
  int _currentTab = 0;
  final List<Widget> _screens = [
    AdminHomeScreen(),
    AdminSettingScreen(),
  ];
  final PageStorageBucket _bucket = PageStorageBucket();
  Widget _currentScreen = AdminHomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: _currentScreen,
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: color.primaryColor,
      //   onPressed: () {
      //     setState(() {
      //       _currentScreen = AdminHomeScreen();
      //       _currentTab = 0;
      //     });
      //   },
      //   child: Icon(
      //     Icons.home,
      //     color: Colors.white,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 8,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentScreen = AdminSettingScreen();
                      _currentTab = 1;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentTab == 1 ? color.primaryColor : Colors.white,
                    ),
                    child: Icon(
                      Icons.settings,
                      color: _currentTab == 1 ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Expanded(
                flex: 8,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentScreen = AdminHomeScreen();
                      _currentTab = 0;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentTab == 0 ? color.primaryColor : Colors.white,
                    ),
                    child: Icon(
                      Icons.home,
                      color: _currentTab == 0 ? Colors.white : Colors.grey,
                    ),
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
