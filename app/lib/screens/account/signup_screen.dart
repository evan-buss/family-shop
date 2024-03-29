import 'package:family_list/models/state/app_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:family_list/util/text_styles.dart' as text_styles;
import 'package:family_list/widgets/form_fields.dart';
import 'package:family_list/widgets/utils.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final SignUpData _data = new SignUpData();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  // Contact server to create new account
  void _signUp() async {
    if (_formKey.currentState.validate()) {
      // Save all of the current form values (calls individual "onSave" attributes)
      _formKey.currentState.save();
      Provider.of<AppUser>(context, listen: true)
          .signup(_data, () => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(28),
          child: Column(
            children: <Widget>[
              // Page Title
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Text("New User Sign Up", style: text_styles.h2),
              ),
              // Name Section
              Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Full Name",
                      style: text_styles.h3,
                    ),
                    TextFormField(
                      autocorrect: false,
                      focusNode: _nameFocus,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onFieldSubmitted: (term) =>
                          fieldFocusChange(context, _nameFocus, _emailFocus),
                      onSaved: (value) => _data.name = value,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          hintText: 'John Smith', icon: Icon(Icons.person)),
                    ),
                  ],
                ),
              ),
              // Email Section
              Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Column(
                  children: <Widget>[
                    Text("Email Address",
                        style:
                            TextStyle(fontFamily: "ProductSans", fontSize: 18)),
                    EmailField(_emailFocus, _passwordFocus, _data)
                  ],
                ),
              ),
              // Password Section
              Text("Password",
                  style: TextStyle(fontFamily: "ProductSans", fontSize: 18)),
              PasswordField(_data, _passwordFocus),
              FamilyCreateFields(_data),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: RaisedButton(
                  child: Text("SIGN UP"),
                  onPressed: _signUp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
