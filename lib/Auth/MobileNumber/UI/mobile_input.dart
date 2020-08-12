import 'package:country_code_picker/country_code_picker.dart';
import 'package:grocerycustomerdemo/Auth/login_navigator.dart';
import 'package:grocerycustomerdemo/Components/entry_field.dart';
import 'package:grocerycustomerdemo/Locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocerycustomerdemo/providers/categoryProvider.dart';
import 'package:provider/provider.dart';

class MobileInput extends StatefulWidget {
  @override
  _MobileInputState createState() => _MobileInputState();
}

class _MobileInputState extends State<MobileInput> {
  final TextEditingController _controller = TextEditingController();

  //MobileBloc _mobileBloc;
  String isoCode;

  @override
  void initState() {
    super.initState();
    //_mobileBloc = BlocProvider.of<MobileBloc>(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CountryCodePicker(
          onChanged: (value) {
            isoCode = value.code;
          },
          builder: (value) => buildButton(value),
          initialSelection: '+91',
          textStyle: Theme.of(context).textTheme.caption,
          showFlag: false,
          showFlagDialog: true,
          favorite: ['+91', 'US'],
        ),
        SizedBox(
          width: 10.0,
        ),
        //takes phone number as input
        Expanded(
          child: EntryField(
            controller: _controller,
            keyboardType: TextInputType.number,
            readOnly: false,
            hint: AppLocalizations.of(context).mobileText,
            maxLength: 10,
            border: InputBorder.none,
          ),
        ),

        //if phone number is valid, button gets enabled and takes to register screen
        RaisedButton(
          child: Text(
            AppLocalizations.of(context).continueText,
            style: Theme.of(context).textTheme.button,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () {
            var auth = Provider.of<CategoryProvider>(context,listen: false);
            auth.sendVerification(_controller.text);
            Navigator.pushNamed(context, LoginRoutes.registration);
//              _mobileBloc.add(SubmittedEvent(
//                  isoCode: isoCode, mobileNumber: _controller.text));
          },
        ),
      ],
    );
  }

  void goToNextScreen(
      bool isRegistered, String normalizedPhoneNumber, BuildContext context) {
    if (isRegistered) {
      Navigator.pushNamed(
        context,
        LoginRoutes.verification,
      );
    } else {
      Navigator.pushNamed(
        context,
        LoginRoutes.registration,
      );
    }
  }

  buildButton(CountryCode isoCode) {
    return Row(
      children: <Widget>[
        Text(
          '$isoCode',
          style: Theme.of(context).textTheme.caption,
        ),
//        IconButton(
//          icon: Icon(Icons.arrow_drop_down),
//        ),
      ],
    );
  }
}
