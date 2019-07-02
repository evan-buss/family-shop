import 'package:family_list/redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:family_list/redux/state.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Column(
      children: <Widget>[
        StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return Text(state.name);
          },
        ),
        StoreConnector<AppState, String>(
          converter: (store) {
            store.dispatch(UpdateNameAction("Isaac Buss"));
          },
          builder: (context, callback) {
            return new FloatingActionButton(
              onPressed: () {
                callback;
              },
              child: Icon(Icons.edit),
            );
          },
        )
      ],
    ));
  }
}
