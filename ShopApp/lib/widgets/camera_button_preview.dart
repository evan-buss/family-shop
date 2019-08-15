import 'dart:async';
import 'dart:io';
import 'package:family_list/screens/camera_screen.dart';
import 'package:family_list/screens/picture_crop_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraButtonPreview extends StatefulWidget {
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
    imagePath = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CameraScreen(camera: data)));
    if (imagePath != null) {
      imagePath = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PictureCropScreen(imagePath)));
      if (imagePath != null) {
        setState(() {});
      }
    }
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
              decoration: imagePath == null
                  ? BoxDecoration(color: Theme.of(context).primaryColorLight)
                  : null,
              child: imagePath == null
                  ? Icon(Icons.camera_alt)
                  : Image.file(
                      File(imagePath),
                    ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
