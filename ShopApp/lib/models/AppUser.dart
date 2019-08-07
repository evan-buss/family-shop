import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:family_list/util/urls.dart';

class LoginData {
  String email;
  String password;
}

class SignUpData extends LoginData {
  String name;
}

class AppUser with ChangeNotifier {
  String username;
  String email;
  String password;
  String token;

  final storage = new FlutterSecureStorage();

  AppUser() {
    print("App user constructor called !!!");
  }

  // TODO: In the future the server should be pinged to renew token if necessary...
  void loadIfCached() async {
    this.token = await storage.read(key: "token");
    if (token != null) {
      notifyListeners();
    }
  }

  // Log the user out of the app. Remove all their data from secure storage.
  void logOut() async {
    await storage.delete(key: "username");
    await storage.delete(key: "email");
    await storage.delete(key: "password");
    await storage.delete(key: "token");
    this.token = null;
    this.username = null;
    this.password = null;
    this.email = null;
    notifyListeners();
  }

  void login(LoginData data, Function callback) async {
    final response = await http.post(signInURL,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"email": data.email, "password": data.password});

    if (response.statusCode == 200) {
      await storage.write(key: "token", value: response.body);
      this.token = response.body;
      notifyListeners();
      callback();
    }
  }

  void signup(SignUpData data, Function callback) async {
    final response = await http.post(signUpURL, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "username": data.name,
      "email": data.email,
      "password": data.password
    });

    // TODO: Handle various error responses and codes
    // Save the user's info to secure storage on success
    if (response.statusCode == 200) {
      await storage.write(key: "username", value: data.name);
      this.username = data.name;
      await storage.write(key: "email", value: data.email);
      this.email = data.email;
      await storage.write(key: "password", value: data.password);
      this.password = data.password;
      await storage.write(key: "token", value: response.body);
      this.token = response.body;
      notifyListeners();
      callback();
    }
  }
}

// Utility method to retrieve the saved JWT token
// Future<String> getAuthToken() async {
//   final storage = FlutterSecureStorage();
//   final token = await storage.read(key: "token");
//   return "Bearer " + token;
// }

// void setAuthToken(String token) async {
//   final storage = new FlutterSecureStorage();
//   await storage.write(key: "token", value: token);
// }
