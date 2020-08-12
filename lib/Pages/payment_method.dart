import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocerycustomerdemo/Components/list_tile.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:grocerycustomerdemo/Routes/routes.dart';

class PaymentPage extends StatelessWidget {
  double amount;
  PaymentPage(this.amount);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Select Payment Method',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: kMainTextColor),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Amount to Pay \u{20B9} $amount',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: kDisabledColor),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            color: kCardBackgroundColor,
            child: Text('CARDS',
                style: Theme.of(context).textTheme.caption.copyWith(
                    color: kDisabledColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.67)),
          ),
          BuildListTile(
            image: 'images/payment/payment_card.png',
            text: 'Credit Card',
            onTap: () {
              FToast flutterToast;
              flutterToast = FToast(context);
              flutterToast.removeCustomToast();
              flutterToast.removeQueuedCustomToasts();
              flutterToast.showToast(
                  toastDuration: Duration(seconds: 2),
                  child: Container(
                    child: Text('This is demo app no payment'),
                  ));
            },
          ),
          BuildListTile(
            image: 'images/payment/payment_card.png',
            text: 'Debit Card',
            onTap: () {
              FToast flutterToast;
              flutterToast = FToast(context);
              flutterToast.removeCustomToast();
              flutterToast.removeQueuedCustomToasts();
              flutterToast.showToast(
                  toastDuration: Duration(seconds: 2),
                  child: Container(
                    child: Text('This is demo app no payment'),
                  ));
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            color: kCardBackgroundColor,
            child: Text(
              'CASH',
              style: Theme.of(context).textTheme.caption.copyWith(
                  color: kDisabledColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.67),
            ),
          ),
          BuildListTile(
              image: 'images/payment/payment_cod.png',
              text: 'Cash on Delivery',
              onTap: () {
                FToast flutterToast;
                flutterToast = FToast(context);
                flutterToast.removeCustomToast();
                flutterToast.removeQueuedCustomToasts();
                flutterToast.showToast(
                    toastDuration: Duration(seconds: 2),
                    child: Container(
                      child: Text('This is demo app no payment'),
                    ));
                // Navigator.popAndPushNamed(context, PageRoutes.orderPlaced);
              }),
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          //   color: kCardBackgroundColor,
          //   child: Text(
          //     'OTHER',
          //     style: Theme.of(context).textTheme.caption.copyWith(
          //         color: kDisabledColor,
          //         fontWeight: FontWeight.bold,
          //         letterSpacing: 0.67),
          //   ),
          // ),
          // BuildListTile(
          //   image: 'images/payment/payment_paypal.png',
          //   text: 'PayPal',
          // ),
          // BuildListTile(
          //   image: 'images/payment/payment_payu.png',
          //   text: 'PayU Money',
          // ),
          // BuildListTile(
          //   image: 'images/payment/payment_stripe.png',
          //   text: 'Stripe',
          // ),
          Expanded(
            child: Container(
              color: kCardBackgroundColor,
            ),
          )
        ],
      ),
    );
  }
}
