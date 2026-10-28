import 'package:flutter/material.dart';

import '../screens/dashboard_screen.dart';
import '../screens/markets_screen.dart';
import '../screens/portfolio_screen.dart';
import '../screens/pro_screen.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;

  const BottomNav({
    super.key,
    required this.currentIndex,
  });

  void _navigate(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget page;

    switch (index) {
      case 0:
        page = const DashboardScreen();
        break;
      case 1:
        page = const MarketsScreen();
        break;
      case 2:
        page = const PortfolioScreen();
        break;
      default:
        page = const ProScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff0A1020),
        border: Border(
          top: BorderSide(
            color: Colors.white12,
            width: 0.5,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,

        elevation: 0,

        backgroundColor: const Color(0xff0A1020),

        selectedItemColor: Colors.green,

        unselectedItemColor: Colors.grey,

        selectedFontSize: 11,
        unselectedFontSize: 11,

        iconSize: 23,

        showSelectedLabels: true,
        showUnselectedLabels: true,

        selectedIconTheme: const IconThemeData(
          size: 24,
        ),

        unselectedIconTheme: const IconThemeData(
          size: 24,
        ),

        onTap: (index) => _navigate(context, index),

        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.home_rounded),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.show_chart_rounded),
            ),
            label: "Markets",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.account_balance_wallet_rounded),
            ),
            label: "Portfolio",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.workspace_premium_rounded),
            ),
            label: "Pro",
          ),
        ],
      ),
    );
  }
}