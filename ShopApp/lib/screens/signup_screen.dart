import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:family_list/util/urls.dart';
import 'package:family_list/widgets/password_field.dart';

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

  void _signUp() async {
    final response = await http.post(signUpURL,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: _getBody());

    // TODO: Handle various error responses and codes
    // Save the user's info to secure storage on success
    if (response.statusCode == 200) {
      final storage = new FlutterSecureStorage();
      await storage.write(key: "username", value: nameController.text);
      await storage.write(key: "email", value: emailController.text);
      await storage.write(key: "password", value: passwordController.text);
      await storage.write(key: "token", value: response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sign Up")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Text("New User Sign Up",
                    style: TextStyle(fontFamily: "ProductSans", fontSize: 30)),
              ),
              Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 24),
                      child: Column(
                        children: <Widget>[
                          Text("Full Name",
                              style: TextStyle(
                                  fontFamily: "ProductSans", fontSize: 18)),
                          TextField(
                            controller: nameController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                hintText: 'John Smith',
                                icon: Icon(Icons.people)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24),
                      child: Column(
                        children: <Widget>[
                          Text("Email Address",
                              style: TextStyle(
                                  fontFamily: "ProductSans", fontSize: 18)),
                          TextField(
                            controller: emailController,
                            textCapitalization: TextCapitalization.none,
                            decoration: InputDecoration(
                                hintText: 'johnsmith@gmail.com',
                                icon: Icon(Icons.people)),
                          ),
                        ],
                      ),
                    ),
                    Text("Password",
                        style:
                            TextStyle(fontFamily: "ProductSans", fontSize: 18)),
                    PasswordField(passwordController),
                  ],
                ),
              ),
              RaisedButton(
                child: Text("SIGN UP"),
                onPressed: _signUp,
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          ),
        ));
  }
}
