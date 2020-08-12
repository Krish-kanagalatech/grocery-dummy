import 'package:grocerycustomerdemo/Auth/MobileNumber/UI/mobile_input.dart';
import 'package:grocerycustomerdemo/Locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//first page that takes phone number as input for verification
class PhoneNumber extends StatelessWidget {
  static const String id = 'phone_number';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //used for scrolling when keyboard pops up
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Spacer(),
              Image.asset(
                "images/logos/logo_user.png", //delivoo logo
                height: 130.0,
                width: 99.7,
              ),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                ),
              ),

              //text on page
              Text(AppLocalizations.of(context).bodyText1,
                  style: Theme.of(context).textTheme.bodyText1),
              Text(
                AppLocalizations.of(context).bodyText2,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 87.3,
              ),
              Image.asset(
                "images/logos/Delivery.gif", //footer image
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: MobileInput(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
