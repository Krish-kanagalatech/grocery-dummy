import 'package:grocerycustomerdemo/Chat/UI/animated_bottom_bar.dart';
import 'package:grocerycustomerdemo/Components/search_bar.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Account/UI/account_page.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Home/UI/home.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Order/UI/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeOrderAccount extends StatefulWidget {
  @override
  _HomeOrderAccountState createState() => _HomeOrderAccountState();
}

class _HomeOrderAccountState extends State<HomeOrderAccount> {

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  final List<BarItem> barItems = [
    BarItem(
      text: 'Home',
      image: bottomIconHome,
    ),
    BarItem(
      text: 'Search',
      image: bottomIconSearch,
    ),
    BarItem(
      text: 'Order',
      image: bottomIconOrder,
    ),
    BarItem(
      text: 'Account',
      image: bottomIconAccount,
    ),
  ];

  final List<Widget> _children = [
    HomePage(),
    CustomSearchBar(hint: "Enter item to search",),
    OrderPage(),
    AccountPage(),
  ];

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static String bottomIconHome = 'images/footermenu/ic_home.png';

  static String bottomIconOrder = 'images/footermenu/ic_orders.png';

  static String bottomIconAccount = 'images/footermenu/ic_profile.png';

  static String bottomIconSearch = 'images/footermenu/ic_search.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: AnimatedBottomBar(
          barItems: barItems,
          onBarTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}