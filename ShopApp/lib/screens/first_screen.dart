import 'package:family_list/screens/login_screen.dart';
import 'package:family_list/screens/signup_screen.dart';
import 'package:family_list/widgets/picture_card.dart';
import 'package:flutter/material.dart';

// This screens serves as the onboarding screen
// It prompts the user to do setup steps
class FirstScreen extends StatelessWidget {
  const FirstScreen();

  Widget _stepCard(String text, IconData icon, Function onTap,
      {bool halfsize = false}) {
    var _margins = EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16);
    if (halfsize) {
      _margins = EdgeInsets.only(top: 8, bottom: 8, left: 16);
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: _margins,
      // FIXME: The inkwell overlaps the border radius...
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(icon),
              ),
              Text(
                text,
                softWrap: true,
                textAlign: TextAlign.left,
              ),
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
        PictureCard(
          text: "Welcome to Family Shop",
          assetString: "assets/images/cart.png",
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: _stepCard("Create Account", Icons.create, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              }, halfsize: true),
            ),
            Expanded(
              child: _stepCard("Log In", Icons.account_box, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }),
            ),
          ],
        ),
        _stepCard("Create a family", Icons.people, () {
          print("Creating family");
        }),
        _stepCard("Invite members to your family to share lists.", Icons.list,
            () {
          print("Inviting peoples");
        })
      ],
    );
  }
}
