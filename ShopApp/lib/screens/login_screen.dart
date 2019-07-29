import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:family_list/util/urls.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Map<String, String> _getBody() {
    return {"email": emailController.text, "password": passwordController.text};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Log In")),
        body: Column(
          children: <Widget>[
            Text("Email"),
            TextField(
              controller: emailController,
              textCapitalization: TextCapitalization.none,
            ),
            Text("Password"),
            TextField(
              controller: passwordController,
              obscureText: true,
            ),
            RaisedButton(
              child: Text("LOG IN"),
              onPressed: () async {
                print("logging in");
                final response = await http.post(signInURL,
                    headers: {
                      "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: _getBody());

                print(response.statusCode);
                if (response.statusCode == 200) {
                  print(response.body);
                  final storage = new FlutterSecureStorage();
                  await storage.write(key: "token", value: response.body);
                }
              },
            )
          ],
        ));
  }
}
