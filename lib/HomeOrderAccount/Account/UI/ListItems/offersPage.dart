import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  List offers = [
    [
      'Flat 50% off on first household items',
      'FL50'
    ],
    [
      'Free delivery on first three orders',
      'FREE'
    ],
    [
      'Get 20rs off on first order',
      'GET1'
    ],
    [
      'Get free 500g sugar on min 200rs order',
      'G200'
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text('Offers', style: Theme.of(context).textTheme.bodyText1),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < offers.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 18,
                  ),
                  child: Container(
                    // height: 120,
                    decoration: BoxDecoration(
                      color: kOfferBgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 180,
                          margin: EdgeInsets.all(7),
                          child: Text(
                            offers[i][0],
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 14
                            ),
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 40,
                          margin: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: kMainColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              offers[i][1],
                              style:
                                  TextStyle(color: kWhiteColor, fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
