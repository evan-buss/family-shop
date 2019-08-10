import 'dart:convert';

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

enum AppState { LOGGED_IN, LOGGED_OUT }

class AppUser with ChangeNotifier {
  int userID;
  String email;
  String password;
  String token;
  String username;

  AppState state = AppState.LOGGED_OUT;

  final storage = new FlutterSecureStorage();

  AppUser() {
    _loadIfCached();
  }

  void _loadIfCached() async {
    this.token = await storage.read(key: "token");
    if (token != null) {
      final response =
          await http.get(pingURL, headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        // User is authenticate
        this.userID = int.parse(await storage.read(key: "id"));
        this.email = await storage.read(key: "email");
        this.password = await storage.read(key: "password");
        this.username = await storage.read(key: "username");
        state = AppState.LOGGED_IN;
        notifyListeners();
      } else if (response.statusCode == 401) {
        //Unauthorized. Attempt to log in again to refresh token...
        print("REFRESHING JWT !!!");
        var success = await _logWithSavedInfo();
      }
    }
  }

  // Log the user out of the app. Remove all their data from secure storage.
  void logOut() async {
    await storage.delete(key: "userID");
    await storage.delete(key: "email");
    await storage.delete(key: "password");
    await storage.delete(key: "token");
    await storage.delete(key: "username");

    this.userID = null;
    this.email = null;
    this.password = null;
    this.token = null;
    this.username = null;
    state = AppState.LOGGED_OUT;
    notifyListeners();
  }

  // Use the stored username and password to try to relog-in.
  Future<bool> _logWithSavedInfo() async {
    final response = await http.post(signInURL, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "email": await storage.read(key: "email"),
      "password": await storage.read(key: "password")
    }).timeout(new Duration(seconds: 4));

    // Save the info to local storage if login successful.
    if (response.statusCode == 200) {
      // TODO: Set the appropriate variables and storage if success...
      return true;
    }
    return false;
  }

  void login(LoginData data, Function callback) async {
    try {
      final response = await http.post(signInURL, headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      }, body: {
        "email": data.email,
        "password": data.password
      }).timeout(new Duration(seconds: 4));

      if (response.statusCode == 200) {
        _parseServerResponse(response.body, data);
        state = AppState.LOGGED_IN;
        notifyListeners();
      }
      callback(response.statusCode);
    } catch (_) {
      print("error");
      callback(503);
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

    // Save the user's info to secure storage on success
    if (response.statusCode == 200) {
      _parseServerResponse(response.body, data);
      state = AppState.LOGGED_IN;
      notifyListeners();
      callback();
    }
  }

  // Save the user's form data and the server's response data on successful log in / sign up
  void _parseServerResponse(String responseBody, LoginData data) async {
    var response = json.decode(responseBody);

    this.userID = response["id"];
    this.email = data.email;
    this.password = data.password;
    this.token = response["token"];
    this.username = response["username"];

    await storage.write(key: "id", value: this.userID.toString());
    await storage.write(key: "email", value: this.email);
    await storage.write(key: "password", value: this.password);
    await storage.write(key: "token", value: this.token);
    await storage.write(key: "username", value: this.username);
  }
}
