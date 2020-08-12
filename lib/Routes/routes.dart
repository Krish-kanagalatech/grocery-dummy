import 'package:grocerycustomerdemo/Auth/login_navigator.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Account/UI/ListItems/offersPage.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Account/UI/ListItems/support_page.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Account/UI/account_page.dart';
import 'package:grocerycustomerdemo/Chat/UI/chat_page.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Home/UI/home.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/home_order_account.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Order/UI/order_page.dart';
import 'package:grocerycustomerdemo/Maps/UI/location_page.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Account/UI/ListItems/about_us_page.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Account/UI/ListItems/saved_addresses_page.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Account/UI/ListItems/tnc_page.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Home/UI/order_placed_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocerycustomerdemo/Pages/items.dart';
import 'package:grocerycustomerdemo/Pages/view_cart.dart';
import 'package:grocerycustomerdemo/Pages/order_placed.dart';
import 'package:grocerycustomerdemo/Pages/payment_method.dart';

class PageRoutes {
  static const String locationPage = 'location_page';
  static const String homeOrderAccountPage = 'home_order_account';
  static const String homePage = 'home_page';
  static const String accountPage = 'account_page';
  static const String orderPage = 'order_page';
  static const String items = 'items';
  static const String tncPage = 'tnc_page';
  static const String aboutUsPage = 'about_us_page';
  static const String offersPage = 'offersPage';
  static const String savedAddressesPage = 'saved_addresses_page';
  static const String supportPage = 'support_page';
  static const String loginNavigator = 'login_navigator';
  static const String orderMapPage = 'order_map_page';
  static const String chatPage = 'chat_page';
  static const String viewCart = 'view_cart';
  static const String orderPlaced = 'order_placed';
  static const String paymentMethod = 'payment_method';

  Map<String, WidgetBuilder> routes() {
    return {
      locationPage: (context) => LocationPage(true),
      homeOrderAccountPage: (context) => HomeOrderAccount(),
      homePage: (context) => HomePage(),
      orderPage: (context) => OrderPage(),
      accountPage: (context) => AccountPage(),
      tncPage: (context) => TncPage(),
      aboutUsPage: (context) => AboutUsPage(),
      savedAddressesPage: (context) => SavedAddressesPage(),
      supportPage: (context) => SupportPage(),
      loginNavigator: (context) => LoginNavigator(),
      orderMapPage: (context) => OrderMapPage(),
      chatPage: (context) => ChatPage(),
      items: (context) => ItemsPage('',null,''),
      viewCart: (context) => ViewCart(),
      paymentMethod: (context) => PaymentPage(0),
      orderPlaced: (context) => OrderPlaced(),
      offersPage: (context) => OffersPage()
    };
  }
}
