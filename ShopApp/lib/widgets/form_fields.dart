import 'package:email_validator/email_validator.dart';
import 'package:family_list/models/AppUser.dart';
import 'package:flutter/material.dart';
import 'package:family_list/util/text_styles.dart';

import 'package:family_list/widgets/utils.dart';

class PasswordField extends StatefulWidget {
  final FocusNode _passwordFocus;
  final LoginData _data;
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
      autovalidate: true,
      obscureText: !passwordVisible,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a password';
        } else if (value.length < 6) {
          return 'Passwords must be atleast 6 characters';
        }
        return null;
      },
      onSaved: (value) => widget._data.password = value.trim(),
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
  final LoginData _data;

  EmailField(this._emailFocus, this._nextFocus, this._data);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      autovalidate: true,
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
      onSaved: (value) => _data.email = value.trim(),
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: 'johnsmith@gmail.com', icon: Icon(Icons.email)),
    );
  }
}

class FamilyCreateFields extends StatefulWidget {
  final SignUpData data;
  FamilyCreateFields(this.data);
  @override
  _FamilyCreateFieldsState createState() => _FamilyCreateFieldsState();
}

/// Display a toggle switch to switch between creating a new family or joining an existing family.
class _FamilyCreateFieldsState extends State<FamilyCreateFields> {
  bool createNew = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "Join Existing",
              style: h3,
            ),
            Switch(
              value: createNew,
              onChanged: (bool isToggled) {
                if (isToggled) {
                  widget.data.familyName = null;
                } else {
                  widget.data.inviteCode = null;
                }
                setState(() {
                  createNew = isToggled;
                });
              },
            ),
            Text("Create New", style: h3)
          ],
        ),
        createNew ? CreateFamily(widget.data) : JoinFamily(widget.data)
      ],
    );
  }
}

/// Create a brand new family.
class CreateFamily extends StatelessWidget {
  final SignUpData _data;

  CreateFamily(this._data);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0, top: 24.0),
          child: Column(
            children: <Widget>[
              Text(
                "Family Name",
                style: h3,
              ),
              TextFormField(
                autocorrect: false,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a family name.';
                  }
                  return null;
                },
                onSaved: (value) => _data.familyName = value.trim(),
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    hintText: 'Smith Family', icon: Icon(Icons.people)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Join an existing family by invite code.
class JoinFamily extends StatelessWidget {
  final SignUpData _data;

  JoinFamily(this._data);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Family Invite Code",
          style: h3,
        ),
        TextFormField(
          autocorrect: false,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a family description.';
            }
            return null;
          },
          onSaved: (value) => _data.inviteCode = value.trim(),
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration:
              InputDecoration(hintText: '312312312', icon: Icon(Icons.people)),
        ),
      ],
    );
  }
}
