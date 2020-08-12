import 'package:grocerycustomerdemo/Auth/login_navigator.dart';
import 'package:grocerycustomerdemo/HomeOrderAccount/Home/UI/home.dart';
import 'package:grocerycustomerdemo/Locale/locales.dart';
import 'package:grocerycustomerdemo/Routes/routes.dart';
import 'package:grocerycustomerdemo/Themes/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:grocerycustomerdemo/providers/categoryProvider.dart';
import 'package:provider/provider.dart';

import 'HomeOrderAccount/home_order_account.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(Phoenix(child: Delivoo()));
}

class Delivoo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: Consumer<CategoryProvider>(
        builder: (ctx, cate, _) {
          return MaterialApp(
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'),
              const Locale('hi'),
            ],
            theme: appTheme,
            // home: LoginNavigator(),
            home: HomeOrderAccount(),
            routes: PageRoutes().routes(),
          );
        },
      ),
      providers: [
        ChangeNotifierProvider.value(
          value: CategoryProvider(),
        ),
      ],
    );
  }
}
