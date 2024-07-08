import 'package:flutter/material.dart';
import 'package:school_of_future/core/widgets/show_image_file.dart';

class ImageB extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Alignment? alignment;
  const ImageB(
      {super.key,
      required this.image,
      this.height,
      this.width,
      this.boxFit,
      this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showImageFile(context, imageUrl: image);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: alignment,
          child: SizedBox(
            height: height,
            width: width,
            child: Image.asset(
              image,
              fit: boxFit,
            ),
          ),
        ));
  }
}
