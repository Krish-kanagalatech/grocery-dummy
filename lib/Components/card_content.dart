import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';

class CardContent extends StatelessWidget {
  final String text;
  final CachedNetworkImageProvider image;

  CardContent({this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Padding(
              padding: EdgeInsets.only(bottom: 0.0),
              child: Container(
                decoration: BoxDecoration(image: DecorationImage(image: image)),
              )),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          flex: 2,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kitemColor,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
