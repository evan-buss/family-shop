import 'package:family_list/screens/auth_screen.dart';
import 'package:flutter/material.dart';

// This screens serves as the onboarding screen
// It prompts the user to do setup steps
class FirstScreen extends StatelessWidget {
  const FirstScreen();

  Widget _stepCard(int step, String text, IconData icon, Function onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      // FIXME: The inkwell overlaps the border radius...
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(icon),
              ),
              Expanded(
                  child: Text(
                text,
                softWrap: true,
                textAlign: TextAlign.center,
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  "assets/images/list.png",
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Text("Welcome to Family Shop",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "ProductSans",
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        _stepCard(1, "Create an account or log in", Icons.account_box, () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AuthScreen()));
        }),
        _stepCard(2, "Create a family", Icons.people, () {
          print("Creating family");
        }),
        _stepCard(
            3, "Invite members to your family to share lists.", Icons.list, () {
          print("Inviting peoples");
        })
      ],
    );
  }
}

/*
StoreConnector<AppState, String>(
          converter: (store) => store.state.name,
          builder: (context, state) {
            return Text(state);
          },
        ),
        StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, callback) {
            return new FloatingActionButton(
              onPressed: () {
                final store = StoreProvider.of<AppState>(context);
                store.dispatch(UpdateNameAction("New Name"));
              },
              child: Icon(Icons.edit),
            );
          },
        )
*/
