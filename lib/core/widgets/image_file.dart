import 'dart:io';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/show_image_file.dart';

class ImageFileB extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit boxFit;
  const ImageFileB(
      {super.key,
      required this.image,
      this.height,
      this.width,
      this.boxFit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showImageFile(context, imageUrl: image);
      },
      child: SizedBox(
        height: height,
        width: width,
        child: ImageFileView(image: image, boxFit: boxFit),
      ),
    );
  }
}

class ImageFileView extends StatelessWidget {
  const ImageFileView(
      {super.key, required this.image, this.boxFit = BoxFit.cover});

  final String image;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: FileImage(File(image)),
      fit: boxFit,
      frameBuilder: ((context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return SizedBox(
              width: double.infinity, height: double.infinity, child: child);
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          child: frame != null
              ? SizedBox(
                  width: double.infinity, height: double.infinity, child: child)
              : Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: double.infinity,
                  child: const CircularProgressIndicator(
                      color: bRed, strokeWidth: 10)),
        );
      }),
    );
  }
}
