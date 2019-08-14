import 'dart:async';
import 'dart:io';
import 'package:family_list/screens/camera_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CameraDescription>(
      future: _loadCameras(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(color: Colors.teal),
              child: imagePath == null
                  ? Center(
                      child: IconButton(
                        icon: Icon(Icons.camera),
                        onPressed: () async {
                          imagePath = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CameraScreen(camera: snapshot.data)));
                          if (imagePath != null) {
                            setState(() {});
                          }
                        },
                      ),
                    )
                  : Image.file(File(imagePath)));
        }
        return Container();
      },
    );

    // return Container(
    //   width: 500,
    //   height: 500,
    //   child: Image.file(
    //     File(imagePath),
    //   ),
    // );
  }
}
