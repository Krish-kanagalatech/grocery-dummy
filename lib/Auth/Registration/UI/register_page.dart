import 'package:grocerycustomerdemo/Components/bottom_bar.dart';
import 'package:grocerycustomerdemo/Components/entry_field.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../../login_navigator.dart';

//register page for registration of a new user
class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Register',
          style: TextStyle(fontSize: 16.7),
        ),
      ),

      //this column contains 3 textFields and a bottom bar
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    // _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: <Widget>[
              Divider(
                color: kCardBackgroundColor,
                thickness: 8.0,
              ),
              //name textField
              EntryField(
                textCapitalization: TextCapitalization.words,
                controller: _nameController,
                label: 'FULL NAME',
                image: 'images/icons/ic_name.png',
              ),
              //email textField
              EntryField(
                textCapitalization: TextCapitalization.none,
                controller: _emailController,
                label: 'EMAIL ADDRESS',
                image: 'images/icons/ic_mail.png',
                keyboardType: TextInputType.emailAddress,
              ),

              //phone textField
              EntryField(
                label: 'PHONE NUMBER',
                image: 'images/icons/ic_phone.png',
                keyboardType: TextInputType.number,
              ),

              Text(
                "We'll send verification code on above given number.",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),

        //continue button bar
        BottomBar(
            text: "Continue",
            onTap: () {
              Navigator.pushNamed(context, LoginRoutes.verification);
            })
      ],
    );
  }
}
