import 'package:email_validator/email_validator.dart';
import 'package:family_list/models/AuthData.dart';
import 'package:flutter/material.dart';

import 'package:family_list/widgets/utils.dart';

class PasswordField extends StatefulWidget {
  final FocusNode _passwordFocus;
  final AuthData _data;
  PasswordField(
    this._data,
    this._passwordFocus, {
    Key key,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      focusNode: widget._passwordFocus,
      obscureText: !passwordVisible,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a password';
        }
        return null;
      },
      onSaved: (value) => widget._data.password = value,
      decoration: InputDecoration(
        hintText: "Account Password",
        icon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: passwordVisible
              ? Icon(Icons.visibility)
              : Icon(Icons.visibility_off),
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  final FocusNode _emailFocus;
  final FocusNode _nextFocus;
  final AuthData _data;

  EmailField(this._emailFocus, this._nextFocus, this._data);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      focusNode: _emailFocus,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter an email";
        } else if (EmailValidator.validate(value) != true) {
          return "Invalid email address";
        }
        return null;
      },
      onFieldSubmitted: (term) =>
          fieldFocusChange(context, _emailFocus, _nextFocus),
      onSaved: (value) => _data.email = value,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: 'johnsmith@gmail.com', icon: Icon(Icons.people)),
    );
  }
}
