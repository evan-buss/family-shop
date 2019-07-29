import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:family_list/util/urls.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Map<String, String> _getBody() {
    return {
      "username": nameController.text,
      "email": emailController.text,
      "password": passwordController.text
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sign Up")),
        body: Column(children: <Widget>[
          Text(
            "Full Name",
          ),
          TextField(
            autofocus: true,
            controller: nameController,
          ),
          Text("Email Address"),
          TextField(
            controller: emailController,
          ),
          Text("Password"),
          TextField(
            obscureText: true,
            controller: passwordController,
          ),
          RaisedButton(
            child: Text("SIGN UP"),
            onPressed: () async {
              final response = await http.post(signUpURL,
                  headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                  },
                  body: _getBody());

              // TODO: Handle various error responses and codes
              // Save the user's info to secure storage on success
              if (response.statusCode == 200) {
                final storage = new FlutterSecureStorage();
                await storage.write(
                    key: "username", value: nameController.text);
                await storage.write(key: "email", value: emailController.text);
                await storage.write(
                    key: "password", value: passwordController.text);
                await storage.write(key: "token", value: response.body);
              }
            },
          )
        ]));
  }
}
