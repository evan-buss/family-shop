import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:family_list/util/urls.dart';
import 'package:family_list/widgets/password_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Map<String, String> _getBody() {
    return {"email": emailController.text, "password": passwordController.text};
  }

  void _logIn() async {
    print("logging in");
    final response = await http.post(signInURL,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: _getBody());

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      final storage = new FlutterSecureStorage();
      await storage.write(key: "token", value: response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Text("Member Sign In",
                  style: TextStyle(fontFamily: "ProductSans", fontSize: 30)),
            ),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                children: <Widget>[
                  // Email Form
                  Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Column(
                      children: <Widget>[
                        Text("Email",
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
                  // Password Form
                  Text("Password",
                      style:
                          TextStyle(fontFamily: "ProductSans", fontSize: 18)),
                  PasswordField(passwordController),
                ],
              ),
            ),
            RaisedButton(
              child: Text("LOG IN"),
              onPressed: _logIn,
              color: Colors.blue,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
