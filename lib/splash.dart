import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool drop = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "images/logos/logo_user.png", //delivoo logo
          height: 130.0,
          width: 99.7,
        ),
      ),
    );
  }
}
