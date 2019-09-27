import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';

class PictureCropScreen extends StatelessWidget {
  final cropKey = GlobalKey<CropState>();
  final File imageFile;

  PictureCropScreen(String imagePath) : imageFile = File(imagePath);

  void _cropImage(BuildContext context) async {
    // final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // Do Cropping
    File _croppedFile = await ImageCrop.cropImage(file: imageFile, area: area);

    imageFile.delete();

    Navigator.pop(context, _croppedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crop Image"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Crop(
              key: cropKey,
              image: FileImage(imageFile),
              aspectRatio: 1.0 / 1.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Text(
                  "CANCEL",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  "CROP IMAGE",
                ),
                onPressed: () => _cropImage(context),
              ),
            ],
          )
        ],
      ),
    );
  }
}
