import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';

class PictureCropScreen extends StatelessWidget {
  final cropKey = GlobalKey<CropState>();
  final File imageFile;
  File _croppedFile;

  PictureCropScreen(String imagePath) : imageFile = File(imagePath);

  void _cropImage(BuildContext context) async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // Resize to the desired resolution;
    final sampledFile = await ImageCrop.sampleImage(
      file: imageFile,
      preferredWidth: (1080 / scale).round(),
      preferredHeight: (1080 / scale).round(),
    );

    // Do Cropping
    _croppedFile = await ImageCrop.cropImage(file: sampledFile, area: area);

    imageFile.delete();
    sampledFile.delete();

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
              // image: Image.file(File(imageFile)),
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
