import 'package:family_list/models/AuthData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:family_list/util/urls.dart';
import 'package:family_list/widgets/form_fields.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthData _data = new AuthData();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  // Retrieve json formatted body containing user data
  Map<String, String> _getBody() {
    return {"email": _data.email, "password": _data.password};
  }

  // Contact server to log in
  void _logIn() async {
    // Save all of the current form values (calls individual "onSave" attributes)
    _formKey.currentState.save();

    print(_data.email + "  " + _data.password);

    final response = await http.post(signInURL,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: _getBody());

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      final storage = new FlutterSecureStorage();
      await storage.write(key: "token", value: response.body);
      Navigator.pop(context);
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
                child: Text("Member Sign In",
                    style: TextStyle(fontFamily: "ProductSans", fontSize: 30)),
              ),
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
              Text("Password",
                  style: TextStyle(fontFamily: "ProductSans", fontSize: 18)),
              PasswordField(_data, _passwordFocus),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: RaisedButton(
                  child: Text("LOG IN"),
                  onPressed: _logIn,
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
