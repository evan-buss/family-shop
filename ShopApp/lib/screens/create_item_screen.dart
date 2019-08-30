import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:family_list/models/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:family_list/util/text_styles.dart';
import 'package:family_list/widgets/camera_button_preview.dart';
import 'package:family_list/models/app_user.dart';
import 'package:family_list/models/list.dart';

class CreateItemScreen extends StatefulWidget {
  final ListItem listItem;

  CreateItemScreen({this.listItem});

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
  String imagePath;
  bool isEditMode = false;

  // Convert the image file to bytes
  Future<Uint8List> fileToBytes(String path) async {
    return await File(path).readAsBytes();
  }

  @override
  void initState() {
    if (widget.listItem != null) {
      isEditMode = true;
      _titleController.text = widget.listItem.title;
      _descriptionController.text = widget.listItem.description;
    }
    super.initState();
  }

  // Save item to API
  void _addItem(BuildContext context) async {
    list.addItem(
        ListItem(
          title: _titleController.text,
          description: _descriptionController.text,
          image: await fileToBytes(imagePath),
        ),
        appUser.token);
    Navigator.pop(context);
  }

  void _updateItem(BuildContext context) async {
    print("update item");
    print(widget.listItem.itemID);
    widget.listItem.title = _titleController.text;
    widget.listItem.description = _descriptionController.text;
    if (imagePath != null) {
      widget.listItem.image = await fileToBytes(imagePath);
    }
    list.updateItem(widget.listItem, appUser.token);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    appUser = Provider.of<AppUser>(context, listen: true);
    list = Provider.of<ActiveList>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(list.metaData.title +
            (isEditMode ? ": Update Item" : ": Create Item")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              isEditMode ? _updateItem(context) : _addItem(context);
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
              CameraButtonPreview((path) {
                setState(() {
                  imagePath = path;
                });
              }, previewImage: widget.listItem?.image),
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
