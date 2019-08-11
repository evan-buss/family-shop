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
  String familyName;
  String inviteCode;
}

enum AppState { LOGGED_IN, LOGGED_OUT }

class AppUser with ChangeNotifier {
  int userID;
  int familyID;
  String email;
  String password;
  String token;
  String username;

  AppState state = AppState.LOGGED_OUT;
  final storage = new FlutterSecureStorage();

  AppUser() {
    _loadIfCached();
  }

  /// Load the user's data into memory if available.
  ///
  /// Also checks if the stored JWT is still valid and not expired.
  /// If the token has expired, log the user in again and get a new one.
  void _loadIfCached() async {
    this.token = await storage.read(key: "token");
    if (token != null) {
      final response =
          await http.get(pingURL, headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        // User's saved data is valid, load into memory
        this.userID = int.parse(await storage.read(key: "id"));
        this.email = await storage.read(key: "email");
        this.password = await storage.read(key: "password");
        this.username = await storage.read(key: "username");
        state = AppState.LOGGED_IN;
        notifyListeners();
      } else if (response.statusCode == 401) {
        // Unauthorized. Attempt to log in again to refresh token...
        print("REFRESHING JWT !!!");
        var success = await _logWithSavedInfo();
        if (!success) {
          print("unable to refresh TOKEN");
        }
      }
    }
  }

  /// Log out and remove all locally stored user data.
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

  /// Log the user in with locally stored info.
  Future<bool> _logWithSavedInfo() async {
    final response = await http.post(signInURL, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "email": await storage.read(key: "email"),
      "password": await storage.read(key: "password")
    }).timeout(new Duration(seconds: 4));

    // Save the new token to local storage if login successful.
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      this.token = data["json"];
      await storage.write(key: "token", value: this.token);
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
    }

    print("New family name: " + data.familyName);

    if (data.familyName != null) {
      print("creating new family");
      var createReq = await http.post(createFamilyURL,
          headers: {
            "authorization": "Bearer $token",
          },
          body: data.familyName);
      print(createReq.statusCode);
      if (createReq.statusCode == 200) {
        print("create family success");
      }
    } else if (data.inviteCode != null) {
      print("joining existing family: " + data.inviteCode);
      var joinReq = await http.put(joinFamilyURL + data.inviteCode, headers: {
        "Content-Type": "application/json",
        "authorization": "Bearer $token",
      });
      if (joinReq.statusCode == 200) {
        print("join family success");
      }
    }
    notifyListeners();
    callback();
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
