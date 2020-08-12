import 'package:grocerycustomerdemo/Components/bottom_bar.dart';
import 'package:grocerycustomerdemo/Routes/routes.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:flutter/material.dart';

class OrderPlaced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: EdgeInsets.all(60.0),
            child: Image.asset(
              'images/order_placed.png',
              height: 265.7,
              width: 260.7,
            ),
          ),
          Text(
            'Order Placed !!',
            style:
                Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 23.3,color: kMainTextColor),
          ),
          Text(
            '\n\nThanks for choosing us for\ndelivering your needs.\n\nYou can check your order status\nin my order section.',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: kDisabledColor),
          ),
          Spacer(
            flex: 2,
          ),
          BottomBar(
            text: 'My Orders',
            onTap: () => Navigator.pushNamed(context, PageRoutes.orderPage),
          )
        ],
      ),
    );
  }
}
