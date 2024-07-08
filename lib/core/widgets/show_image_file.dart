import 'package:flutter/material.dart';
import 'package:school_of_future/core/widgets/image_file.dart';

Future showImageFile(BuildContext context, {required String imageUrl}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(content: ImageFileView(image: imageUrl));
      });
}
