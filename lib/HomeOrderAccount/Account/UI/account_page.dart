import 'dart:ui';

import 'package:grocerycustomerdemo/Components/list_tile.dart';
import 'package:grocerycustomerdemo/Routes/routes.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account', style: Theme.of(context).textTheme.bodyText1),
        centerTitle: true,
      ),
      body: Account(),
    );
  }
}

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String number;
  //AccountBloc _accountBloc;

  @override
  void initState() {
    super.initState();
    // _accountBloc = BlocProvider.of<AccountBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserDetails(),
        Divider(
          color: kCardBackgroundColor,
          thickness: 8.0,
        ),
        AddressTile(),
        BuildListTile(
          image: 'images/account/ic_menu_supportact.png',
          text: 'Offers',
          onTap: () => Navigator.pushNamed(context, PageRoutes.offersPage),
        ),
        BuildListTile(
            image: 'images/account/ic_menu_tncact.png',
            text: 'Terms & Conditions',
            onTap: () => Navigator.pushNamed(context, PageRoutes.tncPage)),
        BuildListTile(
            image: 'images/account/ic_menu_supportact.png',
            text: 'Support',
            onTap: () => Navigator.pushNamed(context, PageRoutes.supportPage,
                arguments: number)),
        BuildListTile(
          image: 'images/account/ic_menu_aboutact.png',
          text: 'About us',
          onTap: () => Navigator.pushNamed(context, PageRoutes.aboutUsPage),
        ),
        LogoutTile(),
        Divider(
          color: kCardBackgroundColor,
          thickness: 8.0,
        ),
        Container(
          child: Center(
            child: Text(
              'Made by Kangana tech',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddressTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildListTile(
        image: 'images/account/ic_menu_addressact.png',
        text: 'Saved Addresses',
        onTap: () {
          Navigator.pushNamed(context, PageRoutes.savedAddressesPage);
        });
  }
}

class LogoutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BuildListTile(
      image: 'images/account/ic_menu_logoutact.png',
      text: 'Logout',
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Logging out'),
                content: Text('Are you sure?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    textColor: kMainColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: kTransparentColor)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                      child: Text('Yes'),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: kTransparentColor)),
                      textColor: kMainColor,
                      onPressed: () {
                        Phoenix.rebirth(context);
                      })
                ],
              );
            });
      },
    );
  }
}

class UserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        child: Image.asset('images/page.jpeg'),
      )
      // Container(
      //   child: Stack(
      //     children: [
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Text(
      //             '\n' + 'Samantha Smith',
      //             style: Theme.of(context).textTheme.bodyText1,
      //           ),
      //           Text(
      //             '\n' + 'Phone Number',
      //             style: Theme.of(context).textTheme.subtitle2.copyWith(
      //                   color: Color(0xff9a9a9a),
      //                 ),
      //           ),
      //           SizedBox(
      //             height: 5.0,
      //           ),
      //           Text('samanthasmith@gmail.com',
      //               style: Theme.of(context)
      //                   .textTheme
      //                   .subtitle2
      //                   .copyWith(color: Color(0xff9a9a9a))),
      //         ],
      //       ),
      //       Container(
      //         height: 140,
      //         width: double.infinity,
      //         color: Colors.black.withOpacity(1),
      //         child: Center(
      //           child: Text(
      //             "LOGIN DETAIILS",
      //             style: TextStyle(color: Colors.white),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
