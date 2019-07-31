import 'package:family_list/models/AuthData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:family_list/util/urls.dart';
import 'package:family_list/util/text_styles.dart' as text_styles;
import 'package:family_list/widgets/form_fields.dart';
import 'package:family_list/widgets/utils.dart';

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

  Map<String, String> _getBody() {
    return {
      "username": _data.name,
      "email": _data.email,
      "password": _data.password
    };
  }

  // Contact server to create new account
  void _signUp() async {
    if (_formKey.currentState.validate()) {
      // Save all of the current form values (calls individual "onSave" attributes)
      _formKey.currentState.save();

      final response = await http.post(signUpURL,
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: _getBody());

      // TODO: Handle various error responses and codes
      // Save the user's info to secure storage on success
      if (response.statusCode == 200) {
        final storage = new FlutterSecureStorage();
        await storage.write(key: "username", value: _data.name);
        await storage.write(key: "email", value: _data.email);
        await storage.write(key: "password", value: _data.password);
        await storage.write(key: "token", value: response.body);

        Navigator.pop(context);
      }
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
                          hintText: 'John Smith', icon: Icon(Icons.people)),
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
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: RaisedButton(
                  child: Text("SIGN UP"),
                  onPressed: _signUp,
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
