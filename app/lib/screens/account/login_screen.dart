import 'package:family_list/models/state/app_user.dart';
import 'package:flutter/material.dart';

import 'package:family_list/widgets/form_fields.dart';
import 'package:family_list/util/text_styles.dart' as text_styles;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginData _data = new LoginData();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String errorString = "";

  // Contact server to log in
  void _logIn() async {
    // Save all of the current form values (calls individual "onSave" attributes)
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // Callback. Either go back or show the error code.
      Provider.of<AppUser>(context, listen: true).login(_data,
          (int statusCode) {
        if (statusCode == 200) {
          Navigator.pop(context);
        } else {
          if (statusCode == 400) {
            setState(() {
              this.errorString = "Invalid login credentials";
            });
          } else if (statusCode == 503) {
            setState(() {
              this.errorString = "Unable to connect to server";
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(28),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Text("Member Sign In", style: text_styles.h2),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Column(
                  children: <Widget>[
                    Text("Email Address", style: text_styles.h3),
                    EmailField(_emailFocus, _passwordFocus, _data)
                  ],
                ),
              ),
              Text("Password", style: text_styles.h3),
              PasswordField(_data, _passwordFocus),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: RaisedButton(
                  child: Text("LOG IN"),
                  onPressed: _logIn,
                ),
              ),
              Visibility(
                child: Text(
                  this.errorString,
                  style:
                      TextStyle(color: Theme.of(context).errorColor, fontWeight: FontWeight.bold),
                ),
                visible: this.errorString.isNotEmpty,
              )
            ],
          ),
        ),
      ),
    );
  }
}
