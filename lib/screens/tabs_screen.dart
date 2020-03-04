import 'package:flutter/material.dart';

import '../screens/homepage_screen.dart';
import '../screens/investments_screen.dart';
import '../screens/search_screen.dart';
import '../screens/global_screen.dart';
import '../screens/settings_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': HomepageScreen(), 'title': 'StockNinja'},
    {
      'page': WillPopScope(
          child: InvestmentsScreen(),
          onWillPop: () {
            return;
          }),
      'title': 'Stocks'
    },
    {
      'page': WillPopScope(
          child: GlobalScreen(),
          onWillPop: () {
            return;
          }),
      'title': 'Global'
    },
    {
      'page': WillPopScope(
          child: SearchScreen(),
          onWillPop: () {
            return;
          }),
      'title': 'Tüm Hisseler'
    },
    {
      'page': WillPopScope(
          child: SettingsScreen(),
          onWillPop: () {
            return;
          }),
      'title': 'Ayarlar'
    },
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _selectPage,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              title: Text('Homepage'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              title: Text('Events'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.blur_circular),
              title: Text('Favorites'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Giriş Yap'),
            )
          ],
        ),
      ),
    );
  }
}
