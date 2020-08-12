import 'dart:async';

import 'package:grocerycustomerdemo/Components/bottom_bar.dart';
import 'package:grocerycustomerdemo/Components/entry_field.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//Verification page that sends otp to the phone number entered on phone number page
class VerificationPage extends StatelessWidget {
  final VoidCallback onVerificationDone;

  VerificationPage(this.onVerificationDone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Verification',
          style: TextStyle(fontSize: 16.7),
        ),
      ),
      body: OtpVerify(onVerificationDone),
    );
  }
}

//otp verification class
class OtpVerify extends StatefulWidget {
  final VoidCallback onVerificationDone;

  OtpVerify(this.onVerificationDone);

  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final TextEditingController _controller = TextEditingController();

  // VerificationBloc _verificationBloc;
  bool isDialogShowing = false;
  int _counter = 20;
  Timer _timer;

  _startTimer() {
    //shows timer
    _counter = 20; //time counter

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
  }

  void verifyPhoneNumber() {
    //verify phone number method using otp
    _startTimer();

    //int resendToken;
    //_verificationBloc = BlocProvider.of<VerificationBloc>(context);
//    FirebaseAuth.instance.verifyPhoneNumber(
//      phoneNumber: widget.phoneNumber,
//      timeout: Duration(seconds: 5),
//      verificationCompleted: (AuthCredential authCredential) =>
//          _verificationBloc.add(VerificationSuccessEvent(
//              authCredential, widget.name, widget.email)),
//
//      //This callback would gets called when verification is done automatically
//      verificationFailed: (AuthException authException) =>
//          _verificationBloc.add(VerificationFailureEvent(authException)),
//      codeSent: (String verId, [int forceCodeResend]) {
//        resendToken = forceCodeResend;
//        _verificationBloc.add(PhoneCodeSentEvent(verId));
//      },
//      codeAutoRetrievalTimeout: (String verId) =>
//          _verificationBloc.add(CodeAutoRetrievalTimeoutEvent(verId)),
//      forceResendingToken: resendToken,
//    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Divider(
          color: kCardBackgroundColor,
          thickness: 8.0,
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Enter verification code we've sent on given number.",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 22, color: Colors.black87),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0, right: 20.0),
          child: EntryField(
            controller: _controller,
            readOnly: false,
            label: 'ENTER VERIFICATION CODE',
            maxLength: 6,
            keyboardType: TextInputType.number,
          ),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                '$_counter sec',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            FlatButton(
                shape: RoundedRectangleBorder(side: BorderSide.none),
                padding: EdgeInsets.all(24.0),
                disabledTextColor: kDisabledColor,
                textColor: kMainColor,
                child: Text(
                  "Resend",
                  style: TextStyle(
                    fontSize: 16.7,
                  ),
                ),
                onPressed: _counter < 1
                    ? () {
                        verifyPhoneNumber();
                      }
                    : null),
          ],
        ),
        BottomBar(
            text: "Continue",
            onTap: () {
              widget.onVerificationDone();

//                  _verificationBloc.add(SubmittedEvent(
//                      _controller.text, widget.name, widget.email));
            }),
      ],
    );
  }
}
