import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/view/screens/home_screen.dart';
import 'package:euzzit/view/screens/insight_screen.dart';
import 'package:euzzit/view/screens/setting_screen.dart';

class WalletStartupScreen extends StatefulWidget {
  @override
  _WalletStartupScreenState createState() => _WalletStartupScreenState();
}

class _WalletStartupScreenState extends State<WalletStartupScreen> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final List<Widget> _tabItems = [
    euzzitHomeScreen(),
    InsightScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Image.asset('assets/Icon/wallet white.png',
                width: 30,
                height: 30,
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Image.asset(
                'assets/Icon/insight.png',
                width: 30,
                height: 30,
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Image.asset(
                'assets/Icon/tools.png',
                width: 30,
                height: 30,
              ),
            ),
          ],
          color: ColorResources.COLOR_PRIMARY_DARK,
          buttonBackgroundColor: ColorResources.COLOR_PRIMARY_DARK,
          backgroundColor: ColorResources.COLOR_WHITE,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: _tabItems[_page]);
  }
}
