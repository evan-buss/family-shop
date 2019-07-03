import 'package:flutter/material.dart';
import 'package:family_list/redux/actions.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:family_list/redux/state.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In or Sign Up"),
      ),
      body: StoreConnector<AppState, VoidCallback>(
        converter: (store) {
          return () => store.dispatch(Actions.ToggleLoggedInStatus);
        },
        builder: (context, callback) {
          return Center(
            child: RaisedButton(
                child: Text("SIGN IN"),
                onPressed: () {
                  Navigator.pop(context);
                  callback();
                }),
          );
        },
      ),
    );
  }
}
