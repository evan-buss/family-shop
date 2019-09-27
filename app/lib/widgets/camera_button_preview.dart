import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:family_list/screens/camera/camera_screen.dart';
import 'package:family_list/screens/camera/picture_crop_screen.dart';

// CameraButtonPreview shows a square window that either has a button or an image
//  Clicking the window will open the camera to take a picture
class CameraButtonPreview extends StatefulWidget {
  final Function callback;
  final Uint8List previewImage;
  CameraButtonPreview(this.callback, {this.previewImage});

  @override
  _CameraButtonPreviewState createState() => _CameraButtonPreviewState();
}

class _CameraButtonPreviewState extends State<CameraButtonPreview> {
  String imagePath;

  Future<CameraDescription> _loadCameras() async {
    final cameras = await availableCameras();
    return cameras.first;
  }

  void _getImagePath(data) async {
    // Delete existing image if they take another one.
    if (imagePath != null) File(imagePath).delete();
    // Take a picture that is saved to the temp directory
    imagePath = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CameraScreen(camera: data)));
    // Show the crop screen if they have taken a photo
    if (imagePath != null) {
      imagePath = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PictureCropScreen(imagePath)));
      if (imagePath != null) {
        setState(() {});
        widget.callback(imagePath);
      }
    }
  }

  // Change the preview area based on the current state
  Widget _currentPreview() {
    if (imagePath == null) {
      // No new image or previous image
      if (widget.previewImage == null) {
        return Icon(Icons.save);
      }
      // Previous image loaded from API
      return Image.memory(widget.previewImage);
    }
    // New image taken
    return Image.file(File(imagePath));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CameraDescription>(
      future: _loadCameras(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: () => _getImagePath(snapshot.data),
            child: Container(
                height: 355.5,
                decoration: imagePath == null && widget.previewImage == null
                    ? BoxDecoration(color: Theme.of(context).primaryColorLight)
                    : null,
                child: _currentPreview()),
          );
        }
        return Container();
      },
    );
  }
}
