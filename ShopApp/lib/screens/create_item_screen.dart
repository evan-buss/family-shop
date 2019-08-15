import 'package:camera/camera.dart';
import 'package:family_list/util/text_styles.dart';
import 'package:family_list/widgets/camera_button_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:family_list/models/app_user.dart';
import 'package:family_list/models/list.dart';

class CreateItemScreen extends StatefulWidget {
  @override
  _CreateItemScreenState createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  CameraController controller;

  AppUser appUser;
  ActiveList list;

  void _addItem(BuildContext context) {
    list.addItem(
        _titleController.text, _descriptionController.text, appUser.token);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    appUser = Provider.of<AppUser>(context, listen: true);
    list = Provider.of<ActiveList>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(list.metaData.title + ": Create Item"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check_circle),
            onPressed: () {
              _addItem(context);
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Take a picture
              CameraButtonPreview(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Item Information", style: h2),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Title",
                      style: h3,
                      textAlign: TextAlign.left,
                    ),
                    TextFormField(
                      controller: _titleController,
                      focusNode: _titleFocus,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Description", style: h3),
                    TextFormField(
                      controller: _descriptionController,
                      focusNode: _descriptionFocus,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
