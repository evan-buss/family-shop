import 'package:family_list/util/text_styles.dart';
import 'package:flutter/material.dart';

/// PictureCard displays an image with text underneath it
///
/// Requires a title string and an asset string for photo location
class PictureCard extends StatelessWidget {
  final String text;
  final String assetString;
  PictureCard({this.text, this.assetString});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(assetString),
            Text(text, style: h3),
          ],
        )),
      ),
    );
  }
}
